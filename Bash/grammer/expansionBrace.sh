#! /bin/bash

# expansion 0
# 该展开执行的优先级最高，仅仅是文字上的展开

echo {0..10}
echo {0..100..3}
# 为了他们之间有相同的宽度，可以在数字之前添加一个 0
echo {00..100..3}

echo {a..z}
echo {a..z..2}		# 字母仅支持单个

