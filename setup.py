"""Build hook: bundle ghee.py and modules/ into the ghee_cli package.

Package metadata lives in pyproject.toml. ghee.py and modules/ stay at the
repo root for the shell install (setup-ghee), so they are copied into the
wheel at build time.
"""

import shutil
from pathlib import Path

from setuptools import setup
from setuptools.command.build_py import build_py

ROOT = Path(__file__).parent


class build_py_with_core(build_py):
    def run(self):
        super().run()
        dest = Path(self.build_lib) / "ghee_cli"
        shutil.copy2(ROOT / "ghee.py", dest / "ghee.py")
        shutil.copytree(ROOT / "modules", dest / "modules", dirs_exist_ok=True)


setup(cmdclass={"build_py": build_py_with_core})
