#!/bin/bash
date=`date +"%Y-%m-%d %H:%m:%S"`
echo "today is $date"

mysql -uroot -pyfyunmysql << EOF
use parallel;
update mettings set time="$date";
EOF

echo "everything is ok"
