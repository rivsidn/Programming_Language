#! /bin/bash

for fileName in $(find ./ -name "*.asm" | grep -v 'utf8'); do
	dirName=$(dirname ${fileName})
	baseName=$(basename ${fileName} '.asm')
	targetName=${dirName}/${baseName}_utf8.asm

	if [ ! -e ${targetName} ];then
		iconv -f ISO-8859-1 -t UTF-8 ${fileName} -o ${targetName}
		dos2unix ${targetName}
	fi
done
