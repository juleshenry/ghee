import re

with open("ghee.py", "r") as f:
    content = f.read()

# We need to change load_registry to return modules info as well
# Wait, actually we can just create a new function `load_modules_info()`
# or we can modify `load_registry()` but it's used elsewhere.
# Let's just create `def show_help():` and `def show_info(module_name):`
