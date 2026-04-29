#!/usr/bin/env python3
"""
ghee.py - Interactive TUI for fuzzy-searching shell commands.

Provides a Rich-powered interface to search, select, and copy shell shortcuts
from the ghee registry. Supports custom commands, usage tracking, and AI-assisted
command generation via Ollama.
"""

import os
import sys
import re
import subprocess
import json
import time
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Any

try:
    from rich.console import Console
    from rich.table import Table
    from rich.panel import Panel
    from rich.text import Text
    from rich.prompt import Confirm
    from rich import box
    RICH_AVAILABLE = True
except ImportError:
    RICH_AVAILABLE = False

# Fallback print functions if rich is not available
if not RICH_AVAILABLE:
    def print_err(msg: str) -> None: print(f"[ERR] {msg}", file=sys.stderr)
    def print_ok(msg: str) -> None: print(f"[ok] {msg}")
    def print_info(msg: str) -> None: print(f"[..] {msg}")
    def print_warn(msg: str) -> None: print(f"[WARNING] {msg}")
else:
    console = Console()
    _err_console = Console(stderr=True)
    def print_err(msg: str) -> None: _err_console.print(f"[bold red][ERR][/bold red] {msg}")
    def print_ok(msg: str) -> None: console.print(f"[bold green][ok][/bold green] {msg}")
    def print_info(msg: str) -> None: console.print(f"[bold cyan][..][/bold cyan] {msg}")
    def print_warn(msg: str) -> None: console.print(f"[bold yellow][WARNING][/bold yellow] {msg}")

CUSTOM_FILE = Path.home() / ".ghee-custom"
STATS_FILE = Path.home() / ".ghee-stats.json"
CACHE_FILE = Path.home() / ".ghee-registry-cache.json"
CONFIG_FILE = Path.home() / ".ghee-config.json"

def load_stats() -> Dict[str, int]:
    """Load usage statistics from the stats file."""
    if STATS_FILE.exists():
        try:
            return json.loads(STATS_FILE.read_text())
        except (json.JSONDecodeError, IOError) as e:
            print_err(f"Corrupted stats file: {e}")
            return {}
    return {}

def record_usage(key: str) -> None:
    """Record usage of a command for ranking popular commands."""
    try:
        stats = load_stats()
        stats[key] = stats.get(key, 0) + 1
        STATS_FILE.write_text(json.dumps(stats, indent=2))
    except IOError as e:
        print_err(f"Failed to record usage: {e}")

def load_config() -> Dict[str, Any]:
    """Load user configuration from ~/.ghee-config.json."""
    if CONFIG_FILE.exists():
        try:
            return json.loads(CONFIG_FILE.read_text())
        except (json.JSONDecodeError, IOError) as e:
            print_err(f"Corrupted config file: {e}")
            return {}
    return {}

def validate_command_input(cmd: str) -> Tuple[bool, str]:
    """
    Validate a command for safety before adding to registry.
    
    Returns:
        Tuple of (is_valid, error_message)
    """
    if not cmd or not cmd.strip():
        return False, "Command cannot be empty"
    
    if len(cmd) > 500:
        return False, "Command too long (max 500 characters)"
    
    # Check for obviously dangerous patterns
    dangerous_patterns = [
        (r'rm\s+(-rf?|--force)\s+/', "Deleting root files is not allowed"),
        (r'mkfs', "Formatting disks is not allowed"),
        (r'dd\s+if=', "Using dd is not allowed"),
        (r'>/dev/sd', "Writing to block devices is not allowed"),
        (r'chmod\s+777\s+/', "World-writable permissions on root is not allowed"),
        (r'wget.*\|\s*(ba)?sh', "Piping wget to shell is not allowed"),
        (r'curl.*\|\s*(ba)?sh', "Piping curl to shell is not allowed"),
    ]
    
    cmd_lower = cmd.lower()
    for pattern, message in dangerous_patterns:
        if re.search(pattern, cmd_lower):
            return False, message
    
    return True, ""

def validate_alias_input(alias: str) -> Tuple[bool, str]:
    """Validate an alias for safety and correctness."""
    if not alias or not alias.strip():
        return False, "Alias cannot be empty"
    
    if len(alias) > 100:
        return False, "Alias too long (max 100 characters)"
    
    # Allow alphanumeric, spaces, hyphens, underscores, dots
    if not re.match(r'^[a-zA-Z0-9\s\-_.]+$', alias):
        return False, "Alias contains invalid characters (only alphanumeric, spaces, hyphens, underscores, dots allowed)"
    
    return True, ""

