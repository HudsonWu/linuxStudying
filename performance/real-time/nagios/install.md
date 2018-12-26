# Nginx下搭建Nagios监控平台

## nagios

+ Install Dev Tools, PHP, Nginx
```
  sudo yum install nginx php php-fpm php-common gcc glibc glibc-common gd gd-devel make net-snmp unzip -y
  sudo yum groupinstall 'Development Tools' -y
```

+ Creating User
```
  useradd nagios
  usermod -aG nagios nginx
```

+ Nagios Core
```
  //Download Nagios Core
  wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.3.4.tar.gz

  //Extracting the Binaries
  tar zxf nagios-4.3.4.tar.gz
  cd nagios-4.3.4

  //Compiling the binaries and installing Nagios
  sudo su
  cd nagios-4.3.4
  ./configure && make all && make install && make install-init && make install-config && make install-commandmode && make install-webconf

  //Verifying Nagios Configuration
  /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
```

+ Extra Plugins
```
  //Install Extra Plugins
  yum install nagios-plugins-all -y

  //creating soft link for new plugins and also remove the default plugins
  rm -rf /usr/local/nagios/libexec
  ln -s /usr/lib64/nagios/plugins /usr/local/nagios/libexec
  chown -R nagios:nagios /usr/local/nagios/libexec
```

+ Start Nagios and Enable nagios for startup at boot
```
  systemctl start nagios
  systemctl enable nagios
```

+ Creating password for nagiosadmin user
```
  htpasswd -c /usr/local/nagios/passwd nagiosadmin
```

+ Creating directory for user and creating links
```
  mkdir /usr/local/nagios/share/nagios
  cd /usr/local/nagios/share/nagios/
  ln -s /usr/local/nagios/share/stylesheets/ stylesheets
  ln -s /usr/local/nagios/share/js js
```

## Nginx

+ Nagios Configuration
```
  cd /etc/nginx/conf.d
  sudo vi nagios.conf
```

+ Nginx - Nagios Configuration with PHP-FCGI
```
server {
    listen 80;
    server_name nagios.yebbare.com;
    access_log /var/log/nginx/nagios-access.log;
    error_log /var/log/nginx/nagios-error.log info;
    root /usr/local/nagios/share;
    index index.html index.php;
    auth_basic "Nagios Restricted Access";
    auth_basic_user_file /usr/local/nagios/passwd;
 
    location /stylesheets {
        alias /usr/local/nagios/share/stylesheets;
    }
    location ~ .cgi$ {
        root /usr/local/nagios/sbin/;
        include fastcgi_params;
        rewrite ^/nagios/cgi-bin/(.*).cgi /$1.cgi break;
        fastcgi_param AUTH_USER $remote_user;
        fastcgi_param REMOTE_USER $remote_user;
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
        fastcgi_param SCRIPT_FILENAME /usr/local/nagios/sbin/$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_script_name;
    }
    location ~ .php$ {
        include fastcgi_params;
        fastcgi_pass unix:/var/run/php-fpm/nagios.socket;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME /usr/local/nagios/share/$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_script_name;
    }
    location ~ (.*.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|rss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf))$ {
        root /usr/local/nagios/share/;
        rewrite ^/nagios/(.*) /$1 break;
        access_log off; expires max;
    }
}
```

+ Firewall Configuration
```
  sudo firewall-cmd --permanent --add-port=80/tcp --zone=public
  sudo firewall-cmd --reload
```

## PHP-FPM

+ create nagios.conf for PHP-FPM
```
  //CONF file for nagios-php-fpm
  sudo vi /etc/php-fpm.d/nagios.conf
```
```
[nagios]
 
listen = /var/run/php-fpm/nagios.socket
listen.owner = nginx
listen.group = nginx
listen.mode=0660
listen.allowed_clients = 127.0.0.1
 
user = nagios
group = nagios
pm = dynamic
pm.max_children = 50
pm.start_servers = 5
pm.min_spare_servers = 5
pm.max_spare_servers = 35
 
slowlog = /var/log/php-fpm/nagios-slow.log
 
php_flag[display_errors] = on
php_admin_value[error_log] = /var/log/php-fpm/nagios-error.log
php_admin_flag[log_errors] = on
php_value[session.save_handler] = files
php_value[session.save_path] = /var/lib/php/session
```

+ Restarting PHP-FPM and Enabling at start-up
```
  sudo systemctl restart php-fpm
  sudo systemctl enable php-fpm
```

## fcgiwrap

+ Installing spawn-fcgi
```
  yum install fcgi-devel spawn-fcgi -y
```

+ Installing fcgiwrap and installing by compiling binaries
```
  cd /usr/local/src/ && git clone https://github.com/gnosek/fcgiwrap.git && cd fcgiwrap && autoreconf -i && ./configure && make && make install
```

+ Adding the spawn-fcgi configuration
```
  //Create Config file for SPAWN-FCGI
  vim /etc/sysconfig/spawn-fcgi
```
```
FCGI_SOCKET=/var/run/fcgiwrap.socket
FCGI_PROGRAM=/usr/local/sbin/fcgiwrap
FCGI_USER=nginx
FCGI_GROUP=nginx
FCGI_EXTRA_OPTIONS="-M 0700"
OPTIONS="-u $FCGI_USER -g $FCGI_GROUP -s $FCGI_SOCKET -S $FCGI_EXTRA_OPTIONS -F 1 -P /var/run/spawn-fcgi.pid -- $FCGI_PROGRAM"
```

+ Starting and Enabling Spawn-fcgi
```
  systemctl start spawn-fcgi
  systemctl enable spawn-fcgi
```
