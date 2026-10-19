# dotfiles

Installs tmux, applies my `tmux.conf`, and starts a session. Re-running updates the config.

## macOS / Linux
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/irthompson01/dotfiles/main/install.sh)"
```

## Windows (Command Prompt or PowerShell)
tmux doesn't run natively on Windows, so this sets up WSL (Ubuntu) and runs the installer inside it.

Command Prompt:
```cmd
curl -fsSL https://raw.githubusercontent.com/irthompson01/dotfiles/main/install.ps1 -o %TEMP%\tmux-install.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File %TEMP%\tmux-install.ps1
```

PowerShell:
```powershell
irm https://raw.githubusercontent.com/irthompson01/dotfiles/main/install.ps1 | iex
```

If WSL isn't installed yet, the first run installs Ubuntu; finish its user setup (reboot if asked) and run the command again.
