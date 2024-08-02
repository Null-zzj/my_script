#!/bin/sh


MYCONFIG="$HOME/.config/my-profile"

install()
{
  mkdir -p $MYCONFIG
  cp -r "config" $MYCONFIG
  cp -r "script" $MYCONFIG
  cp .clang-format $MYCONFIG
  start_marker="# >>> my profile >>>"
  line_to_add='. "$HOME/.config/my-profile/config/profile"'
  end_marker="# >>> wsl profile >>>"

  # 检查行块是否已经存在于~/.bashrc中
  if ! grep -qF "$line_to_add" ~/.bashrc; then
      {
          echo ""
          echo "$start_marker"
          echo "$line_to_add"
          echo "$end_marker"
      } >> ~/.bashrc
  fi
}

install