def validate_desc_input(desc: str) -> Tuple[bool, str]:
    """Validate a description string."""
    if not desc or not desc.strip():
        return False, "Description cannot be empty"
    
    if len(desc) > 200:
        return False, "Description too long (max 200 characters)"
    
    return True, ""

def load_registry() -> Dict[str, Dict[str, str]]:
    """
    Load built-in commands from ghee modules and custom commands.

    Reads all `.sh` files in the `modules` directory to extract predefined aliases
    and their corresponding commands/descriptions. Also reads `~/.ghee-custom`
    to append any user-defined shortcuts.

    Uses caching to speed up subsequent loads. Cache is invalidated if module
    files have been modified since the last cache was written.

    Returns:
        dict: A dictionary where keys are alias names, and values are dicts
              containing 'cmd' (the bash command) and 'desc' (a brief description).
    """
    config = load_config()
    use_cache = config.get("enable_cache", True)
    cache_ttl = config.get("cache_ttl_seconds", 300)  # 5 minutes default

    if use_cache:
        cached = load_registry_cache()
        if cached and not cache_needs_rebuild(cache_ttl):
            return cached

    registry = {}

    script_dir = Path(__file__).parent.absolute()
    modules_dir = script_dir / "modules"

    if modules_dir.exists():
        for mod_file in modules_dir.glob("*.sh"):
            try:
                content = mod_file.read_text()
                matches = re.finditer(r'_GG_REGISTRY\["(.*?)"\]="(.*?)\|\|\|(.*?)"', content)
                for m in matches:
                    key = m.group(1).strip()
                    cmd = m.group(2).strip()
                    desc = m.group(3).strip()
                    registry[key] = {"cmd": cmd, "desc": desc, "module": mod_file.stem}
            except IOError as e:
                print_err(f"Failed to read module {mod_file}: {e}")

    # Load custom
    if CUSTOM_FILE.exists():
        try:
            for line in CUSTOM_FILE.read_text().splitlines():
                if "|||" in line:
                    parts = line.split("|||")
                    if len(parts) >= 3:
                        # format: key|||cmd|||desc
                        registry[parts[0].strip()] = {
                            "cmd": parts[1].strip(),
                            "desc": parts[2].strip(),
                            "module": "custom"
                        }
        except IOError as e:
            print_err(f"Failed to read custom file: {e}")

    # Save to cache
    if use_cache:
        save_registry_cache(registry)

    return registry

def load_registry_cache() -> Optional[Dict[str, Dict[str, str]]]:
    """Load registry from cache if available."""
    if CACHE_FILE.exists():
        try:
            cache_data = json.loads(CACHE_FILE.read_text())
            return cache_data.get("registry")
        except (json.JSONDecodeError, IOError):
            pass
    return None

def cache_needs_rebuild(ttl_seconds: int = 300) -> bool:
    """Check if cache needs to be rebuilt based on TTL and file modifications."""
    if not CACHE_FILE.exists():
        return True

    try:
        cache_data = json.loads(CACHE_FILE.read_text())
        cache_time = cache_data.get("timestamp", 0)
        current_time = time.time()

        if current_time - cache_time > ttl_seconds:
            return True

        # Check if any module files have been modified since cache was created
        script_dir = Path(__file__).parent.absolute()
        modules_dir = script_dir / "modules"
        if modules_dir.exists():
            for mod_file in modules_dir.glob("*.sh"):
                if mod_file.stat().st_mtime > cache_time:
                    return True

        # Check if custom file was modified
        if CUSTOM_FILE.exists() and CUSTOM_FILE.stat().st_mtime > cache_time:
            return True

        return False
    except (json.JSONDecodeError, IOError, KeyError):
        return True

def save_registry_cache(registry: Dict[str, Dict[str, str]]) -> None:
    """Save registry to cache file."""
    try:
        cache_data = {
            "registry": registry,
            "timestamp": time.time(),
            "version": "1.0"
        }
        CACHE_FILE.write_text(json.dumps(cache_data, indent=2))
    except IOError as e:
        print_err(f"Failed to save cache: {e}")

