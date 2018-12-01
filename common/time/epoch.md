## epoch

> <https://www.epochconverter.com> <br/>

The Unix epoch (or Unix time or POSIX time or Unix timestamp) is the number of seconds that have elapsed <br/>
since January 1,1970(midnight UTC/GMT),not counting leap seconds <br/>

### How to get the current epoch time in ...
```
Ruby	Time.now(or Time.new)
MySQL	SELECT unix_timestamp(now())
PostgreSQL	SELECT extract(epoch FROM now());
Unix/Linux Shell	date +%s
```

### Convert from human readable date to epoch
```
Ruby	Time.local(year,month,day,hour,minute,second,usec)
MySQL	SELECT unix_timestamp(time) Time format: YYYY-MM-DD HH:MM:SS or YYMMDD or YYYYMMDD
PostgreSQL	SELECT extract(EPOCH FROM TIMESTAMP WITH TIME ZONE '2018-02-16 20:38:40-08');
Unix/Linux Shell	date +%s -d "Jan 1, 1980 00:00:01"
(Replace '-d' with '-ud' to input in GMT/UTC time)
```

### Convert from epoch to human readable date
```
Ruby	Time.at(epoch)
MySQL	FROM_UNIXTIME(epoch,optional output format) Default output format is YYY-MM-DD HH:MM:SS
PostgreSQL	SELECT to_timestamp(epoch);
Unix/Linux Shell	date -d @1520000000
                    date -ud @1520000000
```
