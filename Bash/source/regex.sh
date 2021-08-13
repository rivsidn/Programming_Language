#! /bin/bash

line=daabc

if [[ $line =~ (a)?b ]]
then
	echo $BASH_REMATCH
else
	echo "not match"
fi

x='foo bar bletch'
if [[ $x =~ foo[[:space:]](bar)[[:space:]]bl(.*) ]]
then
	echo The regex matches!
	echo $BASH_REMATCH      
	echo ${BASH_REMATCH[0]} 
	echo ${BASH_REMATCH[1]} 
	echo ${BASH_REMATCH[2]} 
fi


