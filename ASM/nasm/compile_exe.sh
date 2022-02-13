#! /bin/bash

set -e

name="${1%%.*}"

nasm -felf64 $1

ld ${name}.o -o ${name}

./${name}




