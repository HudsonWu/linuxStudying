#!/bin/bash

#  
# Filename: to_online.sh
# Description: step1, clone code to local; step2, npm run build and git push
# Author: HudsonWu
# Email: wuhaishui1234@gmail.com
# Revision: 0.1
# Date: 2018-01-15
# Note: prod
#

#
# step1, 下拉vue的master分支代码, 下拉pro的特定分支代码 (目的是先更新到分支, 没问题时再手动合并到master)
# step2, vue代码的一些必要配置, 打包vue代码, 生成dist目录, 完全取代pro代码下的dist目录, 提交到pro代码的指定分支 
#


vue="ParallelConsultationForVue"
vue_path="/tmp/ParallelConsultationForVue"

pro="ParallelConsultingPro"
pro_path="/tmp/ParallelConsultingPro"
pro_branch="test"

function help() {
    echo -e "\e[34;40m 功能:\e[0m"
    echo -e "\e[34;40m step1: git clone vue和pro代码\e[0m"
    echo -e "\e[34;40m step2: 配置文件覆盖, 打包生成dist/, 将dist/复制到pro代码, 提交pro代码, 上传到远程\e[0m"
    echo -e "\n\e[34;40m Usage:\e[0m"
    echo -e "\e[34;40m $0 1 2    先执行step1, 再执行step2\e[0m"
    echo -e "\e[34;40m $0 2      只执行step2(默认已经下载好了代码)\e[0m"
    echo -e "\e[34;40m $0 1      只执行step1\e[0m"
}

function update() {
    if [ -d $vue_path -a -d $pro_path ]; then
        echo -e "\e[32;40m $pro代码下拉更新\e[0m"
        cd $pro_path && git pull origin master
        if [ $? -ne 0 ]; then
            echo -e "\e[31;40m $pro_path 代码更新失败\e[0m"
            exit 1
        fi
        echo -e "\e[32;40m $vue代码下拉更新\e[0m"
        cd $vue_path && git pull origin master
        if [ $? -ne 0 ]; then
            echo -e "\e[31;40m $vue_path 代码更新失败\e[0m"
            exit 1
        fi
    else
        echo -e "\e[33;40m /tmp目录下没有找到相关项目的代码\e[0m"
        exit 0
    fi
}

function config() {

    result=`sed -n '/"build"/p' $vue_path/package.json | grep max`
    
    if [ "$result"x = ""x ]; then
        echo -e "\e[32;40m 解决打包时内存溢出问题\e[0m"
        sed -i "s/build\/build.js/--max_old_space_size=4096\ build\/build.js/g" $vue_path/package.json
    fi

    echo -e "\e[32;40m 覆盖配置文件\e[0m"
    if [ -f /tmp/params.js -a -f /tmp/index.js ]; then
        cp -f /tmp/params.js $vue_path/src/conf/params.js && cp -f /tmp/index.js $vue_path/config/index.js
    else
        echo -e "\e[33;40m 请将param.js和index.js两个配置文件放置于/tmp目录下\e[0m"
        exit 0
    fi
}

function get_node_version() {
    
    # npm在10版本以上时在root环境下需要加上--unsafe-perm --allow-root参数
    node_version=`node -v | awk -F. '{print $1}'`
    if [ ${node_version:1} -ge 10 ]; then
        echo true
    fi
}

function standard_npm() {
    
    # 接收参数, 为true时以node10以上加参数方式安装
    # 为false时以node10以下方式安装

    if $1 ; then
        echo -e "\e[32;40m node10以上有参数的标准化依赖包安装流程\e[0m\n"
        echo -e "\e[32;40m 安装chromedriver包\e[0m"
        cd $vue_path && npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver \
        --unsafe-perm --allow-root
        echo -e "\e[32;40m 安装依赖包\e[0m"
        cd $vue_path && npm install --unsafe-perm=true --allow-root
        
        if [ $? -ne 0 ]; then
            echo -e "\e[32;40m 换用taobao镜像重新安装\e[0m"
            npm --registry=https://registry.npm.taobao.org \
            --cahce=$HOME/.npm/.cache/cnpm \
            --disturl=https://npm.taobao.org/dist \
            --userconfig=$HOME/.cnpmrc install \
            --unsafe-perm=true --allow-root
            
            if [ $? -ne 0 ]; then
                echo -e "\e[31;40m 依赖包安装失败, 请检查出现的错误\e[0m"
                exit 1
            fi
        fi
    else
        echo -e "\e[32;40m node小于10版本的标准化依赖包安装流程\e[0m\n"
        echo -e "\e[32;40m 安装chromedriver包\e[0m"
        cd $vue_path && npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver
    
        echo -e "\e[32;40m 安装依赖包\e[0m"
        cd $vue_path && npm install
    
        if [ $? -ne 0 ]; then
            echo -e "\e[32;40m 换用taobao镜像重新安装\e[0m"
            npm --registry=https://registry.npm.taobao.org \
            --cahce=$HOME/.npm/.cache/cnpm \
            --disturl=https://npm.taobao.org/dist \
            --userconfig=$HOME/.cnpmrc install
            if [ $? -ne 0 ]; then
                echo -e "\e[31;40m 依赖包安装失败, 请检查出现的错误\e[0m"
                exit 1
            fi
        fi
    fi

}

