#!/bin/bash

dictfile=/home/rob/english-out
lwdict3=/tmp/ramdisk/3lw.txt
lwdict4=/tmp/ramdisk/4lw.txt
lwdict5=/tmp/ramdisk/5lw.txt

while read -r line
do
	if  [ ${#line} == 3 ]
	then
		echo $line >> "$lwdict3"
	fi

	if [ ${#line}  == 4 ]
	then
		echo $line >> "$lwdict4"
	fi
	
	if [ ${#line}  == 5 ]
	then
		echo $line  >> "$lwdict5"
	fi
	
done < "$dictfile"

#echo "Done creating dictionary files"
i=0
while read -r word1 <&3
do


	if [ $i -lt 5 ]
	then
		diskfree=`df /tmp/ramdisk | awk '/[0-9]%/{print $(NF-2)}'`
	        if [ $diskfree -lt 200000 ]
        	then
			echo "Running out of disk space - waiting 30 seconds"
                 	sleep 30s
	        fi

		taskset -c $i  ./writeout.sh $word1 &
		i=$((i+1))
		echo "spawning dictionary create - " $word1
	fi

	if [ $i -ge 5 ]
	then
	echo "Max threads - awaiting one to be free"
		wait
		i=0
	fi

done 3<$lwdict3
