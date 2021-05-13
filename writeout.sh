#!/bin/bash
lwdict3=/tmp/ramdisk/3lw.txt
lwdict4=/tmp/ramdisk/4lw.txt
lwdict5=/tmp/ramdisk/5lw.txt
writeout=()
count=0
while read -r word3 <&3
do
	while read  -r word4 <&4
	do
		writeout+=($1-$word3-$word4)
		count=$((count+1))
		if [ $count -gt 9000000 ]
		then
			printf "%s\n" "${writeout[@]}" > /tmp/ramdisk/proc/$RANDOM.txt
			count=0
			unset writeout
		fi
	done 4<$lwdict5
done 3<$lwdict4
printf "%s\n" "${writeout[@]}" > /tmp/ramdisk/proc/$RANDOM.txt
unset writeout
