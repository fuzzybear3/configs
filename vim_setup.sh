#!/usr/bin/env sh

set -xe

if [ $(uname -m) = x86_64 ] || [ $(uname -m) = aarch64 ]; then
  # Install latest appimage
  NVIM_PATH=~/software/nvim.appimage
  NVIM_DIR=$(dirname $NVIM_PATH)


  mkdir -p $NVIM_DIR
  if [ -f "$NVIM_PATH" ];
  then rm -rf "$NVIM_PATH" 
  fi

  # Download the latest appimage
  wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -P $NVIM_DIR

  # Make it executable
  chmod u+x $NVIM_PATH

  
  sudo update-alternatives --install /usr/bin/ex ex "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/vi vi "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/view view "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/vim vim "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/nvim nvim "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${NVIM_PATH}" 110
else
  # Install old version, but should be fine.
  sudo apt install -y neovim
  # This should automatically set up vi and vim alternatives.
  # Might need old vim and vi to be uninstaled.
  # Todo - could add a check and an error
fi

# clear old configs (for debugging or non-fresh setup):
#rm -rf ~/.config/nvim/bundle
#rm ~/.config/nvim

## old plugin installer

# Install Vundle
# mkdir -p ~/.config/nvim/bundle
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim

# nvim --headless +PluginInstall +qa


## install nerd fonts(used by nvim)


# old ----------------
# NERD_FONT_NAME=SourceCodePro

# download zipped font
# wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip

#unzip
# unzip ~/Downloads/${NERD_FONT_NAME}.zip

# mkdir -p ~/.local/share/fonts/${NERD_FONT_NAME}
# unzip ~/Downloads/SourceCodePro.zip -d ~/.local/share/fonts/${NERD_FONT_NAME}

# fc-cache -f -v | grep "{NERD_FONT_NAME}"


# install astroNvim
# save old nvim config

if [ ! -f ~/.config/nvim.bak ] && [ -f ~/.config/nvim ]; 
then mv ~/.config/nvim ~/.config/nvim.bak; fi

if [ ! -f ~/.local/share/nvim.bak ] && [ -f ~/.config/nvim ]; 
then mv ~/.local/share/nvim ~/.local/share/nvim.bak; fi

# clone astroNvim config over old config
if [ -f ~/.config/nvim ]; 
then rm -rf ~/.config/nvim; fi
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

nvim +PackerSync

stow nvim
