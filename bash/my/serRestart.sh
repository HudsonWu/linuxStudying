#!/bin/bash

appName=('app1' 'app2' 'app3' 'app4' 'app5' 'app6')


function for_help() {
    echo -e "\e[36;40m 使用方法:\e[0m"
    echo -e "\e[34;40m $0 app-name1\e[0m\n"
    echo -e "\e[36;40m app-name可以选择的值:\e[0m"
    echo -e "\e[34;40m ${appName[0]}\e[0m"
    echo -e "\e[34;40m ${appName[1]}\e[0m"
    echo -e "\e[34;40m ${appName[2]}\e[0m"
    echo -e "\e[34;40m ${appName[3]}\e[0m"
    echo -e "\e[34;40m ${appName[4]}\e[0m"
    echo -e "\e[34;40m ${appName[5]}\e[0m"
}

if [[ $# -ne 0 ]]; then
    for app1 in $@; do
        for app2 in ${appName[@]}; do
            if [[ $app1 == $app2 ]]; then
                echo -e "\e[36;40m 将重启 $app2 应用 \e[0m"
                cd /var/www/fairhr && docker-compose restart $app2
                if [[ $? -eq 0 ]]; then
                    echo -e "\e[34;40m $app2 应用重启成功\e[0m"
                fi
            fi
        done
    done
else
    for_help
fi
