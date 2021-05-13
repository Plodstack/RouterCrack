#!/bin/bash
#mkdir /tmp/ramdisk
#mount -t tmpfs -o size=2048m tmpfs /tmp/ramdisk
#mkdir /tmp/ramdisk/proc
while true
do
	dir=/tmp/ramdisk/proc/*.txt
	numfile=`ls ${dir} |  wc -l`
	if (( $numfile < 2)) ; then
		echo "Less than 2 files, sleeping."
		sleep 1m
	fi
	echo "Number of file =" $numfile
	
		for file in $dir
		do
			cat $file >> /tmp/ramdisk/proc/coalfile.out && rm $file
		done
		FILESIZE=`stat -c%s /tmp/ramdisk/proc/coalfile.out`
		if (( $FILESIZE > 0)) ; then
			taskset -c 5 hashcat -w 1 -O -m 2500 -a 0 ./eeout.hccapx /tmp/ramdisk/proc/coalfile.out 
			rm /tmp/ramdisk/proc/coalfile.out >> /dev/null
		fi
done
