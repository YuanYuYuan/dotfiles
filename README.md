## Quick Setup for Non-root User


```bash
git clone https://github.com/yuanyuyuan/dotfiles
cd dotfiles
./setup-for-non-root.sh
export PATH="~/.local/bin:$PATH"
stow tmux
ln -s $HOME/.config/tmux/tmux.conf $HOME/.tmux.conf
sed -i 's/\/bin\/zsh/$HOME\/.local\/bin\/zsh/g' ~/.tmux.conf
./zsh/install.sh
./nvim/download.sh
./rust/install-rust.sh
pip3 install ranger-fm
```
