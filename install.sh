#!/bin/sh


MYCONFIG="$HOME/.config/my-profile"

install()
{
  mkdir -p $MYCONFIG
  cp -r "config" $MYCONFIG
  cp -r "script" $MYCONFIG
  cp .clang-format $MYCONFIG
}

install