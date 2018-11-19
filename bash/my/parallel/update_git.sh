#!/bin/bash

# 这个shell脚本是用来自动化更新源代码的
# 使用前需要对一些文件做个备份

isapi=false
ismigrate=true

# 是否更新api文档
if [ $# -ne 0 ]; then
    if [ "$1"x = "api"x -o "$2"x = "api"x ]; then
        isapi=true
        echo -e "\e[33;40m It will update your api documents\e[0m"
        if [ "$1"x = "migrate"x -o "$2"x = "migrate"x ]; then
            ismigrate=true
            echo -e "\e[33;40m It will execute php artisan migrate\e[0m"
        fi
    elif [ "$1"x = "migrate"x -o "$2"x = "migrate"x ]; then
        ismigrate=true
        echo -e "\e[33;40m It will execute php artisan migrate\e[0m"
    else
        echo -e "\e[31;40m The parameter isn't right, should be api or migrate\e[0m"
    fi
else
    echo -e "\e[32;40m You could add 'api' to update api\e[0m"
    #echo -e "\e[32;40m You could add 'migrate' to execute mysql\e[0m"
fi

# 代码更新统一入口
function update() {
    if [ -d "$2" ]; then
        "$1" "$2" "$3"
    else
        echo -e "\e[33;40m The $2 folder not found, please check it\e[0m"
    fi
}

# 恢复备份文件
function getbak() {
    if [ -f  "$1.bak" ]; then
        cp -f "$1.bak" "$1"
        echo -e "\e[32;40m getbak success, nothing to worried\e[0m"
    else
        echo -e "\e[31;40m $1.bak file not found\e[0m"
    fi
}

# 文件备份
function bak() {
    if [ -f "$1" ]; then
        if [ ! -f "$1.bak" ]; then
            echo -e "\e[32;40m bak file not found, will autobak\e[0m"
            cp -f "$1" "$1.bak"
        fi
    else
        echo -e "\e[31;40m $1 file not found\e[0m"
    fi
}

# php代码更新
function php_update() {
    bak "$1/.env"
    bak "$1/app/Containers/Project/Configs/project.php"
    cd $1 && git fetch origin && git merge origin/$2 -m "merge $2"
    # cd $1 && git fetch origin && git merge --no-edit origin/$2
    # cd $1 && git pull --no-edit origin $2
    
    if [ $? -ne 0 ]; then
        echo -e "\e[31:40m !!!$1($2) merge failed, will change something!!!\e[0m"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/.env"
        getbak "$1/app/Containers/Project/Configs/project.php"
    fi

    if [ "$ismigrate" = true ]; then
        cd $1 && php artisan migrate
    fi

    if [ "$isapi" = true ]; then
        cd $1 && apidoc -i . -o public/api/
    fi
    
    echo -e "\e[34;40m ====$1($2) update complete====\n\e[0m"
}


# 会员中心
function member_update() {
    bak "$1/config/params.js" && bak "$1/config/session.js" && bak "$1/config/cache.js"
    bak "$1/config/index.js" && bak "$1/config/globals.js"
    cd $1 && git fetch origin && git merge origin/$2 -m "merge $2"
    if [ $? -ne 0 ]; then
        echo -e "\e[31:40m !!!$1($2) merge failed, will reset to origin/$2!!!\e[0m"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/params.js" && getbak "$1/config/session.js" && getbak "$1/config/cache.js"
        getbak "$1/config/index.js" && getbak "$1/config/globals.js"
    fi
    echo -e "\e[34;40m ====$1($2) update complete====\n\e[0m"
}


# 门户网站
function portal_update() {
    bak "$1/config/local.js" && bak "$1/config/cache.js" && bak "$1/config/params.js"
    bak "$1/config/session.js" && bak "$1/config/globals.js"
    cd $1 && git fetch origin && git merge origin/$2 -m "merge $2"
    if [ $? -ne 0 ]; then
        echo -e "\e[31:40m !!!$1($2) merge failed, will reset to origin/$2!!!\e[0m"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/local.js" && getbak "$1/config/cache.js" && getbak "$1/config/params.js"
        getbak "$1/config/session.js" && getbak "$1/config/globals.js"
    fi
    echo -e "\e[34;40m ====$1($2) update complete====\n\e[0m"
}


# api代码更新
function api_update() {
    bak "$1/config/connections.js" && bak "$1/config/local.js" && bak "$1/config/sockets.js" && bak "$1/config/cache.js"
    cd $1 && git fetch origin && git merge origin/$2 -m "merge $2"
    if [ $? -ne 0 ]; then
        echo -e "\e[31:40m !!!$1($2) merge failed, will reset to origin/$2!!!\e[0m"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/connections.js" && getbak "$1/config/local.js" && getbak "$1/config/sockets.js" && getbak "$1/config/cache.js"
    fi
    echo -e "\e[34;40m ====$1($2) update complete====\n\e[0m"
}


# 打包环境更新
function package_update() {
    bak "$1/server.js"
    cd $1 && git fetch origin && git merge origin/$2 -m "merge $2"
    if [ $? -ne 0 ]; then
        echo -e "\e[31:40m !!!$1($2) merge failed, will reset to origin/$2!!!\e[0m"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/server.js"
    fi
    echo -e "\e[34;40m ====$1($2) update complete====\n\e[0m"
}


# VUE环境更新
function vue_update() {
    bak "$1/config/index.js" && bak "$1/src/conf/params.js"
    cd $1 && git fetch origin && git merge origin/$2 -m "merge $2"
    if [ $? -ne 0 ]; then
        echo -e "\e[31:40m !!!$1($2) merge failed, will reset to origin/$2!!!\e[0m"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/index.js" && getbak "$1/src/conf/params.js"
    fi
    echo -e "\e[34;40m ====$1($2) update complete====\n\e[0m"
}

# 使用方法
# update [代码更新函数] [代码绝对路径] [代码分支名]
# 一般只需更改代码分支名即可

#update "vue_update" "/home/consultation" "master"
#update "member_update" "/home/member" "master"
#update "portal_update" "/home/portal" "master"
#update "api_update" "/home/api" "master"
update "php_update" "/home/newphp" "printing"
update "php_update" "/home/Newphp" "dev"
#update "php_update" "/home/Newphp" "master"
update "vue_update" "/home/Consultation" "ReportPrinting"
#update "vue_update" "/home/Consultation" "master"
