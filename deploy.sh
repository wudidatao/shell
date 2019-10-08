#!/bin/bash
#APP_NAME=register-service
#JAR_NAME=register-service-1.0.jar
#LOG_NAME=register-service
#IP=`ip addr |grep inet |grep -v inet6 |grep eth0|awk '{print $2}' |awk -F "/" '{print $1}' | awk -F "." '{print $3$4}'`
#APM_SERVER_URL=http://10.248.245.117:8200

#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh $APP_NAME.sh [start|stop|restart|status]"
    exit 1
}

#检查程序是否在运行
is_exist(){
  pid=`ps -ef|grep $JAR_NAME|grep -v grep|awk '{print $2}' `
  #如果不存在返回1，存在返回0
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}

#启动方法
start(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${JAR_NAME} is already running. pid=${pid} ."
  else
    #nohup java -javaagent:/home/scapp/52oak/elastic-apm-agent-1.8.0.jar -Delastic.apm.service_name=$APP_NAME$IP -Delast.apm.secret_token= -Delastic.apm.application_packages=org.example -jar $JAR_NAME > $LOG_NAME 2>&1 &
    #tail -f $LOG_NAME
    nohup java -jar $JAR_NAME >> $LOG_NAME 2>&1 &

    echo "${JAR_NAME} start success"
  fi
}

#停止方法
stop(){
  is_exist
  if [ $? -eq "0" ]; then
    kill -9 $pid
  else
    echo "${JAR_NAME} is not running"
  fi
}

#输出运行状态
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${JAR_NAME} is running. Pid is ${pid}"
  else
    echo "${JAR_NAME} is NOT running."
  fi
}

#重启
restart(){
  stop
  start
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac

