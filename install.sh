#!/bin/sh

# 初始化一个空的字符串，用于存储未安装的命令
missing_commands=""
current_shell=""
run_commands_file=""


# 检查每个命令是否存在，如果不存在，则将其添加到missing_commands字符串
check_command() {
    if ! command -v $1 >/dev/null 2>&1; then
        missing_commands="$missing_commands $1"
    fi
}


check_shell() {
  # 获取当前 shell 的名称
  current_shell=$(echo $SHELL | awk -F '/' '{print $NF}')

  # 检查当前 shell 并输出相应的信息
  if [ "$current_shell" = "bash" ]; then
      run_commands_file=".bashrc"
  elif [ "$current_shell" = "zsh" ]; then
      run_commands_file=".zshrc"
  else
      echo "Unsupported shell."
      exit 127
  fi
}

set_proxy()
{
  if grep -qi Microsoft /proc/version; then
      if grep -qi "wsl  proxy" "$HOME/$run_commands_file"; then
        echo "find wsl  proxy"
      else
        echo "" >> "$HOME/$run_commands_file"
        echo "# >>> wsl  proxy >>>" >> "$HOME/$run_commands_file"
        echo "export hostip=\$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*')" >> "$HOME/$run_commands_file"
        echo "alias setss='export https_proxy=\"http://\${hostip}:7890\";export http_proxy=\"http://\${hostip}:7890\";export all_proxy=\"socks5://\${hostip}:7890\";export no_proxy=\"127.0.0.1,localhost\";'" >> "$HOME/$run_commands_file"
        echo "alias unsetss='unset all_proxy;unset https_proxy;unset http_proxy'" >> "$HOME/$run_commands_file"
        echo "# >>> wsl  proxy >>>" >> "$HOME/$run_commands_file"
      fi
  fi
}


set_clangformat(){
  mkdir -p $HOME/.config/clang-format
  cat .clang-format > $HOME/.config/clang-format/.clang-format
}

# 安装命令， 将命令添加到
# install_script(){

# }



main()
{
  check_shell
  set_proxy

  # 检查命令
  check_command clang-format
  check_command clangd

  # 检查missing_commands是否为空，如果不为空，则输出缺失的命令
  if [ -n "$missing_commands" ]; then
      echo "Required command(s) is/are missing:$missing_commands"
      echo "Please install them using your package manager."
      exit 127
  fi
  
  set_clangformat

}



 main