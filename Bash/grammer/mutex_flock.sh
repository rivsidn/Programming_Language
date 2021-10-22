#! /bin/bash

set -e

(
	flock -x -w 10 200
	echo "before ..."
	sleep 5
	echo "after ..."
	

) 200>/var/lock/.myscript.exclusivelock
