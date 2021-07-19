#! /bin/bash

#echo "commend 0"
echo "commend 1"
<<COMMENT
echo "commend 2"
echo "commend 3"
echo "commend 4"
COMMENT
: '
echo "commend 5"
echo "commend 6"
'
echo "commend 7"

