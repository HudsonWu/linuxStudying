#!/bin/bash
source="~/.vimrc"
gitVim="~/MyGithub/vimrc"
read last_time < ~/MyGithub/mtime
new_time=`stat -c %Y ~/.vimrc`
new_time_human=`stat -c %y ~/.vimrc`
if [ $new_time -gt $last_time ]; then
	cp $source $gitVim
	echo $new_time > ~/MyGithub/mtime
	echo $new_time_human >> ~/MyGithub/mtime
	echo 'update success'
else
	echo 'nothing to do'
fi


