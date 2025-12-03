# shell-kit

# Requirements
- curl (for installer)
- git (for installer)
- gum (for fancy ui)

# Installation

Install curl, git and gum

## MacOS
``` zsh
brew update
brew upgrade
brew install curl
brew install git
brew install gum
```

## Debian-ish
``` bash
apt-get update 
apt-get upgrade
apt-get install -y curl
apt-get install -y git
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum
```

## shell-kit Installation
```
curl -fsSL https://example.com/onlineinstaller.sh | sh -s https://github.com/kastaniotis/shell-kit.git
```