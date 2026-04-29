.. Project documentation master file, created by
   sphinx-quickstart on Thu Apr  9 09:20:03 2026.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Project documentation
=====================

Ghee is a senior-friendly shell shortcut manager with AI-assisted command generation.

Usage
-----

.. code-block:: bash

   G                            # Interactive fuzzy finder
   G <query>                    # Best-guess search
   G -a <alias> <cmd>           # Add custom shortcut
   G -rm <alias>                # Remove a custom shortcut
   G ls                         # List all custom shortcuts
   G -q <idea> [--model <M>]    # Ask Ollama AI to generate a command
   G info <module>              # Show aliases for a specific module
   G update                     # Self-update ghee
   G --help                     # Show help

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   modules

