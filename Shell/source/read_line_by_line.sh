#! /bin/bash

cat test.txt | while read line
do
	echo "file:${line}"
done


while read line
do
	echo "file:${line}"
done < test.txt



