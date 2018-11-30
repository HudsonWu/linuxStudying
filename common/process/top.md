# system monitoring tools

## top

1. Overview:
The linux top command is used to show all the running processes within your linux environment

2. What information is shown
line 1: the time, how long the computer has been running, number of users, load average
line 2: total number of tasks, number of running tasks, number of sleeping tasks, number of stopped tasks, number of zombie tasks
line 3: cpu usage as a percentage by the 'user'/'system'/'low priority processes'/'idle processes'/'io wait'/'hardware interrupts'/'software interrupts'/'steal time'
line 4: total system memory, free memory, memory used, buffer cache
line 5: total swap available, total swap free, total swap used, available memory
Main Table:
process ID, user, priority, nice level, virtual memory used by process, resident memory used by a process, shareable memory, cpu used by process as a percentage, memory used by process as a percentage, time process has been running, command

3. Key switches for the top command
-h  show the current version
-c  this toggles the command column between showing command and program name(*)
-d  specify the delay time between refreshing the screen
-O  to get a list of the columns
-o  sorts by a column name(*)
-p  only show processes with specified process IDs
-u  show only processes by the specified user
-i  do not show idle tasks(*)

4. Adding extra columns to the top display
1) Whilst running top you can press the 'F' key which shows the list of fields that can be displayed in the table
2) Use the arrow keys to move up and down the list of fields
3) To set field so that it is displayed on the screen press the 'D' key, to remove the field press 'D' on it again
4) You can set the field to sort the table by simply by pressing the 'S' key on the field you wish to sort by
5) Press the enter key to commit your changes and press 'Q' to quit

5. Others
1) To toggle between the standard display and an alternate display by press the 'A' key
2) To change colors by press the 'Z' key

## Other relatively system monitoring tools

### htop
> htop -d 5

### glances
> glances
> glances -t 2
+ Use glances on remote systems
> glances -s
> glances -c 172.16.27.56