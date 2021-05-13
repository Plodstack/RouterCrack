process=`ps -fu |grep "[m]akedict" | grep -v "grep" | awk '{print $2}'`
while true
do
diskfree=`df /tmp/ramdisk | awk '/[0-9]%/{print $(NF-2)}'`
numfile=`ls ${dir} |  wc -l`
        if (( $numfile < 5)) ; then
                echo "Less than 5 files, sleeping."
		kill -SIGSTOP $process
                sleep 1m
        fi



	if [ $diskfree -lt 1000000 ]
	then
		echo "Running out of disk space - waiting 2 minutes"
		kill -SIGSTOP $process
		sleep 1m
	fi
	kill -CONT $process
	ls -lh /tmp/ramdisk/proc
	echo "Sleeping for 10s"
	sleep 10s
done
