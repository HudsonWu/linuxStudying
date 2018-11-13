#!/bin/bash
  
vue=ParallelConsultationForVue
vue_path=/tmp/ParallelConsultationForVue
pro=ParallelConsultingPro
pro_path=/tmp/ParallelConsultingPro
branch=master

function help() {
    echo "功能:"
    echo "step1: 下拉vue代码, 安装chromedriver包"
    echo "step2: 安装依赖包, 配置文件覆盖, 打包生成dist/, 将dist/复制到pro代码, 提交pro代码, 上传到远程"
    echo -e "\nUsage:"
    echo "$0 1 2    先执行step1, 再执行step2"
    echo "$0 2      只执行step2(默认已经下载好了代码)"
    echo "$0 1      只执行step1"
}

function step1() {    
    
    if [ -d $vue_path ]; then
        echo "删除$vue_path目录"
        rm -rf $vue_path
    fi
    
    if [ -d $pro_path ]; then
        echo "删除$pro_path目录"
        rm -rf $pro_path
    fi
    
    echo "拉取咨询机构待打包代码"
    if [ "$branch"x = "master"x ]; then
        echo "master分支"
        cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/$vue.git
    else
        echo "$branch 分支"
        cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/$vue.git -b $branch
    fi
    
    echo "拉取咨询机构已打包代码"
    cd /tmp && git clone --depth 1 http://Wu@gitlab.lmdo.cn/binglian/$pro.git
    
    if [ $? -ne 0 ]; then
        echo "代码下拉失败, 请检查出现的错误"
        exit 1
    fi
    
    echo "安装chromedriver包"
    cd $vue_path && npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver

    echo -e "step1 完成\n"

}

function step2() {    
    
    result=`sed -n '/"build"/p' $vue_path/package.json | grep max`
    
    if [ "$result"x = ""x ]; then
        echo "解决打包时内存溢出问题"
        sed -i "s/build\/build.js/--max_old_space_size=4096\ build\/build.js/g" $vue_path/package.json
    fi

    echo "覆盖配置文件"
    if [ -f /tmp/params.js -a -f /tmp/index.js ]; then
        cp -f /tmp/params.js $vue_path/src/conf/params.js && cp -f /tmp/index.js $vue_path/config/index.js
    else
        echo "请将param.js和index.js两个配置文件放置于/tmp目录下"
        exit 0
    fi
    
    echo "安装依赖包"
    cd $vue_path && npm install

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

    if [ -d $vue_path/dist ]; then
        echo "$vue_path/dist目录已存在, 将删除"
        rm -rf $vue_path/dist
    fi
    
    echo "开始打包代码"
    
    date_start=`date +"%Y-%m-%d_%H:%M:%S"`
    echo -e "\n----------" >> ~/pack_time.txt
    echo "$date_start 开始打包" >> ~/pack_time.txt
    cd $vue_path && (time npm run build) 2>> ~/pack_time.txt
    
    if [ $? -ne 0 ]; then
        echo "代码打包失败，请检查出现的错误"
        exit 1
    fi

#    pack_time=$(cat ~/pack_time.txt)
    
    echo "删除pro下的dist/"
    rm -rf $pro_path/dist
    echo "复制vue下的dist/到pro/下"
    cp -rf $vue_path/dist $pro_path/dist
    
    echo "将代码提交"
    date_end=`date +"%Y-%m-%d_%H:%M:%S"`
    echo -e "$date_end 打包完成\n" >> ~/pack_time.txt
    if [ -f $pro_path/server.js -a -d $pro_path/dist ]; then
        cd $pro_path && git add --all && git commit -m "new version $date_end"
        echo "上传代码"
        cd $pro_path && git push origin master
        if [ $? -ne 0 ]; then
            echo "代码提交失败, 请检查出现的错误"
            exit 1
        fi
    else
        echo "重要文件丢失"
        exit 0
    fi

    
    
    echo "打包时间区间: $date_start -- $date_end"
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
        echo "参数是1, 将执行step1"
        step1
        if [ $2 -eq 2 ]; then
            echo "第二个参数是2, 将执行step2"
            step2
        fi
    elif [ $1 -eq 2 ]; then
        echo "参数是2, 将执行step2"
        if [ -d $vue_path -a -d $pro_path ]; then
            echo "$pro代码下拉更新"
            cd $pro_path && git pull origin master
            echo "$vue代码下拉更新"
            cd $vue_path && git pull origin master
        else
            echo "/tmp目录下没有找到相关项目的代码"
            exit 0
        fi
        step2
    else
        echo "请检查参数是否正确"
        help
    fi
else
    help
fi
