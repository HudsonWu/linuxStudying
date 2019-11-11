#!/bin/bash

text1='[vV]\.?[0-9]\.'
text2='none'
text3='.*[rR]elease'

/usr/bin/date > /debug/path/rmi_images.log

echo "docker system prune -f"
docker system prune -f

for text in $text1 $text2 $text3
do
    echo "查找并删除tag匹配 $text 的docker镜像"
    
    if [ -n "$(docker images | grep -E $text)" ]; then
        echo "存在需要删除的镜像, 以下是镜像信息"
        docker images | grep -E $text
        echo "删除这些镜像"
        docker rmi $(docker images | grep -E $text | awk '{print $3}')
    else
        echo "没有需要删除的镜像"
    fi
done
