#! /bin/bash


for file in `ls *.o`
do
	rm ${file%%.*} ${file} 2>/dev/null
done

if [ -f a.out ]
then
	rm a.out
fi

