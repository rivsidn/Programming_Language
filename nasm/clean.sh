#! /bin/bash


for file in `ls *.o`
do
	rm ${file%%.*} ${file}
done

if [ -f a.out ]
then
	rm a.out
fi

