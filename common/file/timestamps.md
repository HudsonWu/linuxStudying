## Fake file access, modify and change timestamps

### Difference Between "atime", "mtime" and "ctime"
<pre>
atime    when you open a file or when a file is used for other
         operations like grep, cat, head and so on
mtime    when you whenever update content of a file or save a file
ctime    when the file attributes are changed, like changing the owner,
         changing the permission or moving it to another filesystem, but
         will also be updated when you modify a file
</pre>

### Change file "Access" & "Modification" time
```sh
touch -a --date="2005-03-15 12:11:12.547775198 +0800" file.txt
touch -m --date="2011-04-05 11:22:11.443117094 +0800" file.txt
```

### Change file "Change" time
There is no a standard way to set a different ctime timestamp<br/>
As a possible workaround you can set the system time to the ctime you want to impose, then touch the file and then restore the system time<br/>
<pre>
1. Save the current system's date and time in the variable NOW
export NOW=$(date)
2. Set the fake date and time
date --set "2017-09-22 15:33:11"
3. Touch the file to fake the all timestamps
touch file.txt
4. Rollback the date and time
date --set "$NOW"
5. Stay stealthy
To stay stealthy, unset the variable, clear the logs(/var/log/messages and so on) and history
unset NOW

//To speedup modification and reduce the possible impact, execute the above command as follows:
export NOW=$(date) && date -s "2017-09-22 15:33:11" && touch file.txt && date -s "$NOW" && unset NOW
</pre>
