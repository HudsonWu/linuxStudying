#!/bin/bash
# Epoch 新纪元
source="/root/.vimrc"
gitVim="/root/myGithub/vimStudying/vimrc"
read last_time < /root/myGithub/vimStudying/autoUpdate/mtime
new_time=`stat -c %Y /root/.vimrc`
echo "new_time=$new_time"
new_time_human=`stat -c %y /root/.vimrc`
echo "new_time_human=$new_time_human"
if [ $new_time -gt $last_time ]; then
	cp $source $gitVim
	echo $new_time > /root/myGithub/vimStudying/autoUpdate/mtime
	echo $new_time_human >> /root/myGithub/vimStudying/autoUpdate/mtime
	echo 'update success'
else
	echo 'nothing to do'
fi


