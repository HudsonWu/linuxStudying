#!/bin/bash

vue_path=/tmp/ParallelConsultationForVue
pro_path=/tmp/ParallelConsultingPro
date=`date +"%Y-%m-%d"`

if [ -d $vue_path ]; then
    echo "删除/tmp下存在的vue代码"
    rm -rf $vue_path
fi

if [ -d $pro_path ]; then
    echo "删除/tmp下存在的pro代码"
    rm -rf $pro_path
fi

echo "拉取咨询机构待打包代码"
cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/ParallelConsultationForVue.git

echo "拉取咨询机构已打包代码"
cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/ParallelConsultingPro.git

if [ $? -ne 0 ]; then
    echo "代码下拉失败, 请检查出现的错误"
    exit 1
fi

echo "覆盖配置文件"
if [ -f /tmp/params.js -a -f /tmp/index.js ]; then
    cp -f /tmp/params.js $vue_path/src/conf/ && cp -f /tmp/index.js $vue_path/config/
else
    echo "请将param.js和index.js两个配置文件放置于/tmp目录下"
    exit 0
fi

echo "安装依赖包"
cd $vue_path && npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver \
&& npm install

if [ $? -ne 0 ]; then
    echo "换用taobao镜像重新安装"
    npm --registry=https://registry.npm.taobao.org \
    --cahce=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc install
    if [ $? -ne 0 ]; then
        echo "依赖包安装失败, 请检查出现的错误"
        exit 1
    fi
fi

echo "开始打包代码"
cd /tmp/ParallelConsultationForVue && npm run build

if [ $? -ne 0 ]; then
    echo "代码打包失败，请检查出现的错误"
    exit 1
fi

cp -rf $vue_path/dist $pro_path/dist

echo "将代码提交"
cd $pro_path && git add --all && git commit -m "new version $date"

if [ $? -ne 0 ]; then
    echo "代码提交失败, 请检查出现的错误"
    exit 1
fi

echo "上传代码"
cd $pro_path && git push

echo "删除代码"
cd /tmp && rm -rf $vue_path $pro_path
