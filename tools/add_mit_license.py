#!/usr/bin/env python3
"""
Fetch all public repos for GitHub user 'juleshenry',
add an MIT LICENSE file (with croc-shades art) to any repo missing one.
Requires: git CLI with credentials configured globally.
"""

import json
import os
import shutil
import subprocess
import sys
import tempfile
import urllib.request
from datetime import datetime

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
GITHUB_USER = "juleshenry"
COPYRIGHT_HOLDER = "Julian Philip Henry"
YEAR = datetime.now().year
CROC_SHADES_PATH = os.path.join(SCRIPT_DIR, "croc-shades")


def build_mit_license() -> str:
    """Build the MIT license text with the copyright holder name."""
    return f"""MIT License

Copyright (c) {YEAR} {COPYRIGHT_HOLDER}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""


def load_croc_shades() -> str:
    """Read the croc-shades ASCII art from the file next to this script."""
    with open(CROC_SHADES_PATH, "r", encoding="utf-8") as f:
        return f.read()


def fetch_public_repos(username: str) -> list[dict]:
    """Fetch all public repos for a GitHub user, handling pagination."""
    repos = []
    page = 1
    per_page = 100
    while True:
        url = (
            f"https://api.github.com/users/{username}/repos"
            f"?type=owner&per_page={per_page}&page={page}"
        )
        req = urllib.request.Request(
            url, headers={"Accept": "application/vnd.github+json"}
        )
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode())
        if not data:
            break
        repos.extend(data)
        if len(data) < per_page:
            break
        page += 1
    return repos


def repo_has_license(repo: dict) -> bool:
    """Check if the repo already has a license via the API metadata."""
    # The 'license' field is populated by GitHub when a LICENSE file exists
    if repo.get("license") and repo["license"].get("spdx_id") != "NOASSERTION":
        return True
    # Double-check by looking for common license filenames in the repo root
    contents_url = f"https://api.github.com/repos/{repo['full_name']}/contents/"
    try:
        req = urllib.request.Request(
            contents_url, headers={"Accept": "application/vnd.github+json"}
        )
        with urllib.request.urlopen(req) as resp:
            items = json.loads(resp.read().decode())
        license_names = {
            "license",
            "license.md",
            "license.txt",
            "licence",
            "licence.md",
            "licence.txt",
        }
        for item in items:
            if item.get("name", "").lower() in license_names:
                return True
    except Exception:
        pass
    return False


def run(cmd: list[str], cwd: str | None = None) -> subprocess.CompletedProcess:
    """Run a subprocess, raising on failure."""
    result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"  [ERROR] Command failed: {' '.join(cmd)}")
        print(f"  stdout: {result.stdout.strip()}")
        print(f"  stderr: {result.stderr.strip()}")
    return result


def add_license_to_repo(repo: dict, dry_run: bool = False) -> bool:
    """Clone repo, add LICENSE, commit, push. Returns True on success."""
    clone_url = repo["clone_url"]
    repo_name = repo["name"]
    full_name = repo["full_name"]

    if dry_run:
        print(f"  [DRY RUN] Would add MIT LICENSE to {full_name}")
        return True

    tmpdir = tempfile.mkdtemp(prefix=f"license_{repo_name}_")
    try:
        print(f"  Cloning {full_name} ...")
        result = run(["git", "clone", "--depth", "1", clone_url, tmpdir])
        if result.returncode != 0:
            return False

        license_path = os.path.join(tmpdir, "LICENSE")
        license_content = build_mit_license() + "\n" + load_croc_shades()
        with open(license_path, "w", encoding="utf-8") as f:
            f.write(license_content)

        run(["git", "add", "LICENSE"], cwd=tmpdir)
        result = run(
            ["git", "commit", "-m", "Add MIT LICENSE"],
            cwd=tmpdir,
        )
        if result.returncode != 0:
            print(f"  [WARN] Nothing to commit for {full_name}, skipping.")
            return False

        default_branch = repo.get("default_branch", "main")
        result = run(["git", "push", "origin", default_branch], cwd=tmpdir)
        if result.returncode != 0:
            return False

        print(f"  Successfully added LICENSE to {full_name}")
        return True
    finally:
        shutil.rmtree(tmpdir, ignore_errors=True)


def main():
    dry_run = "--dry-run" in sys.argv

    if dry_run:
        print("=== DRY RUN MODE (no changes will be pushed) ===\n")

    print(f"Fetching public repos for '{GITHUB_USER}' ...")
    repos = fetch_public_repos(GITHUB_USER)
    print(f"Found {len(repos)} public repo(s).\n")

    if not repos:
        print("No public repos found. Exiting.")
        return

    # Filter out forks
    owned = [r for r in repos if not r.get("fork")]
    print(f"{len(owned)} owned (non-fork) repo(s).\n")

    added = 0
    skipped = 0
    failed = 0

    for repo in owned:
        name = repo["full_name"]
        print(f"[{name}]")

        if repo.get("archived"):
            print("  Archived -- skipping.\n")
            skipped += 1
            continue

        print("  Adding MIT LICENSE (overwriting if exists) ...")
        ok = add_license_to_repo(repo, dry_run=dry_run)
        if ok:
            added += 1
        else:
            failed += 1
        print()

    print("=" * 50)
    print(f"Done!  Added: {added}  |  Skipped: {skipped}  |  Failed: {failed}")


if __name__ == "__main__":
    main()
