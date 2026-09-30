"""ghee-cli — thin wrapper around ghee.py for pip-installed usage."""

import sys
from pathlib import Path

try:
    # Installed wheel: ghee.py and modules/ are bundled into this package.
    from ghee_cli.ghee import main
except ImportError:
    # Source checkout / editable install: ghee.py lives at the repo root.
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
    from ghee import main  # noqa: E402

__all__ = ["main"]
