#!/bin/sh
# 获取脚本的命令名
script_name=$(basename -- "$0")

# 显示帮助信息
display_help() {
    echo "用法: $script_name <源文件> [-m32]"
    echo "编译和运行C/C++程序，可选使用 -m32 编译为32位程序。"
    echo
    echo "选项:"
    echo "  -m32          编译为32位程序"
    echo "  -help         显示帮助信息"
}

# 检查是否包含 -help 参数
if [ "$#" -eq 1 ] && [ "$1" = "-help" ]; then
    display_help
    exit 0
fi

# 检查命令行参数数量
if [ "$#" -lt 1 ]; then
    echo "用法: $script_name <源文件> [-m32]"
    exit 1
fi

# 提取文件名和扩展名
file="$1"
filename=$(basename -- "$file")
extension="${filename##*.}"
filename="${filename%.*}"

# 检查是否包含 -m32 参数
compile_options=""
if [ "$#" -ge 2 ] && [ "$2" = "-m32" ]; then
    compile_options="-m32"
fi

# 编译和运行
if [ "$extension" = "c" ]; then
    gcc $compile_options -o "$filename" "$file" && "./$filename"
elif [ "$extension" = "cpp" ]; then
    g++ -o "$filename" "$file" && "./$filename"
else
    echo "不支持的文件类型: $extension"
    exit 1
fi

# 删除生成的可执行文件
rm -f "$filename"