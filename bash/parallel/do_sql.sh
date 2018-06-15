#!/bin/bash
date=`date +"%Y-%m-%d %H:%m:%S"`

mysql -uroot -pyfyunmysql << EOF
use parallel;
update mettings set time="$date";
EOF

if [ $? -eq 0 ]; then
    echo "today is $date"
    echo "everything is ok"
fi
