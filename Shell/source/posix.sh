#! /bin/bash

# 进入posix 的两种方式
# 1. 启动时候加 --posix 选项
# 2. 运行的时候设置 set -o posix

set -o posix

# 当运行在 posix 模式的时候，该环境变量为 y 
echo ${POSIXLY_CORRECT}

