# awk

awk是一种处理文本文件的语言, 是一个强大的文本分析工具

## 用途
+ Define variables
+ Use string and arithmetric operators
+ Use control flow and loops
+ Generate formatted report


## 语法
<pre>
awk [options] [program] [file]

Awk can take the following options:
-F fs    //To specify a file separator
-f file    //To specify a file that contains awk script
-v var=value    //To declare a variable
</pre>

## 使用
<pre>
1. To define an awk script
> awk '{print "welcome to awk"}'
If you type anything, it returns the same welcome string we provide
To terminate the program, press the CTRL+D

2. Using variables
$0    the whole line
$1    the first field
$2    the second field
$n    the nth field
The whitespace character like space or tab is the default separator between fields in awk
> awk '{print $1}' myfile
You can specify the separator using -F option
> awk -F: '{print $1}' /etc/passwd

3. Using multiple commands
> echo "Hello, Awk" | awk '{$2="Adam"; print $0}'

4. Reading the script from a file
testfile: {print $1 " home at " $6}
> awk -F: -f testfile /etc/passwd

5. Awk preprocessing
If you need to create a title or a header for your result or so
> awk 'BEGIN {print "Report Title"}'
Let's apply it to something we can see the result:
> awk 'BEGIN {print "The File Contents:"}
> {print $0}' myfile

6. Awk postprocessing
To run a script after processing the data, use the END keywork
> awk 'BEGIN {print "The File Contents:"}
> {print $0}
> END {print "File footer"} myfile
Let's combine them together in a script file:
> BEGIN {
> print "User and thier corresponding home"
> print "UserName \t HomePath"
> print "-------- \t --------"
> FS=":"
> }
> {
> print $1 "  \t  " $6
> }
> END {
> print "The END"
> }

7. Built-in variables
FIELDWIDTHS    //specifies the field width
RS    //specifies the record separator
FS    //specifies the field separator
OFS    //specifies the output separator
ORS    //specifies the output separator
By default, the OFS variable is the space
> awk 'BEGIN{FS=":"; OFS="-"} {print $1,$6,$7}' /etc/passwd
Sometimes, the fields are distributed without a fixed separator. 
In these cases, FIELDWIDTHS variables solves the problem:
> awk 'BEGIN{FIELDWIDTHS="3 4 3"}{print $1,$2,$3}' testfile
Set the FS to the newline(\n) and the RS to a blank text
> awk 'BEGIN {FS="\n"; RS=""}{print $1,$3}' addresses

8. More variables
ARGC    //Retrieves the number of passed parameters
ARGV    //Retrieves the command line parameters
ENVIRON    //Array of the shell environment variables and corresponding values
FILENAME    //the file name that is processed by awk
NF    //Fields count of the line being processed
NR    //Retrieves total count of processed records
FNR    //the record which is processed
IGNORECASE    //to ignore the character case
> awk 'BEGIN{print ARGC,ARGV[1]}' myfile
> awk 'BEGIN{print ENVIRON["PATH"]}'
> echo | awk -v home=$HOME '{print "My Home is " home}'
> awk 'BEGIN{FS=":"; OFS=":"}{print $1,$NF}' /etc/passwd
> awk 'BEGIN{FS=","}{print $1,"FNR="FNR}' myfile myfile
> awk 'BEGIN{FS=","}{print $1,"FNR="FNR,"NR="NR}END{print "Total",NR,"processed lines"}' myfile myfile

9. User defined variables
variable names could be anything, but it can't begin with a number
> awk 'BEGIN{test="welcome to awk"; print test}'

10. Structured commands
> awk '{if ($1 > 30) print $1}' testfile
You should use braces if you want to run multiple statements
> awk '{
> if ($1 > 30)
> {
> x = $1 * 3
> print x
> } else
> {
> x = $1 / 2
> print x
> }
> }' testfile

11. Formatted printing
The printf command in awk allows you to print formatted output using format specifiers
%[modifier]control-letter
c    //prints numeric output as a string
d    //prints an integer value
e    //prints scientific numbers
f    //prints float values
o    //prints octal value
s    //prints a text string

> awk 'BEGIN{x=100*100; printf "The result is: %e\n", x}'
</pre>
