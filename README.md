![CI](https://github.com/tomschall/dotfiles/actions/workflows/setup-test.yml/badge.svg)

# Dev Environment Setup (Dotfiles)

This repository provides a reproducible macOS development environment.
It installs common CLI tools, configures the terminal, and verifies the setup script in CI.

The goal is to make a new machine usable within minutes.

---

# Repository Structure

```id="struct1"
dotfiles
│
├── setup-dev-machine.sh
├── zsh
│   └── .zshrc
│
├── .config
│   ├── starship.toml
│   └── ghostty
│       └── config
│
└── .github
    └── workflows
        └── setup-test.yml
```

---

# Setup Script

`setup-dev-machine.sh` bootstraps the development environment.

Main tasks:

- Install Homebrew if missing
- Install CLI tools
- Install development tools
- Install terminal tools
- Install fonts
- Enable `fzf`
- Create configuration directories
- Link dotfiles

Run locally:

Clone the repository and run the setup script.
Use `--dry-run` to see the actions without making changes.

```bash
git clone git@github.com:tomschall/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup-dev-machine.sh
./setup-dev-machine.sh --dry-run
```

If everything looks good, run without `--dry-run` to apply the changes.

```bash
./setup-dev-machine.sh
```

Alternatively, you can run the script with `DRY_RUN` environment variable:

```bash
DRY_RUN=true ./setup-dev-machine.sh
```

---

# Configuration Linking

Configuration files are symlinked from the repository into the home directory.

```text
~/dotfiles/zsh/.zshrc             ->  ~/.zshrc
~/dotfiles/.config/starship.toml   ->  ~/.config/starship.toml
~/dotfiles/.config/ghostty/config  ->  ~/.config/ghostty/config
```

This keeps the repository as the single source of truth.

---

# GitHub Actions

The CI workflow validates the setup script using a macOS runner.

Location:

```text
.github/workflows/setup-test.yml
```

Pipeline steps:

1. Checkout repository
2. Syntax validation
3. ShellCheck linting
4. Lint script
5. Execute script in a clean environment
6. Verify installed tools
7. Verify symlinks
8. Test zsh configuration

Triggers:

```bash
push to main
pull requests
manual trigger (workflow_dispatch)
```

---

# Script Validation

Syntax check:

```bash
bash -n setup-dev-machine.sh
```

Linting:

```bash
shellcheck setup-dev-machine.sh
```

These checks run locally and in CI.

---

# Installed CLI Tools

The setup installs several tools to improve the developer workflow.

---

# File Navigation

## eza

Modern replacement for `ls`.

```bash
ls
ll
tree
```

Features:

- icons
- git status
- better formatting

Example:

```bash
eza -lah
```

---

## zoxide

Smart `cd` replacement that learns directory usage.

Example:

```bash
z project-name
```

Jump instantly to frequently used folders.

---

# File Viewing

## bat

Enhanced `cat` with syntax highlighting.

Example:

```bash
bat package.json
```

Features:

- syntax highlighting
- git integration
- line numbers

---

# Searching

## ripgrep

Extremely fast recursive search.

Example:

```bash
rg useEffect
```

Useful for scanning large codebases.

---

## fd

Modern alternative to `find`.

Example:

```bash
fd .config
```

Much simpler syntax than `find`.

---

# Git Workflow

## lazygit

Terminal UI for git.

Launch with:

```bash
lazygit
```

Common tasks:

- staging changes
- committing
- viewing diffs
- resolving conflicts

---

# System Monitoring

## btop

Modern resource monitor.

```bash
btop
```

Shows:

- CPU usage
- memory
- processes

---

## htop

Classic interactive process viewer.

```bash
htop
```

---

# Disk Usage

## dust

Modern alternative to `du`.

Example:

```bash
dust
```

Displays disk usage in a clean visual layout.

---

# Terminal Enhancements

## starship

Cross-shell prompt providing contextual information.

Displays:

- git branch
- node version
- python version
- error status

Configuration:

```bash
.config/starship.toml
```

---

## fzf

Interactive fuzzy finder used for:

- command history
- file search
- interactive filtering

Typical keybindings:

```bash
CTRL + R → search command history
CTRL + T → search files
```

---

# Development Tools

Installed tools:

```bash
node
pnpm
pyenv
```

These provide:

- Node.js runtime
- package manager
- Python version management

---

# Terminal

The setup configures the **Ghostty terminal**.

Configuration file:

```bash
~/.config/ghostty/config
```

Font:

```bash
JetBrainsMono Nerd Font
```

---

# Workflow Summary

Typical development workflow:

```bash
z project-name
ls / ll
rg search-term
bat file.js
lazygit
```

Combined with:

- `fzf`
- `starship`
- `ghostty`

This results in a fast and efficient terminal-based development environment.

---

# Goal of This Setup

Provide:

- reproducible development environments
- versioned configuration
- automated setup
- CI validation
- improved terminal productivity

```

```
