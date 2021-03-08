#!/bin/sh
echo "please select number:"
echo "1:  test env"
echo "2:  fz env"
echo "3:  prod env"

read cmd

if [ "${cmd}" == "1" ];then
    echo "your select test environment"
	env="druid"
elif [ "${cmd}" == "2" ];then
	echo "your select fangzhen environment"
	env="druid"
elif [ "${cmd}" == "3" ];then
	echo "your select product environment"
	env="druid"
else
	echo "error!!!,please return select"
	exit 99
	fi

source /home/unilife/.bash_profile
pid_file='pid.pid'
start()
{
        echo $"Starting data translate server ......"
        java -server -Xms1024m -Xmx1024m -jar ../boot/littlebayo.jar --spring.config.location=../config/ --spring.profiles.active=${env} > ../logs/day.log 2>&1 &
        echo $! > $pid_file

        echo $"data translate server started!"
}

stop()
{
        echo $"Stopping data translate server ......"
        pid=`cat $pid_file`
        kill -9 $pid
        echo "stop "$pid
        mv ../logs/day.log ../logs/day.log.bak_`date +%m%d%H%M`
        sleep 1
}

restart()
{
        stop
        sleep 5
        start
}

case "$1" in
start)
        start
        ;;
stop)
        stop
        ;;
restart)
        restart
        ;;
*)
        echo $"Usage: $0 {start|stop|restart}"
        exit 1
esac