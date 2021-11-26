# Dual Function Keys

## Installation

```bash
paru -S interception-tools
sudo pacman -S interception-dual-function-keys
sudo mkdir /etc/interception
sudo cp ./interception/keybindings.yaml /etc/interception/keybindings.yaml
sudo cp ./interception/udevmon.yaml /etc/interception/udevmon.yaml
sudo cp ./udevmon.service /etc/systemd/system/udevmon.service
sudo systemctl daemon-reload
sudo systemctl enable udevmon
sudo systemctl start udevmon
```
