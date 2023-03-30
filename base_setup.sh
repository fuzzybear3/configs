# base setup

set -xe

sudo apt update

sudo apt install -y \
  can-utils \
  curl \
  git \
  htop \
  ncdu \
  mlocate \
  pv \
  ripgrep \
  socat \
  stow \
  tree \
  tmux \
  zsh

stow tmux
./get-tmux-rst.sh

# download fonts and move to ~/.local/share/fonts
mkdir -p ~/.local/share/fonts/mesloLGS_NF
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Bold\ Italic.ttf

# install fonts
fc-cache -f -v


# stow nvim (handled in vim_setup.sh)
# Use our linked .zshrc, rather than the one provied by oh-my-zsh
# also links powerlevel10k config file
stow zsh


# zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


# fzf
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

./vim_setup.sh

user=$(whoami)
sudo chsh -s $(which zsh) $user

# New shell
nvim
