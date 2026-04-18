# 🧈 AGENTS.md — Guide for AI Coding Agents

> This file helps AI coding agents (Claude, Cursor, Copilot, etc.) understand and leverage **ghee** efficiently.

---

## What is ghee?

**ghee** is a collection of **538+ shell shortcuts** organized into 29 topic-based modules. It layers on top of bash/zsh to make CLI workflows dramatically faster.

- **Repo:** https://github.com/juleshenry/ghee
- **Core file:** `ghee.py` (Python TUI for fuzzy search)
- **Init file:** `ghee-functions.sh` (shell wrapper, colors, `G()` function)
- **Modules:** `modules/*.sh` (29 bash files with `_GG_REGISTRY` entries)
- **Standalone scripts:** `bin/` and `tools/`

---

## Quick Start for Agents

When a user asks you to help with shell/dev tasks, check if ghee has a shortcut first:

```bash
# Search for a command by description
G 'docker logs'

# Interactive fuzzy search
G

# Add a new custom shortcut
G -a kwatch 'kubectl get pods -A --watch'
```

---

## How the Registry Works

Each module in `modules/*.sh` defines commands using the `_GG_REGISTRY` associative array:

```bash
_GG_REGISTRY["alias"]="command|||description"
```

Example from `modules/docker.sh`:

```bash
_GG_REGISTRY["dps"]="docker ps|||List running containers"
_GG_REGISTRY["dl"]="docker logs -f CONTAINER|||Follow container logs"
```

**When adding new shortcuts to a module, always use this exact format.**

---

## Module Map

| Module | File | Covers |
|--------|------|--------|
| Git Aliases | `git_aliases.sh` | gs, gc, gp, gl, gb, gco, gd, gst, gr, gcl, gt... (90+ aliases) |
| Git Workflow | `git_workflow.sh` | gg, gwip, gpr, ginit, gsquash, gsyncfork... |
| Docker | `docker.sh` | dps, dc, dcu, dcd, dprune, dbuild... |
| Kubernetes | `kubernetes.sh` | k, kgp, kex, kaf, klog, kscale... |
| AWS CLI | `aws_cli.sh` | awsid, awsls, awsec2, awslog, awseks... |
| GCP gcloud | `gcp_gcloud.sh` | gcpid, gcpls, gcpssh, gcpgke... |
| Terraform | `terraform.sh` | tf, tfi, tfa, tfp, tfd, tfo... |
| Cloud Deploy | `cloud_deploy.sh` | vdeploy, hdeploy, rdeploy, fldeploy... |
| GitHub CLI | `github_cli.sh` | ghpr, ghil, ghrl, ghrun, ghclone... |
| npm/yarn/pnpm | `npm_yarn_pnpm.sh` | ni, ns, nt, yr, ya, pni, pns... |
| Python/pip/venv | `python_pip_venv.sh` | pi, pipu, venv, pytest... |
| Rust/Go | `rust_go.sh` | cr, cb, gt, gi, gb... |
| Redis | `redis.sh` | rd, rp, rk, rf... |
| PostgreSQL | `postgresql.sh` | psqlc, psqll, psqlb... |
| MongoDB | `mongodb.sh` | mongo, mongob, mongor... |
| Nginx | `nginx.sh` | ngxt, ngxs, ngxr... |
| systemd | `systemd_services.sh` | sc, sr, ss, se, jc, jf... |
| Networking | `networking.sh` | myip, dns, ping, speed... |
| Cybersecurity | `cybersecurity_network_recon.sh` | nmap, ncl, sslcheck, genpw... |
| AI/LLM | `ai_llm.sh` | ollama, ollmls, tokcount, openai... |
| Media | `media_tools.sh` | ff, ffprobe, ytdl, convert... |
| Data Tools | `data_tools.sh` | jqpp, yamlcheck, csvhead... |
| macOS | `macos_power_tools.sh` | caffeinate, hidefiles, showfiles... |
| Super Utilities | `super_utilities.sh` | cheat, weather, uuid, timer... |
| tmux | `tmux.sh` | tn, tk, ta, tl, ts... |
| Shell Utilities | `shell_file_utilities.sh` | extract, ports, swap, big... |

