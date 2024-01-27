#!/bin/sh

# 设置目标目录
target_directory="$HOME/.my_script"

# 检查目标目录是否已经存在
if [ -d "$target_directory" ]; then
  echo "Target directory $target_directory already exists. Updating repository..."
  # 如果存在，进入目录并执行git pull以更新仓库
  (cd "$target_directory" && git pull origin main)
else
  echo "Cloning repository to $target_directory..."
  # 如果不存在，克隆整个仓库到目标目录
  git clone https://github.com/your_username/your_repository.git "$target_directory"
fi

# 检查环境变量是否已经存在
if ! grep -q "$target_directory" "$HOME/.profile"; then
  # 如果不存在，将目录添加到环境变量中
  echo 'if [ -d "$HOME/.my_script" ] ; then' >> "$HOME/.profile"
  echo '    PATH="$HOME/.my_script:$PATH"' >> "$HOME/.profile"
  echo 'fi' >> "$HOME/.profile"
  echo "Environment variable added to $HOME/.profile"
else
  echo "Environment variable already exists in $HOME/.profile"
fi

echo "Installation completed. Scripts are available in $target_directory."
