# 理解Nginx配置文件里指令的继承关系(The Nginx Configuration Inheritance Model)

Nginx配置文件分为很多块 :
```
Global
Http
Server
If
Location
  Nested Location
  If in location
  limit_except
```

The default inheritance model is that directives inherit downwards only. Never sideways and definitely never up. And replacing any directives specified in a higher context.

There are four types of configuration directives in nginx:
```
Normal directive, One value per context, for example: "root" or "index"
Array directive, Multiple values per context, for example: "access_log" or "fastcgi_param"
Action directive, Something which does not just configure, for example: "rewrite" or "fastcgi_pass"
try_files directive
```

## `Normal directives`

```
server {
  root /home/user/public_html;

  location /app {
    root /usr/share;  # This results in /usr/share/app
  }

  location /app2 {
    # Server context root applies here
  }
}
```

## `Array directives`

```
server {
  access_log /var/log/nginx/access.log;
  include fastcgi.conf;

  location ~ ^/calendar/.+\.php$ {
    access_log /var/log/nginx/php-requests.log;

    fastcgi_param ENV debug;  # This overwrites the higher context array
    include fastcgi.conf;  # Therefore we include it in this context again
  }
}
```

## `Action directives`

`Action directives` are confined to one context and will never inherit downwards, they can however be specified in multiple contexts and in some cases will be executed for each context.
```
server {
  rewrite ^/booking(.*) /calendar$1 permanent;  # Always executes

  location /calendar {
    rewrite ^ /index.php;  # Can execute in addition to and does not replace server context rewrites
  }
}
```

Within locations there are three possible contexts, `a nested location`, `an if` and `limit_except`. Generally they will not inherit into a nested location but it ultimately depends on how the module wants it to be and it can differ on a directive by directive basis, For action directives.
```
server {
  location /calendar {
    rewrite ^ /static.php;  # Executes unless inner location matches

    location ~ \.php$ {
      fastcgi_pass backend;  # Outer location context rewrite is not executed
    }
  }
}
```

## `try_files directives`

The `try_files directives` is mostly like every other `action directives` mentioned above, the difference is that if placed in server context nginx actually creates a pseudo-location that is the least specific location possible. That means if a request matches a defined location the `try_files directives` will not be executed. This means that if you have location / defined then you have a location that matches every possible request and as such `try_files` will never actually execution. Therefore always place `try_files` in location context instead of server context if at all possible.
```
server {
  try_files $uri /index.php;  # This never executes

  location / {
    # Whatever here, or empty
  }
   location ~ \.php$ {
     # If this location executes then try_files still does not execute
     # Even if location / did not exist
   }
}
```
