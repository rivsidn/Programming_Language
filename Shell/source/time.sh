#! /bin/bash

# time 是一个内部的保留字，与直接调用/usr/bin/time 输出不同

time cat *.sh | grep 'nihao'

/usr/bin/time cat *.sh | grep 'nihao'


