#!/usr/bin/env bash

set -e

installer() {
  current_dir=`pwd`
  scripts="${current_dir}/scripts/";

  echo "Installing files..."
  $1 install -Dm 644 doas.conf "/etc/doas.conf"
  $1 install -dm 555 "/etc/X11/xorg.conf.d/"
  $1 install -Dm 644 xorg.conf "/etc/X11/xorg.conf"

  for i in xorg.conf.d/*; do
    $1 install -Dm 644 "${i}" "/etc/X11/xorg.conf.d/"
  done

  echo "Installing dotfiles..."
  install -Dm 600 gitconfig "$HOME/.gitconfig"
  install -Dm 600 Xresources "$HOME/.Xresources"
  install -Dm 600 vimrc "$HOME/.vimrc"
  install -Dm 600 xinitrc "$HOME/.xinitrc"
  install -Dm 600 zprofile "$HOME/.zprofile"

  echo "Installing scripts..."
  cd $HOME/.local/
  ln -s $scripts scripts
  cd "${current_dir}"

  echo "Coping configurations..."
  cp -r "${current_dir}"/config/* $HOME/.config/
  exit 1;
}




if [ -z $SU ]; then
  read -p "SU env not set use sudo [y|N]: " val
  [ "$val" = "Y" ] || [ "$val" = "y" ] && installer "sudo"
  exit -1;
fi

installer "$SU"
