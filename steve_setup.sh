set -xe

# Run base install script(will call vim_setup.sh)
./base_setup.sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh



# install Alacritty
cargo install alacritty

# make it the default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /home/steveng/.cargo/bin/alacritty 110

# stow Alacritty
sudo apt install -y stow
stow alacritty