def is_system_command(name: str) -> bool:
    """Check if a command name is already a system command, alias, or function."""
    # Check for binaries in PATH
    import shutil
    if shutil.which(name):
        return True
    
    # Check for shell builtins/aliases/functions by invoking a shell
    try:
        # Use 'command -v' which works in most POSIX shells
        result = subprocess.run(
            ["bash", "-c", f"command -v {name}"],
            capture_output=True, text=True, timeout=2
        )
        return result.returncode == 0
    except Exception:
        return False

def get_system_command_detail(name: str) -> str:
    """Get the detail of what a system command/alias/function actually is."""
    try:
        # 'type -a' shows all occurrences including aliases and functions
        result = subprocess.run(
            ["bash", "-c", f"type -a {name}"],
            capture_output=True, text=True, timeout=2
        )
        if result.returncode == 0:
            # Clean up output to show just the relevant info
            lines = result.stdout.strip().splitlines()
            return " | ".join(lines)
    except Exception:
        pass
    
    import shutil
    path = shutil.which(name)
    return str(path) if path else "Unknown system command"

def add_custom(cmd: str, alias: str, registry: Optional[Dict[str, Any]] = None) -> None:
    """
    Add a custom shortcut to the registry.

    Validates inputs for safety and correctness before adding to the custom file.
    Detects clashes with system commands and existing aliases.

    Args:
        cmd: The full command to shortcut (e.g. 'ollama list')
        alias: The short alias name (e.g. 'olist')
        registry: The current registry (optional, will be loaded if not provided)
    """
    # Validate inputs
    cmd_valid, cmd_err = validate_command_input(cmd)
    if not cmd_valid:
        print_err(f"Invalid command: {cmd_err}")
        sys.exit(1)

    alias_valid, alias_err = validate_alias_input(alias)
    if not alias_valid:
        print_err(f"Invalid alias: {alias_err}")
        sys.exit(1)

    # Check for clashes
    if registry is None:
        registry = load_registry()

    clash_msg = ""
    detail_msg = ""
    is_custom = False
    
    if alias in registry:
        module = registry[alias].get("module", "unknown")
        existing_cmd = registry[alias].get("cmd", "unknown")
        is_custom = (module == "custom")
        clash_msg = f"Alias '{alias}' already exists in Ghee (module: {module})."
        detail_msg = f"Runs: {existing_cmd}"
    elif is_system_command(alias):
        clash_msg = f"Alias '{alias}' clashes with a system command, alias, or function."
        detail_msg = get_system_command_detail(alias)

    if clash_msg:
        print_warn(clash_msg)
        if RICH_AVAILABLE:
            console.print(f"[bold cyan]Detail:[/bold cyan] {detail_msg}")
            if not Confirm.ask("Do you want to overwrite it?"):
                print_info("Operation cancelled.")
                return
        else:
            print(f"Detail: {detail_msg}")
            choice = input("Do you want to overwrite it? (y/N): ").lower()
            if choice != 'y':
                print_info("Operation cancelled.")
                return

    # If it was a custom alias, remove old entries first to avoid duplicates
    if is_custom and CUSTOM_FILE.exists():
        lines = CUSTOM_FILE.read_text().splitlines()
        new_lines = [l for l in lines if l.strip() and l.split("|||")[0].strip() != alias]
        CUSTOM_FILE.write_text("\n".join(new_lines) + ("\n" if new_lines else ""))

    try:
        with open(CUSTOM_FILE, "a") as f:
            f.write(f"{alias}|||{cmd}|||{cmd}\n")
        print_ok(f"Added: [bold]{alias}[/bold] -> {cmd}" if RICH_AVAILABLE else f"Added: {alias} -> {cmd}")
        print_info(f"Saved to {CUSTOM_FILE}")
        
        # Invalidate cache after adding custom command
        if CACHE_FILE.exists():
            try:
                CACHE_FILE.unlink()
            except IOError:
                pass
    except IOError as e:
        print_err(f"Failed to write to custom file: {e}")
        sys.exit(1)