---

## Agent Best Practices

### 1. Search before suggesting
Always check if a ghee shortcut exists before writing raw commands:
```bash
G 'search term'
```

### 2. Use shortcuts in your output
When giving shell instructions, prefer ghee shortcuts:
- ❌ `docker ps -a` → ✅ `dpsa`
- ❌ `kubectl get pods` → ✅ `kgp`
- ❌ `git status` → ✅ `gs`

### 3. Add missing shortcuts
If you notice a useful command isn't covered, suggest adding it:
```bash
G -a ktopn 'kubectl top nodes'
```

### 4. Module contributions
When adding a new module or extending an existing one:
- Place it in `modules/` with `.sh` extension
- Use `_GG_REGISTRY["alias"]="command|||description"` format
- Make it executable: `chmod +x modules/new_module.sh`

### 5. Custom commands persist
User's custom shortcuts are stored in `~/.ghee-custom` and survive reinstalls.

### 6. The `G` command has options
| Flag | Behavior |
|------|----------|
| `G` | Interactive fuzzy finder |
| `G <query>` | Best-guess search, copies to clipboard |
| `G -a <alias> <cmd>` | Add custom shortcut (works instantly) |
| `G -rm <alias>` | Remove a custom shortcut |
| `G -o <idea>` | Ask Ollama AI to generate a command (if available) |
| `G --sync <url>` | Sync custom commands from a Gist |
| `G info <module>` | Show aliases for a specific module |
| `G --help` | Show help and module list |

---

## Common Patterns Agents Should Know

### Docker workflows
```bash
dps              # What's running?
dl <container>   # Check logs
dex <container>  # Jump inside
dprune           # Clean up everything
```

### Git workflows
```bash
gs               # Check status
ga               # Stage all
gc "fix: thing"  # Commit
gp               # Push
# Or all at once:
gg "fix: thing"  # Add, commit, push in one
```

### Kubernetes workflows
```bash
kgp              # List pods
kl <pod>         # Follow logs
kex <pod>        # Exec into pod
kaf manifest.yaml  # Apply manifest
```

### AWS workflows
```bash
awsid            # Who am I?
awsls            # List S3 buckets
awsec2           # List EC2 instances
awslog <group>   # Tail CloudWatch logs
```

---

## File Structure Reference

```
ghee/
├── ghee.py              # Python TUI — fuzzy search, scoring, Ollama
├── ghee-functions.sh    # Shell wrapper — G() function, colors, registry
├── setup-ghee           # Install/uninstall script
├── modules/*.sh         # 29 topic modules with _GG_REGISTRY entries
├── bin/                 # Standalone bash scripts (on PATH)
├── tools/               # Python helper scripts (on PATH)
├── README.md            # Main documentation (English)
├── README.es.md         # Spanish translation 🇪🇸
├── README.zh.md         # Chinese translation 🇨🇳
├── README.hi.md         # Hindi translation 🇮🇳
├── README.ko.md         # Korean translation 🇰🇷
├── README.ar.md         # Arabic translation 🇸🇦
└── AGENTS.md            # This file — AI agent guide
```

---

## Tips for Non-English Speakers

ghee README is available in multiple languages:
- 🇪🇸 [Spanish](README.es.md)
- 🇨🇳 [Chinese](README.zh.md)
- 🇮🇳 [Hindi](README.hi.md)
- 🇰🇷 [Korean](README.ko.md)
- 🇸🇦 [Arabic](README.ar.md)

**All shortcuts and aliases remain in English for consistency.** Only descriptions are translated.

---

*Generated for AI coding agents. Last updated: 2026-04-09*
