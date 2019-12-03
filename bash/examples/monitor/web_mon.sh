#!/bin/bash

#====================================================
# Author: yourname - EMail:yourname@mailser.com
# Last modified: 2019-2-1 
# Filename: web_mon.sh
# Description: wget monitoring web is normal 
#====================================================

while true
do
  Mail="yourname@mailser.com" 
  FailCount=0
  Retval=0

  GetUrlStatus() {

    for ((i=1;i<=3;i++))     #使用i++判断访问次数，如果wget两次超时则判断网站异常
    do
      wget -T 3 --tries=1 --spider http://${1} >/dev/null 2>&1
      #-T超时时间，--tries尝试1次，--spider蜘蛛
      [ $? -ne 0 ] && let FailCount+=1;    #访问超时时，$?不等于0，则FailCount加1
    done

    if [ $FailCount -gt 1 ];then
        Retval=1
        Date=`date +%F" "%H:%M`
        echo -e "Date : $Date\nProblem : ${1} is not running." | mutt -s "URL Monitor" $Mail
    else
        Retval=0
    fi

    return $Retval        #如果返回值为0，就正常退出循环，不为0则继续循环
  }

  for url in `cat url.txt | sed '/^#/d'`
  do
    #GetUrlStatus $url && echo yes || echo no
    GetUrlStatus $url
  done

  #死循环，设置每2分钟运行一次
  sleep 2m

done