def remove_custom(alias: str) -> None:
    """
    Remove a custom shortcut from the registry by alias name.
    """
    if not CUSTOM_FILE.exists():
        print_err("No custom shortcuts file found.")
        sys.exit(1)

    lines = CUSTOM_FILE.read_text().splitlines()
    new_lines = []
    found = False
    for line in lines:
        if not line.strip():
            continue
        key = line.split("|||")[0].strip()
        if key == alias:
            found = True
        else:
            new_lines.append(line)

    if not found:
        print_err(f"Alias '{alias}' not found in custom shortcuts.")
        sys.exit(1)

    CUSTOM_FILE.write_text("\n".join(new_lines) + ("\n" if new_lines else ""))
    print_ok(f"Removed: [bold]{alias}[/bold]" if RICH_AVAILABLE else f"Removed: {alias}")

    # Invalidate cache
    if CACHE_FILE.exists():
        try:
            CACHE_FILE.unlink()
        except IOError:
            pass

def list_custom() -> None:
    """List all custom shortcuts."""
    if not CUSTOM_FILE.exists() or not CUSTOM_FILE.read_text().strip():
        print_info("No custom shortcuts. Add one with: G -a <alias> <command>")
        return

    lines = CUSTOM_FILE.read_text().splitlines()
    if RICH_AVAILABLE:
        table = Table(box=box.SIMPLE_HEAD, show_header=True, title="Custom Shortcuts")
        table.add_column("Alias", style="bold green")
        table.add_column("Command", style="cyan")
        for line in lines:
            if not line.strip() or "|||" not in line:
                continue
            parts = line.split("|||")
            alias = parts[0].strip()
            cmd = parts[1].strip() if len(parts) > 1 else ""
            table.add_row(alias, cmd)
        console.print(table)
    else:
        print("Custom Shortcuts:")
        for line in lines:
            if not line.strip() or "|||" not in line:
                continue
            parts = line.split("|||")
            alias = parts[0].strip()
            cmd = parts[1].strip() if len(parts) > 1 else ""
            print(f"  {alias:<16} {cmd}")

def run_update() -> None:
    """Self-update ghee via git pull and re-run setup."""
    script_dir = Path(__file__).parent.absolute()
    print_info("Updating ghee...")
    try:
        result = subprocess.run(
            ["git", "pull", "--rebase"],
            cwd=str(script_dir),
            capture_output=True, text=True, timeout=30
        )
        if result.returncode == 0:
            print_ok(f"Git: {result.stdout.strip()}")
        else:
            print_err(f"Git pull failed: {result.stderr.strip()}")
            return

        setup = script_dir / "setup-ghee"
        if setup.exists():
            print_info("Running setup-ghee...")
            subprocess.run([str(setup)], cwd=str(script_dir), timeout=60)
        print_ok("Update complete. Reload your shell: source ~/.zshrc")
    except subprocess.TimeoutExpired:
        print_err("Update timed out.")
    except Exception as e:
        print_err(f"Update failed: {e}")

def score_match(query: str, key: str, cmd: str, desc: str) -> int:
    """
    Score the match of a query against a command alias, actual command, and description.

    Implements an improved word-overlap fuzzy scoring algorithm.
    Higher scores indicate a better match. Exact alias matches get the highest score.

    Args:
        query (str): The search string provided by the user.
        key (str): The alias name.
        cmd (str): The underlying shell command.
        desc (str): A description of what the command does.

    Returns:
        int: The match score (0 if no match at all).
    """
    query = query.lower().strip()
    key = key.lower()
    cmd = cmd.lower()
    desc = desc.lower()

    if not query:
        return 0

    score = 0

    # Exact matches get highest priority
    if cmd == query:
        score += 1000
    if key == query:
        score += 900

    # Substring matches
    if query in cmd:
        score += 500
    if cmd in query and cmd:
        score += 400
    if query in key:
        score += 300
    if query in desc:
        score += 200

    # Word-level matching (more nuanced)
    query_words = query.split()
    cmd_words = cmd.split()
    desc_words = desc.split()
    key_words = re.split(r'[\s\-_]+', key)

    for qword in query_words:
        if len(qword) < 2:  # Skip very short words
            continue

        # Check for substring matches in any word (fuzzy)
        for cword in cmd_words:
            if qword in cword or cword in qword:
                score += 75
                break

        for dword in desc_words:
            if qword in dword or dword in qword:
                score += 40
                break

        for kword in key_words:
            if qword in kword or kword in qword:
                score += 50
                break

    # Consecutive character bonus (for partial typing)
    for i in range(len(query) - 2):
        substr = query[i:i+3]
        if substr in cmd:
            score += 20
        if substr in key:
            score += 15

    return score

