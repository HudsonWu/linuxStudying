#!/bin/bash

./configure -prefix /opt/qt-4.8.7 -sysconfdir /etc/xdg -confirm-license -opensource -no-phonon -no-phonon-backend -no-webkit -no-openvg -nomake demos -nomake examples -optimized-qmake -v 
if [ $? -ne 0 ]
then
	echo "./configure run failed" >> result.txt
	make confclean
	exit 1
fi

now=$(date)
make >> make.txt 2>&1
if [ $? -ne 0 ]
then
	echo "make failed, now is $now" >> result.txt
	exit 1
else
	make install >> install.txt 2>&1
	echo "make success, now is $now" >> result.txt
	exit 1
fi
