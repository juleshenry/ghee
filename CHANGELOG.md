# Changelog

## Unreleased

* Rename `pi` → `pni` for `pnpm install` (avoids clash with the popular `pi` harness)

## v0.1.1 (2026-04-09)

* Automated release update

All notable changes to ghee-cli will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v0.1.0 (2026-04-09)

* Initial release as proper Python package (ghee-cli)
* Publish to PyPI with `pip install ghee-cli`
* Console script entry points: `ghee` and `g` commands
* Registry caching for faster startup
* Improved fuzzy matching scoring algorithm
* Input validation and sanitization for custom commands
* Ollama integration (fully optional, silent fail if unavailable)
* Shell autocompletion support
* Configuration file support (~/.ghee-config.json)
* Confirmation dialog before running commands
* Clipboard support for macOS and Linux
* Usage tracking for popular commands
* Multi-language README (ES, ZH, HI, KO, AR)
* AGENTS.md guide for AI coding agents
