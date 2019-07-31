#!/bin/bash

# Author:	Entropyth 07-31-2019
# Usage	: 	bash ccmpl.sh
# References:	https://github.com/nilotpalbiswas/Auto-Root-Exploit/blob/master/autoroot.sh

exploitName=$(echo $1 | cut -d"." -f1)
#rm -v -f ./exploit_$exploitName 2>/dev/null

if [ -f ./exploit_$exploitName ]; then
	echo File: exploit_$exploitName Already Exists!
	echo Please delete or rename to attempt to compile.
	exit
fi

arraycmpl=(
"$1 -lutil -lpthread -o exploit_$exploitName"
"$1 -m32 -O2 -o exploit_$exploitName"
"$1 -o exploit_$exploitName"
"$1 -o exploit_$exploitName -lkeyutils -Wall"
"$1 -o exploit_$exploitName -lpthread"
"$1 -o exploit_$exploitName -pthread"
"$1 -o exploit_$exploitName -static -Wall"
"$1 -o exploit_$exploitName -Wall"
"-fPIC -shared -o exploit_$exploitName $1 -ldl -w"
"-O2 $1 -o exploit_$exploitName"
"-O2 -fomit-frame-pointer $1 -o exploit_$exploitName"
"-o exploit_$exploitName $1 -static -O2"
"-pthread $1 -o exploit_$exploitName -lcrypt"
"-Wall -m64 -o exploit_$exploitName $1"
"-Wall -o exploit_$exploitName $1"
)

echo Attempting Methods to compile $1
echo =========================================

for i in "${arraycmpl[@]}"
do
	gcc $i >> /dev/null
	cc $i >> /dev/null
	if [ -f "./exploit_$exploitName" ]; then
		echo Successful compile of $1
		echo With command parameters $i
		break
	fi
sleep 1
done

if [ ! -f "./exploit_$exploitName" ]; then
	echo Failed to compile $1
fi

