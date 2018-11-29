# touch

> touch tgs.txt  //create an empty file
> touch -c a.txt  //if a file doesn't exists, touch will not create the file
> touch a b c d  //create 4 files names a, b, c, d
> touch -a tgs.txt  //change file's access time
> touch -m *.o  //change file's modification time

## Explicitly setting access and modification time (-t, -d)
> touch -a -m -t 203801181205.09 tgs.txt
> touch -d "2012-10-19 12:12:12.000000000 +0530" tgs.txt

## Copy the time-stamp from another file (-r)
> touch a.txt -r tgs.txt

