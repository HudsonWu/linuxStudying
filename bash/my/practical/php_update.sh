#!/bin/bash

cd /path/php_code
isbak=0

echo "是否需要备份(0表示不备份, 1表示要备份)"
read isbak

if [ $isbak -eq 1 ]; then
    echo "备份"
    php artisan backup:run
else
    echo "将不会备份"
fi

echo "下拉最新代码"
git pull

if [ $? -ne 0 ]; then
    echo "代码下拉失败, 请检查错误"
    exit 0
fi

echo "执行数据库"
php artisan migrate

if [ $? -ne 0 ]; then
    echo "数据库执行错误, 请检查错误"
    exit 0
fi

isdb=0
echo "是否需要执行db:seed命令(0表示不执行, 1表示执行)"
read isdb

if [ $isdb -eq 1 ]; then
    echo "你选择了执行db:seed命令"
    echo "请输入app/Containers/Authorization/Data/Seeders目录下需要执行的文件"
    echo "按下 <CTRL-D> 退出"
    while read filename
    do
        echo "将执行 $filename 文件"
        php artisan db:seed --class=App\\Containers\\Authorization\\Data\\Seeders\\$filename
    done
else
    echo "将不执行db:seed命令"
fi

echo "重启队列服务"
supervisorctl restart all
