#! /bin/bash

set -e

name="${1%%.*}"

nasm -felf64 $1

gcc ${name}.o -o ${name} -no-pie

./${name}




