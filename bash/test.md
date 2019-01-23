# Check File Exists or Not

```sh
test -e filename
[ -e filename ]

test -f filename
[ -f filename ]
```

## File test operators

The following operators return true is file exists:
+ -b FILE
    + FILE exists and is block special
+ -c FILE
    + FILE exists and is character special
+ -d FILE
    + FILE exists and is a directory
+ -e FILE
    + FILE exists
+ -f FILE
    + FILE exists and is a regular file
+ -g FILE
    + FILE exists and is set-group-ID
+ -G FILE
    + FILE exists and is owned by the effective group ID
+ -h FILE
    + FILE exists and is a symbolic link (same as -L)
+ -k FILE
    + FILE exists and has its sticky bit set
+ -O FILE
    + FILE exists and is owned by the effective user ID
+ -p FILE
    + FILE exists and is a named pipe
+ -r FILE
    + FILE exists and read permission is granted
+ -w FILE
    + FILE exists and write permission is granted
+ -x FILE
    + FILE exists and execute (or search) permission is granted
+ -s FILE
    + FILE exists and has a size greater than zero
+ -S FILE
    + FILE exists and is a socket
+ -t FD
    + file descriptor FD is opened on a terminal
+ -u FILE
    + FILE exists and its set-user-ID bit is set

Syntax:
```sh
if [ operator FileName ]
then
    echo "FileName - Found, take some action here"
else
    echo "FileName - Not Found, take some action here"
fi
```

## References

+ <https://bash.cyberciti.biz/guide/File_attributes_comparisons>
