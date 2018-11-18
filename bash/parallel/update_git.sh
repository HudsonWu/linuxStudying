#!/bin/bash

# 这个shell脚本是用来自动化更新源代码的
# 使用前需要对一些文件做个备份

isapi=false
ismigrate=true

# 是否更新api文档
if [ $# -ne 0 ]; then
    if [ "$1"x = "api"x -o "$2"x = "api"x ]; then
        isapi=true
        echo "It will update your api documents"
        if [ "$1"x = "migrate"x -o "$2"x = "migrate"x ]; then
            ismigrate=true
            echo "It will execute php artisan migrate"
        fi
    elif [ "$1"x = "migrate"x -o "$2"x = "migrate"x ]; then
        ismigrate=true
        echo "It will execute php artisan migrate"
    else
        echo "The parameter isn't right, should be api or migrate"
    fi
else
    echo "You could add 'api' to update api"
    echo "You could add 'migrate' to execute mysql"
fi

# 代码更新统一入口
function update() {
    if [ -d "$2" ]; then
        "$1" "$2" "$3"
    else
        echo "The $2 folder not found, please check it"
    fi
}

# 恢复备份文件
function getbak() {
    if [ -f  "$1.bak" ]; then
        cp -f "$1.bak" "$1"
        echo "getbak success, nothing to worried"
    else
        echo "$1.bak file not found"
    fi
}

# 文件备份
function bak() {
    if [ ! -f "$1.bak" ]; then
        echo "bak file not found, will autobak"
        cp -f "$1" "$1.bak"
    fi
} 

# php代码更新
function php_update() {
    bak "$1/.env"
    bak "$1/app/Containers/Project/Configs/project.php"
    cd $1 && git fetch origin $2 && git merge origin/$2
    
    if [ $? -ne 0 ]; then
        echo "!!!$1($2) merge failed, will change something!!!"
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
    
    echo -e "====$1($2) update complete====\n"
}


# 会员中心
function member_update() {
    bak "$1/config/params.js" && bak "$1/config/session.js" && bak "$1/config/cache.js"
    bak "$1/config/index.js" && bak "$1/config/globals.js"
    cd $1 && git fetch origin $2 && git merge origin/$2
    if [ $? -ne 0 ]; then
        echo "!!!$1($2) merge failed, will reset to origin/$2!!!"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/params.js" && getbak "$1/config/session.js" && getbak "$1/config/cache.js"
        getbak "$1/config/index.js" && getbak "$1/config/globals.js"
    fi
    echo -e "====$1($2) update complete====\n"
}


# 门户网站
function portal_update() {
    bak "$1/config/local.js" && bak "$1/config/cache.js" && bak "$1/config/params.js"
    bak "$1/config/session.js" && bak "$1/config/globals.js"
    cd $1 && git fetch origin $2 && git merge origin/$2
    if [ $? -ne 0 ]; then
        echo "!!!$1($2) merge failed, will reset to origin/$2!!!"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/local.js" && getbak "$1/config/cache.js" && getbak "$1/config/params.js"
        getbak "$1/config/session.js" && getbak "$1/config/globals.js"
    fi
    echo -e "====$1($2) update complete====\n"
}


# api代码更新
function api_update() {
    bak "$1/config/connections.js" && bak "$1/config/local.js" && bak "$1/config/sockets.js" && bak "$1/config/cache.js"
    cd $1 && git fetch origin $2 && git merge origin/$2
    if [ $? -ne 0 ]; then
        echo "!!!$1($2) merge failed, will reset to origin/$2!!!"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/connections.js" && getbak "$1/config/local.js" && getbak "$1/config/sockets.js" && getbak "$1/config/cache.js"
    fi
    echo -e "====$1($2) update complete====\n"
}


# 打包环境更新
function package_update() {
    bak "$1/server.js"
    cd $1 && git fetch origin $2 && git merge origin/$2
    if [ $? -ne 0 ]; then
        echo "!!!$1($2) merge failed, will reset to origin/$2!!!"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/server.js"
    fi
    echo -e "====$1($2) update complete====\n"
}


# VUE环境更新
function vue_update() {
    bak "$1/config/index.js" && bak "$1/src/conf/params.js"
    cd $1 && git fetch origin $2 && git merge origin/$2
    if [ $? -ne 0 ]; then
        echo "!!!$1($2) merge failed, will reset to origin/$2!!!"
        git fetch --all && git reset --hard origin/$2
        getbak "$1/config/index.js" && getbak "$1/src/conf/params.js"
    fi
    echo -e "====$1($2) update complete====\n"
}

# 使用方法
# update [代码更新函数] [代码绝对路径] [代码分支名]
# 一般只需更改代码分支名即可

#update "php_update" "/home/newphp" "master"
#update "vue_update" "/home/consultation" "master"
#update "member_update" "/home/member" "master"
#update "portal_update" "/home/portal" "master"
#update "api_update" "/home/api" "master"
