#!/usr/bin/env bash
set -euo pipefail

REPO="irthompson01/dotfiles"
BRANCH="main"
CONF_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/tmux.conf"
SESSION="main"

SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"

# 1. Install tmux if it's missing
if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux..."
  if   command -v apt-get >/dev/null; then $SUDO apt-get update -y && $SUDO apt-get install -y tmux curl
  elif command -v dnf     >/dev/null; then $SUDO dnf install -y tmux
  elif command -v yum     >/dev/null; then $SUDO yum install -y tmux
  elif command -v apk     >/dev/null; then $SUDO apk add tmux
  elif command -v brew    >/dev/null; then brew install tmux
  else echo "No supported package manager found" >&2; exit 1; fi
fi

# 2. Fetch the latest config (back up the old one if it differs)
tmp="$(mktemp)"
curl -fsSL "$CONF_URL" -o "$tmp"
if [ -f ~/.tmux.conf ] && ! cmp -s "$tmp" ~/.tmux.conf; then
  cp ~/.tmux.conf ~/.tmux.conf.bak
  echo "Backed up old config to ~/.tmux.conf.bak"
fi
mv "$tmp" ~/.tmux.conf

# 3. Reload if a server is already running
tmux has-session 2>/dev/null && tmux source-file ~/.tmux.conf && echo "Reloaded config"

# 4. Attach to the session, or create it
if [ -z "${TMUX:-}" ]; then
  exec tmux new-session -A -s "$SESSION"
else
  echo "Already inside tmux, config updated."
fi
