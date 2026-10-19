# Windows installer: tmux has no native Windows build, so this runs the
# Linux installer inside WSL (Ubuntu), installing WSL first if needed.
$ErrorActionPreference = 'Stop'
$Url = 'https://raw.githubusercontent.com/irthompson01/dotfiles/main/install.sh'

if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
    Write-Host 'wsl.exe not found. Update Windows 10 (2004+) or Windows 11, then re-run.'
    exit 1
}

# wsl.exe prints UTF-16; strip NULs before checking for an installed distro
$distros = ((wsl.exe -l -q) -join '') -replace "`0", '' -replace '\s', ''
if (-not $distros) {
    Write-Host 'No WSL distro found. Installing Ubuntu (may need admin + a reboot)...'
    wsl.exe --install -d Ubuntu
    Write-Host 'Finish the Ubuntu user setup (reboot first if asked), then re-run this command.'
    exit 0
}

# Run the same Linux installer inside WSL
wsl.exe -- bash -lc "(command -v curl >/dev/null || sudo apt-get install -y curl) && curl -fsSL $Url -o /tmp/tmux-install.sh && bash /tmp/tmux-install.sh"
