#!/bin/bash
  
#  做的事情:
#  step1: 下拉vue代码, 安装依赖包
#  step2: 配置文件覆盖, 打包生成dist/, 将dist/复制到pro代码, 提交pro代码, 上传到远程

vue_path=/tmp/ParallelConsultationForVue
pro_path=/tmp/ParallelConsultingPro
date=`date +"%Y-%m-%d"`
branch=dev

function step1() {    
    
    if [ -d $vue_path ]; then
        echo "删除/tmp下存在的vue代码"
        rm -rf $vue_path
    fi
    
    if [ -d $pro_path ]; then
        echo "删除/tmp下存在的pro代码"
        rm -rf $pro_path
    fi
    
    echo "拉取咨询机构待打包代码"
    if [ "$branch"x = "master"x ]; then
        echo "master分支"
        cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/ParallelConsultationForVue.git
    else
        echo "$branch 分支"
        cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/ParallelConsultationForVue.git -b $branch
    fi
    
    echo "拉取咨询机构已打包代码"
    cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/ParallelConsultingPro.git
    
    if [ $? -ne 0 ]; then
        echo "代码下拉失败, 请检查出现的错误"
        exit 1
    fi
    
}

function step2() {    
    
    result=`sed -n '/"build"/p' $vue_path/package.json | grep max`
    
    if [ "$result" = "" ]; then
        echo "解决打包时内存溢出问题"
        sed -i "s/build\/build.js/--max_old_space_size=4096\ build\/build.js/g" $vue_path/package.json
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

    echo "解决API version问题"
    #sed -i "s/1.10.97/1.10.100/g" $vue_path/static/pdfjs/pdf.worker.js
    #sed -i "s/1.10.97/1.10.100/g" $vue_path/static/pdfjs/pdf.worker.min.js
    cp -f $vue_path/node_modules/pdfjs-dist/build/pdf.worker.js $vue_path/static/pdfjs/
    cp -f $vue_path/node_modules/pdfjs-dist/build/pdf.worker.js.map $vue_path/static/pdfjs/
    cp -f $vue_path/node_modules/pdfjs-dist/build/pdf.worker.min.js $vue_path/static/pdfjs/

    
    echo "开始打包代码"
    cd /tmp/ParallelConsultationForVue && npm run build
    
    if [ $? -ne 0 ]; then
        echo "代码打包失败，请检查出现的错误"
        exit 1
    fi
    
    echo "删除pro下的dist/"
    rm -rf $pro_path/dist
    echo "复制vue下的dist/到pro/下"
    cp -rf $vue_path/dist $pro_path/dist
    
    echo "将代码提交"
    cd $pro_path && git add --all && git commit -m "new version $date"
    
    if [ $? -ne 0 ]; then
        echo "代码提交失败, 请检查出现的错误"
        exit 1
    fi
    
    echo "上传代码"
    cd $pro_path && git push
    
    # echo "删除代码"
    # cd /tmp && rm -rf $vue_path $pro_path
} 

if [ $# -ne 0 ]; then
    if [ $1 -eq 1 ]; then
        echo "参数是1, 将执行step1"
        step1
        if [ $2 -eq 2 ]; then
            echo "第二个参数是2, 将执行step2"
            step2
        fi
    elif [ $1 -eq 2 ]; then
        echo "参数是2, 将执行step2"
        step2
    else
        echo "请检查参数是否正确, 只能是 1 或 2"
    fi
else
    echo "没有参数, 请添加参数"
fi