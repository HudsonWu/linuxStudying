#!/bin/bash
./autotool.sh 2>> error_install.log

if [ $? -ne 0 ]; then
    echo "$(date)" >> result.txt
    echo "./autotool.sh failed" >> result.txt
    echo -e "\n---- ./autotool.sh failed ----\n" >> error_install.log
    exit 1
fi

./configure 2>> error_install.log

if [ $? -ne 0 ]; then
    echo "$(date)" >> result.txt
    echo "./configure failed" >> result.txt
    echo -e "\n---- ./configure failed ----\n" >> error_install.log
    exit 1
fi

make 2>> error_install.log

if [ $? -ne 0 ]; then
    echo "$(date)" >> result.txt
    echo "run make command failed" >> result.txt
    echo -e "\n---- rum make command failed ----\n" >> error_install.log
    exit 1
fi

mkdir ~/.twister 
echo -e "rpcuser=user\nrpcpassword=pwd" > ~/.twister/twister.conf
chmod 600 ~/.twister/twister.conf
git clone https://github.com/miguelfreitas/twister-html.git ~/.twister/html 2>> error_install.log

