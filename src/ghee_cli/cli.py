"""ghee-cli — thin wrapper around ghee.py for pip-installed usage."""

import sys
from pathlib import Path

# When installed as a pip package, ghee.py lives at the repo root.
# Add it to sys.path so we can import directly.
_repo_root = Path(__file__).parent.parent.parent
if (_repo_root / "ghee.py").exists():
    sys.path.insert(0, str(_repo_root))

# Import everything from the canonical ghee.py
from ghee import main  # noqa: E402

__all__ = ["main"]
