#! /bin/bash

declare -i i=1

i=i+1
echo $i

((i++))
echo $i

let i++
echo $i