function npm_install() {
    
    node10=get_node_version

    # 接受一个参数, 为false时直接完整执行标准流程, 
    # 为true时先直接 执行npm install, 失败时再执行标准流程
    
    if $1 ; then
        if $node10 ; then
            echo -e "\e[32;40m node版本在10以上, 安装依赖包时会加上必要参数\e[0m"
            cd $vue_path && npm install --unsafe-perm=true --allow-root
            
            if [ $? -ne 0 ]; then
                if [ -d $vue_path/node_modules -a -f $vue_path/package-lock.json ]; then
                    cd $vue_path && rm -rf node_modules package-lock.json
                fi
                standard_npm true
            fi
        else
            echo -e "\e[32;40m node版本小于10\e[0m"
            cd $vue_path && npm install 
            
            if [ $? -ne 0 ]; then
                if [ -d $vue_path/node_modules -a -f $vue_path/package-lock.json ]; then
                    cd $vue_path && rm -rf node_modules package-lock.json
                fi
                standard_npm false
            fi
        fi
    else
        if $node10 ; then
            standard_npm true
        else
            standard_npm false
        fi
    fi

}

function step1() {    
    
    if [ -d $vue_path ]; then
        echo -e "\e[32;40m 删除$vue_path目录\e[0m\e[0m"
        rm -rf $vue_path
    fi
    
    if [ -d $pro_path ]; then
        echo -e "\e[32;40m 删除$pro_path目录\e[0m"
        rm -rf $pro_path
    fi
    
    echo -e "\e[32;40m 拉取咨询机构vue待打包的(master分支)代码\e[0m"
    cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/$vue.git

    if [ $? -ne 0 ]; then
        echo -e "\e[31;40m $vue_path 代码下拉失败, 请检查出现的错误\e[0m"
        exit 1
    fi
    
    echo -e "\e[32;40m 拉取咨询机构pro已打包($pro_branch分支)代码\e[0m"
    cd /tmp && git clone -b $pro_branch --depth 1 http://Wu@gitlab.lmdo.cn/binglian/$pro.git
    
    if [ $? -ne 0 ]; then
        echo -e "\e[31;40m $pro_path 代码下拉失败, 请检查出现的错误\e[0m"
        exit 1
    fi
    
    echo -e "\e[32;40m step1 完成\n\e[0m"

}

function step2() {    

    config

    if [ -d $vue_path/node_modules -a -f $vue_path/package-lock.json ]; then
        npm_install true
    else
        npm_install false
    fi

    echo "解决API version问题"
    #sed -i "s/1.10.97/1.10.100/g" $vue_path/static/pdfjs/pdf.worker.js
    #sed -i "s/1.10.97/1.10.100/g" $vue_path/static/pdfjs/pdf.worker.min.js
    cp -f $vue_path/node_modules/pdfjs-dist/build/pdf.worker.js $vue_path/static/pdfjs/
    cp -f $vue_path/node_modules/pdfjs-dist/build/pdf.worker.js.map $vue_path/static/pdfjs/
    cp -f $vue_path/node_modules/pdfjs-dist/build/pdf.worker.min.js $vue_path/static/pdfjs/

    if [ -d $vue_path/dist ]; then
        echo -e "\e[32;40m $vue_path/dist目录已存在, 将删除\e[0m"
        rm -rf $vue_path/dist
    fi
    
    echo -e "\e[32;40m 开始打包代码\e[0m"
    
    date_start=`date +"%Y-%m-%d_%H:%M:%S"`
    echo -e "\n----------" >> ~/pack_time.txt
    echo "$date_start 开始打包" >> ~/pack_time.txt
    cd $vue_path && (time npm run build) 2>> ~/pack_time.txt
    
    if [ $? -ne 0 ]; then
        echo -e "\e[31;40m 代码打包失败，请检查出现的错误\e[0m"
        exit 1
    fi

#    pack_time=$(cat ~/pack_time.txt)
    
    echo -e "\e[32;40m 删除pro下的dist/\e[0m"
    rm -rf $pro_path/dist
    echo -e "\e[32;40m 复制vue下的dist/到pro/下\e[0m"
    cp -rf $vue_path/dist $pro_path/dist
    
    date_end=`date +"%Y-%m-%d_%H:%M:%S"`
    echo -e "$date_end 打包完成\n" >> ~/pack_time.txt
    
    echo -e "\e[32;40m 将代码提交\e[0m"
    if [ -f $pro_path/server.js -a -d $pro_path/dist ]; then
        cd $pro_path && git add --all && git commit -m "new version $date_end"
        echo -e "\e[32;40m 上传代码\e[0m"
        cd $pro_path && git push origin $pro_branch:$pro_branch
        if [ $? -ne 0 ]; then
            echo -e "\e[31;40m 代码提交失败, 请检查出现的错误\e[0m"
            exit 1
        fi
    else
        echo -e "\e[32;40m 重要文件丢失\e[0m"
        exit 0
    fi

    
    echo -e "\e[34;40m 打包时间区间: $date_start -- $date_end\e[0m"
#    echo "打包花费的时间统计"
#    for i in $pack_time
#    do
#        if [[ $i = *m*s ]]; then
#            echo -e "$i\n"
#        else
#            echo $i
#        fi
#    done
    
} 

if [ $# -ne 0 ]; then
    if [ $1 -eq 1 ]; then
        echo -e "\e[32;40m 参数是1, 将执行step1\e[0m"
        step1
        if [ $2 -eq 2 ]; then
            echo -e "\e[32;40m 第二个参数是2, 紧接着执行step2\e[0m"
            step2
        fi
    elif [ $1 -eq 2 ]; then
        echo -e "\e[32;40m 第一个参数是2, 将只执行step2\e[0m"
        update
        step2
    else
        help
    fi
else
    help
fi