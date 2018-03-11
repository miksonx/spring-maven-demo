#!/bin/bash
#export JAVA_HOME=/usr/java/jdk1.7.0_25
##java -jar /var/lib/jenkins/workspace/example-maven-project/target/spring-data-fundamentals-1.0.0-SNAPSHOT.jar

checkpid()
{
        echo $(ps -ef | grep "spring-data-fundamentals-1.0.0-SNAPSHOT.jar" | grep -v grep | awk '{ print $2}')
}

start ()
{
    if [ $(checkpid) ] ; then
        echo -e "\n$(date +%Y%m%d-%H:%M:%S) spring-data is running (pid:$(checkpid))\n"
    else
        echo ""
        printf "$(date +%Y%m%d-%H:%M:%S) Spring data is starting..."
        #cd /app/mservice/CBTK_new
        nohup java -jar /tmp/spring-data-fundamentals-1.0.0-SNAPSHOT.jar > /dev/null 2>&1 &

    fi

}

stop ()
{
    if [ $(checkpid) ] ; then
        kill -9 $(checkpid)
        echo -e "\n$(date +%Y%m%d-%H:%M:%S) Spring stop success\n"
    fi

}

status ()
{
        if [ $(checkpid) ] ; then
        echo -e "\n$(date +%Y%m%d-%H:%M:%S) Spring demo is running (pid:$(checkpid))\n"
    else
        echo -e "\n$(date +%Y%m%d-%H:%M:%S) Spring demo is not started\n"
    fi
}
restart()
{
        if [ $(checkpid) ] ; then
                stop
                sleep 2
                start
        else
                echo -e "\n$(date +%Y%m%d-%H:%M:%S) Spring demo is not started\n"
        fi
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
  status)
      status
      ;;
  *)
    echo -e "\nUsage: $0 {start|stop|status|restart|reload}\n"
      exit 1
      ;;
esac