def get_ollama_model(requested_model: Optional[str] = None) -> Optional[str]:
    """
    Get the preferred Ollama model from cache, auto-detection, or user override.

    Args:
        requested_model: Optional model name to override the default/cached selection.
        
    Returns:
        The name of the model to use, or None if no models are available.
    """
    import urllib.request
... (rest of the function as is, but I'll provide the full block for replacement)
    config = load_config()
    
    # 1. Fetch available models from Ollama
    available_models = []
    try:
        req = urllib.request.Request("http://localhost:11434/api/tags")
        with urllib.request.urlopen(req, timeout=2) as response:
            data = json.loads(response.read().decode(\'utf-8\'))
            available_models = [m[\'name\'] for m in data.get(\'models\', [])]
    except Exception:
        return None

    if not available_models:
        return None

    # 2. If user provided an override, use it (if it exists)
    if requested_model:
        matched = None
        for m in available_models:
            if m == requested_model or m.startswith(requested_model + ":"):
                matched = m
                break
        
        if matched:
            config["preferred_ollama_model"] = matched
            save_config(config)
            return matched
        else:
            print_warn(f"Model \'{requested_model}\' not found. Falling back...")
    
    # 3. Check config for cached selection
    cached_model = config.get("preferred_ollama_model")
    if cached_model:
        # Verify it still exists
        if cached_model in available_models or any(m.startswith(cached_model + ":") for m in available_models):
            return cached_model

    # 4. Auto-detect from preference list
    for pref in [\'qwen2.5\', \'llama3.2\', \'llama3\', \'mistral\', \'codellama\']:
        for m in available_models:
            if m.startswith(pref):
                config["preferred_ollama_model"] = m
                save_config(config)
                return m
    
    # 5. Fallback to first available
    best = available_models[0]
    config["preferred_ollama_model"] = best
    save_config(config)
    return best

def ask_ollama(query: str, model: str) -> Optional[str]:
    """
    Query Ollama to convert a natural language idea into a shell command.

    Args:
        query: The natural language description of the desired command.
        model: The name of the Ollama model to use for generation.

    Returns:
        A string containing the generated shell command, or None on failure.
    """
    import urllib.request
    try:
        url = "http://localhost:11434/api/generate"
        prompt = f"Convert this natural language idea into a single, valid bash/shell command for macOS/Linux. Output ONLY the command, no markdown formatting, no backticks, no explanations. Idea: {query}"
        data = {
            "model": model,
            "prompt": prompt,
            "stream": False
        }
        req = urllib.request.Request(url, data=json.dumps(data).encode(\'utf-8\'), headers={\'Content-Type\': \'application/json\'})
        with urllib.request.urlopen(req, timeout=15) as response:
            result = json.loads(response.read().decode(\'utf-8\'))
            command = result.get(\'response\', \'\').strip()
            if command.startswith(\'```\') and command.endswith(\'```\'):
                command = command.strip(\'`\').strip()
                if command.startswith(\'bash\'):
                    command = command[4:].strip()
            return command
    except Exception:
        return None

def save_config(config: Dict[str, Any]) -> None:
    """Save user configuration to ~/.ghee-config.json."""
    try:
        CONFIG_FILE.write_text(json.dumps(config, indent=2))
    except IOError as e:
        print_err(f"Failed to save config: {e}")

def getch() -> str:
    """Read a single keypress (Cross-platform)."""
    if sys.platform == "win32":
        import msvcrt
        return msvcrt.getch().decode('utf-8', 'ignore')
    else:
        import termios, tty
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
        try:
            tty.setraw(sys.stdin.fileno())
            ch = sys.stdin.read(1)
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        return ch

def copy_to_clipboard(text: str) -> bool:
    """
    Copy text to the system clipboard.
    
    Args:
        text: The text to copy
        
    Returns:
        True if successful, False otherwise
    """
    try:
        if sys.platform == "darwin":
            subprocess.run(["pbcopy"], input=text.encode("utf-8"), check=True, timeout=5)
            return True
        elif sys.platform == "win32" or sys.platform == "cygwin" or sys.platform == "msys":
            subprocess.run(["clip.exe"], input=text.encode("utf-8"), check=True, timeout=5)
            return True
        elif sys.platform.startswith("linux"):
            # Try xclip first, then xsel
            try:
                subprocess.run(["xclip", "-selection", "clipboard"], 
                             input=text.encode("utf-8"), check=True, timeout=5)
                return True
            except FileNotFoundError:
                subprocess.run(["xsel", "--clipboard", "--input"], 
                             input=text.encode("utf-8"), check=True, timeout=5)
                return True
    except FileNotFoundError:
        print_err("No clipboard utility found. Install xclip or xsel on Linux.")
    except subprocess.TimeoutExpired:
        print_err("Clipboard operation timed out.")
    except Exception as e:
        print_err(f"Failed to copy to clipboard: {e}")
    return False

def run_ollama(query: str, model_override: Optional[str] = None):
    """
    Explicitly ask Ollama to generate and optionally run a command.

    Prompts the user to run, copy, or cancel after generating the command.

    Args:
        query: The natural language idea to convert.
        model_override: Optional model name to use instead of the default/cached selection.
    """
    model = get_ollama_model(model_override)
    if not model:
        print_err("No active Ollama models found. Is Ollama running?")
        return
        
    cmd = ask_ollama(query, model)
    if cmd:
        if RICH_AVAILABLE:
            console.print(Panel(f"[bold green]{cmd}[/bold green]", 
                               title=f"🤖 AI Suggestion ({model})", 
                               box=box.ROUNDED, expand=False))
            console.print("[dim]Press [bold]Enter[/bold] to run, [bold]Esc[/bold] to cancel, [bold]c[/bold] to copy...[/dim]")
        else:
            print(f"\n--- AI Suggestion ({model}) ---")
            print(f"  {cmd}")
            print("Press Enter to run, Esc to cancel, or c to copy...")

        while True:
            ch = getch()
            if ch == '\r' or ch == '\n':
                print_info(f"Running: {cmd}")
                os.system(cmd)
                return
            elif ch == '\x1b':  # Escape
                print_info("Cancelled.")
                return
            elif ch.lower() == 'c':
                copy_to_clipboard(cmd)
                print_info("Copied to clipboard.")
                return
    else:
        print_err("Failed to generate a command.")

def best_guess(query: str, registry: Dict[str, Dict[str, str]]) -> None:
    """
    Finds the best matching command for the given query and presents it.

    If it finds matches, it shows the highest-scoring match and up to 4 alternatives.
    It automatically copies the best match command to the user's clipboard.

    Args:
        query (str): The search query to look up.
        registry (dict): The loaded command registry containing available aliases.
    """
    best_key = None
    best_score = 0
    stats = load_stats()
    config = load_config()
    auto_copy = config.get("auto_copy_to_clipboard", True)

    scores = []
    for key, data in registry.items():
        s = score_match(query, key, data["cmd"], data["desc"])
        if s > 0:
            # Boost score based on usage frequency (capped at 200 points max)
            s += min(200, stats.get(key, 0) * 10)
            scores.append((s, key, data))

    scores.sort(key=lambda x: x[0], reverse=True)

    if not scores or scores[0][0] < 150:
        print_warn(f"No strong match found for: '{query}'")
        print_info("Try interactive search, use -a to add it, or use -o to ask AI.")
        return

    best_match = scores[0]

    if RICH_AVAILABLE:
        panel_content = Text()
        panel_content.append(f"{best_match[1]}\n", style="bold green")
        panel_content.append(f"runs:  ", style="dim")
        panel_content.append(f"{best_match[2]['cmd']}\n")
        panel_content.append(f"what:  ", style="dim")
        panel_content.append(f"{best_match[2]['desc']}")

        console.print(Panel(panel_content, 
                           title=f"Ghee best guess for [bold cyan]'{query}'", 
                           expand=False, box=box.ROUNDED))

        if len(scores) > 1:
            console.print("  [dim]see also:[/dim]")
            for i in range(1, min(5, len(scores))):
                console.print(f"    [yellow]{scores[i][1]:<16}[/yellow] {scores[i][2]['desc']}")
            console.print()
    else:
        print(f"\n--- Ghee best guess for '{query}' ---")
        print(f"  {best_match[1]}")
        print(f"  runs:  {best_match[2]['cmd']}")
        print(f"  what:  {best_match[2]['desc']}\n")
        if len(scores) > 1:
            print("  see also:")
            for i in range(1, min(5, len(scores))):
                print(f"    {scores[i][1]:<16} {scores[i][2]['desc']}")
            print()

    # Ask for confirmation before copying/running
    if RICH_AVAILABLE:
        console.print("[dim]Press [bold]Enter[/bold] to copy, [bold]r[/bold] to run, [bold]Esc[/bold] to cancel...[/dim]")
        
        while True:
            ch = getch()
            if ch == '\r' or ch == '\n':
                # Copy to clipboard
                if auto_copy:
                    copy_to_clipboard(best_match[1])
                    print_info(f"Copied '{best_match[1]}' to clipboard.")
                    record_usage(best_match[1])
                return
            elif ch.lower() == 'r':
                # Run the command
                print_info(f"Running: {best_match[2]['cmd']}")
                os.system(best_match[2]['cmd'])
                record_usage(best_match[1])
                return
            elif ch == '\x1b':  # Escape
                print_info("Cancelled.")
                return
    else:
        # Copy to clipboard (legacy behavior for non-rich mode)
        if auto_copy:
            copy_to_clipboard(best_match[1])
            print_info(f"Copied '{best_match[1]}' to clipboard.")
            record_usage(best_match[1])

def interactive_mode(registry):
    """
    A Rich-powered interactive Read-Eval-Print Loop (REPL) for fuzzy finding commands.
    
    Provides a real-time search interface, filtering and scoring the registry based
    on user input. Requires the `rich` library.
    
    Args:
        registry (dict): The complete command registry.
    """
    if not RICH_AVAILABLE:
        print_err("Interactive mode requires 'rich'. Please install it: pip install rich")
        print_info("Falling back to listing all commands.")
        for k, v in registry.items():
            print(f"{k:<15} {v['desc']}")
        return

    from rich.prompt import Prompt
    stats = load_stats()
    
    console.clear()
    console.print(Panel("[bold magenta]Ghee[/bold magenta] - Interactive Shell\nType to search, or 'quit' to exit.", box=box.ROUNDED, expand=False))
    
    while True:
        try:
            query = Prompt.ask("\n[bold cyan]>[/bold cyan] Search")
            if query.lower() in ['q', 'quit', 'exit']:
                break
                
            scores = []
            for key, data in registry.items():
                s = score_match(query, key, data["cmd"], data["desc"])
                # If query is empty, show everything (score=1)
                if not query: s = 1
                if s > 0:
                    s += min(200, stats.get(key, 0) * 10)
                    scores.append((s, key, data))
            
            scores.sort(key=lambda x: x[0], reverse=True)
            
            table = Table(box=box.SIMPLE_HEAD, show_header=False)
            table.add_column("Command", style="bold green")
            table.add_column("Runs", style="dim")
            table.add_column("Description", style="white")
            
            for s, key, data in scores[:15]:
                table.add_row(key, data["cmd"], data["desc"])
                
            console.print(table)
            
            if len(scores) > 15:
                console.print(f"[dim]... and {len(scores) - 15} more matches.[/dim]")
                
        except (KeyboardInterrupt, EOFError):
            break

def sync_custom(gist_url=None):
    """
    Sync custom commands from a GitHub Gist.
    If gist_url is not provided, it tries to read the saved URL.
    """
    sync_file = Path.home() / ".ghee-sync.json"
    
    if not gist_url:
        if sync_file.exists():
            gist_url = json.loads(sync_file.read_text()).get("gist_url")
        if not gist_url:
            print_err("No Gist URL provided or saved. Usage: G --sync <gist_url>")
            return
            
    import urllib.request
    print_info(f"Syncing custom shortcuts from {gist_url}...")
    
    try:
        # Convert GitHub Gist UI URL to raw URL if necessary
        if "gist.github.com" in gist_url and "/raw" not in gist_url:
            gist_url = gist_url.rstrip("/") + "/raw"
            
        req = urllib.request.Request(gist_url)
        with urllib.request.urlopen(req, timeout=10) as response:
            content = response.read().decode('utf-8')
            
            with open(CUSTOM_FILE, "w") as f:
                f.write(content)
                
            sync_file.write_text(json.dumps({"gist_url": gist_url}))
            print_ok("Custom shortcuts synced successfully.")
    except Exception as e:
        print_err(f"Failed to sync: {e}")


def get_modules_info() -> List[Dict[str, str]]:
    """Parse module files to extract headers and descriptions."""
    script_dir = Path(__file__).parent.absolute()
    modules_dir = script_dir / "modules"
    modules = []
    
    if modules_dir.exists():
        for mod_file in modules_dir.glob("*.sh"):
            try:
                content = mod_file.read_text()
                name_match = re.search(r'# Module:\s*(.+)', content)
                desc_match = re.search(r'# Description:\s*(.+)', content)
                
                name = name_match.group(1).strip() if name_match else mod_file.stem
                desc = desc_match.group(1).strip() if desc_match else "No description available."
                
                modules.append({
                    "id": mod_file.stem,
                    "name": name,
                    "desc": desc
                })
            except IOError:
                pass
                
    modules.sort(key=lambda x: x["id"])
    return modules

def show_help():
    """Show help with list of modules."""
    if RICH_AVAILABLE:
        console.print(Panel("[bold magenta]Ghee[/bold magenta] - Shell Shortcut Manager", expand=False, box=box.ROUNDED))
        console.print("\n[bold]Usage:[/bold]")
        console.print("  [cyan]G[/cyan]                        Interactive fuzzy search")
        console.print("  [cyan]G <query>[/cyan]                Fuzzy search for a specific command")
        console.print("  [cyan]G -a <alias> <cmd>[/cyan]       Add a custom shortcut (works instantly)")
        console.print("  [cyan]G -rm <alias>[/cyan]            Remove a custom shortcut")
        console.print("  [cyan]G ls[/cyan]                     List all custom shortcuts")
        console.print("  [cyan]G -q <idea> [--model M][/cyan] Ask Ollama AI to generate a command")
        console.print("  [cyan]G --sync <url>[/cyan]           Sync custom commands from a Gist")
        console.print("  [cyan]G info <module>[/cyan]          Show aliases for a specific module")
        console.print("  [cyan]G update[/cyan]                 Self-update ghee via git pull")
        console.print("  [cyan]G --help[/cyan]                 Show this help message")
        
        console.print("\n[bold]Available Modules:[/bold]")
        table = Table(box=box.SIMPLE_HEAD, show_header=True)
        table.add_column("ID", style="cyan")
        table.add_column("Name", style="bold")
        table.add_column("Description", style="dim")
        
        for mod in get_modules_info():
            table.add_row(mod["id"], mod["name"], mod["desc"])
            
        console.print(table)
    else:
        print("Ghee - Shell Shortcut Manager")
        print("Usage: G [query | -q <idea> [--model M] | -a <alias> <cmd> | -rm <alias> | ls | update | --sync <url> | info <module> | --help]")
        print("\nAvailable Modules:")
        for mod in get_modules_info():
            print(f"  {mod['id']:<20} {mod['desc']}")

def show_module_info(module_id: str, registry: Dict[str, Dict[str, str]]):
# ... (omitting for brevity in this specific tool call, will use full block below)
def main():
    args = sys.argv[1:]
    
    if args and args[0] in ('--help', '-h'):
        show_help()
        sys.exit(0)
        
    registry = load_registry()
    
    if not args:
        interactive_mode(registry)
    elif args[0] == "info":
        if len(args) < 2:
            print_err("Usage: G info <module>")
            sys.exit(1)
        show_module_info(args[1], registry)
    elif args[0] in ("-o", "-q"):
        if len(args) < 2:
            print_err("Usage: G -q \'your idea\' [--model <model>]")
            sys.exit(1)
        
        query_parts = []
        model_override = None
        i = 1
        while i < len(args):
            if args[i] == "--model" and i + 1 < len(args):
                model_override = args[i+1]
                i += 2
            else:
                query_parts.append(args[i])
                i += 1
        run_ollama(" ".join(query_parts), model_override)
    elif args[0] == "--sync":
        url = args[1] if len(args) > 1 else None
        sync_custom(url)
    elif args[0] == "-a":
        if len(args) < 3:
            print_err("Usage: G -a <alias> <command>")
            sys.exit(1)
        alias_name = args[1]
        cmd = " ".join(args[2:])
        add_custom(cmd, alias_name, registry)
    elif args[0] == "-rm":
        if len(args) < 2:
            print_err("Usage: G -rm <alias>")
            sys.exit(1)
        remove_custom(args[1])
    elif args[0] == "ls":
        list_custom()
    elif args[0] == "update":
        run_update()
    else:
        query = " ".join(args)
        best_guess(query, registry)

if __name__ == "__main__":
    main()
