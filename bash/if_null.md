# 判断一个变量是否为空

1. -n string, True if the length of string is non-zero

```sh
#!/bin/bash
para1=

if [ ! -n "$para1" ]; then
    echo "is null"
else
    echo "not null"
fi
```

2. -z string, True if the length of string is zero

```sh
#!/bin/bash
dmin=

if [ -z "$dmin" ]; then
    echo "is not set"
else
    echo "is set"
fi
```

3. 直接通过变量判断

```sh
#!/bin/bash
para1=

if [ ! $para1 ]; then
    echo "is null"
else
    echo "not null"
fi
```


4. 使用""判断

```sh
#!/bin/bash
dmin=

if [ "$dmin" = "" ]; then
    echo "is not set"
else
    echo "is set"
fi
```

