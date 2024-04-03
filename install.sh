#!/bin/sh

# 检查配置文件是否存在
if [ ! -f $HOME/.zprofile ]; then
    touch $HOME/.zprofile
fi



# 检查环境变量是否已经存在
if ! grep -q "$target_directory" "$HOME/.zprofile"; then
  # 如果不存在，将目录添加到环境变量中
  echo 'if [ -d "$HOME/.my_script" ] ; then' >> "$HOME/.profile"
  echo '    PATH="$HOME/.my_script:$PATH"' >> "$HOME/.profile"
  echo 'fi' >> "$HOME/.profile"
  echo "Environment variable added to $HOME/.profile"
else
  echo "Environment variable already exists in $HOME/.profile"
fi

echo "Installation completed. Scripts are available in $target_directory."
