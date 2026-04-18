#!/usr/bin/env python3
"""
publish.py — Build and publish ghee-cli to PyPI.

Usage:
    python publish.py [version]
    
If no version is provided, it will prompt for one with a smart default.
"""

import os
import subprocess
import sys
import re
from datetime import datetime
from typing import Optional


def run_command(command: str, error_msg: Optional[str] = None) -> None:
    """
    Runs a shell command and exits if it fails.

    :param command: The shell command to run.
    :param error_msg: Optional error message to display on failure.
    """
    print(f"Running: {command}")
    process = subprocess.run(command, shell=True, capture_output=False, text=True)
    if process.returncode != 0:
        if error_msg:
            print(f"ERROR: {error_msg}")
        else:
            print(f"\nCommand failed with exit code {process.returncode}")
        sys.exit(1)


def update_file(file_path: str, old_pattern: str, new_text: str) -> None:
    """
    Replaces a pattern in a file with new text.

    :param file_path: Path to the file.
    :param old_pattern: Regex pattern to search for.
    :param new_text: Text to replace the pattern with.
    """
    if not os.path.exists(file_path):
        print(f"Warning: {file_path} not found.")
        return
    with open(file_path, "r") as f:
        content = f.read()

    new_content = re.sub(old_pattern, new_text, content)

    with open(file_path, "w") as f:
        f.write(new_content)


def update_changelog(new_version: str) -> None:
    """
    Adds a new entry to the CHANGELOG.md file.

    :param new_version: The version string to add.
    """
    file_path = "CHANGELOG.md"
    if not os.path.exists(file_path):
        # Create it if it doesn't exist
        date_str = datetime.now().strftime("%Y-%m-%d")
        content = f"# Changelog\n\n## v{new_version} ({date_str})\n\n* Release update\n"
        with open(file_path, "w") as f:
            f.write(content)
        return

    display_version = new_version if new_version.startswith("v") else f"v{new_version}"
    date_str = datetime.now().strftime("%Y-%m-%d")
    new_entry = f"\n## {display_version} ({date_str})\n\n* Automated release update\n"

    with open(file_path, "r") as f:
        lines = f.readlines()

    # Insert after the header
    inserted = False
    for i, line in enumerate(lines):
        if line.startswith("# Changelog"):
            lines.insert(i + 1, new_entry)
            inserted = True
            break

    if not inserted:
        lines.insert(0, f"# Changelog\n{new_entry}")

    with open(file_path, "w") as f:
        f.writelines(lines)


def get_current_version() -> str:
    """
    Reads the current version from pyproject.toml.

    :return: The version string.
    """
    if not os.path.exists("pyproject.toml"):
        return "0.0.0"
    with open("pyproject.toml", "r") as f:
        content = f.read()
    match = re.search(r'version = "(.*)"', content)
    return match.group(1) if match else "0.0.0"


def main() -> None:
    """
    Main entry point for the publish script.
    Increments version, updates files, builds the package, and publishes to PyPI.
    """
    current_version = get_current_version()

    if len(sys.argv) < 2:
        print(f"Current local version (pyproject.toml): {current_version}")

        # Smart version increment suggestion
        parts = current_version.split(".")
        if len(parts) == 3 and parts[2].isdigit():
            suggested = f"{parts[0]}.{parts[1]}.{int(parts[2]) + 1}"
        else:
            suggested = current_version + ".1"

        new_version = input(f"Enter new version [default: {suggested}]: ").strip()
        if not new_version:
            new_version = suggested
    else:
        new_version = sys.argv[1]

    print(f"--- Preparing ghee-cli v{new_version} ---")

    # 1. Update version files
    print(f"Updating pyproject.toml to v{new_version}...")
    update_file("pyproject.toml", r'version = ".*"', f'version = "{new_version}"')

    print(f"Updating src/ghee_cli/__init__.py to v{new_version}...")
    update_file(
        "src/ghee_cli/__init__.py",
        r'__version__ = ".*"',
        f'__version__ = "{new_version}"',
    )

    # 2. Update CHANGELOG.md
    print("Updating CHANGELOG.md...")
    update_changelog(new_version)

    # 3. Clean and Build
    print("Cleaning old builds...")
    if os.path.exists("dist"):
        run_command("rm -rf dist/*")
    if os.path.exists("src/ghee_cli.egg-info"):
        run_command("rm -rf src/ghee_cli.egg-info")
    if os.path.exists("build"):
        run_command("rm -rf build")

    print("Building package...")
    run_command(
        "python3 -m build", "Build failed. Check your pyproject.toml and dependencies."
    )

    # 4. Git Operations
    print("Committing and tagging in git...")
    tag_version = new_version if new_version.startswith("v") else f"v{new_version}"
    run_command(f"git add pyproject.toml src/ghee_cli/__init__.py CHANGELOG.md")
    # Check if there are changes to commit
    status = subprocess.run("git diff --cached --quiet", shell=True).returncode
    if status != 0:
        run_command(f'git commit -m "Release ghee-cli {tag_version}"')

    # Check if tag already exists
    tag_exists = (
        subprocess.run(
            f"git rev-parse {tag_version}", shell=True, capture_output=True
        ).returncode
        == 0
    )
    if tag_exists:
        print(f"Tag {tag_version} already exists. Skipping tagging.")
    else:
        run_command(f"git tag {tag_version}")

    # 5. Push to git to trigger CI/CD
    print("\nPushing to git to trigger CI/CD...")
    run_command(f"git push origin main")
    run_command(f"git push origin --tags")

    # 6. Publish to PyPI
    print("\n--- Publishing to PyPI ---")
    print("Checking distribution files...")
    if not os.path.exists("dist"):
        print_err("No dist directory found. Build may have failed.")
        sys.exit(1)

    dist_files = os.listdir("dist")
    if not dist_files:
        print_err("No distribution files found in dist/. Build may have failed.")
        sys.exit(1)

    print(f"Found {len(dist_files)} distribution files:")
    for f in dist_files:
        print(f"  - {f}")

    # Ask for confirmation before uploading
    print("\nThis will upload to PyPI. Are you sure?")
    confirm = input("Type 'yes' to confirm: ").strip().lower()
    if confirm != 'yes':
        print("Upload cancelled.")
        print(f"\nYou can upload manually later with:")
        print(f"  python3 -m twine upload dist/*")
        return

    print("\nUploading to PyPI...")
    run_command(
        "python3 -m twine upload dist/*",
        "Upload failed. Check your PyPI credentials and try again."
    )

    print(f"\n✅ Successfully published ghee-cli {tag_version} to PyPI!")
    print(f"\nUsers can now install with:")
    print(f"  pip install ghee-cli")
    print(f"\nAnd run with:")
    print(f"  ghee --help")
    print(f"  G --help")


if __name__ == "__main__":
    main()
