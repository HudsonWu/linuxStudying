1. 注释：
单行注释
-- select * from emp;
多行注释
/* select * from dept;
select * from salgrade; */

2. select语句
select 列1,列2,... --列与列之间使用逗号分隔，如果查询所有列可以使用*
from 表1,表2,... --表和表使用逗号分隔
[where 条件1 and/or 条件2...] --限定查询返回的结果，条件和条件之间使用逻辑运算符连接
[group by 列1,列2,...] --分组查询
[having 条件1 and/or 条件2...] --限定分组结果
[order by 列1,列2,...]; --对查询结果进行排序
 --查询指定列
【例】查询员工的姓名，职位，工资，部门号
select ename,job,sal,deptno from emp;
 --查询所有列
【例】查询员工的信息
select * from emp;
 --算术运算：对于数值型和日期型数据可以进行算术运算
【例】查询员工的姓名，工资，年薪（sal*12）
select ename,sal,sal*12 from emp;
【例】查询员工的姓名，入职日期，入职的周数
select ename,hiredate,(sysdate-hiredate)/7 from emp;
 --空值：没有意义的值
 --空值不是0，不是空格
 --包含空值的算术表达式结果为空
【例】查询员工的姓名，工资，奖金，总收入(工资+奖金)
select ename,sal,comm,sal+comm from emp;
 --列的别名
 --当别名中含有特殊符号，空格，区分大小写的时候需要加双引号
 --只有在给列起别名的时候会用到双引号，其余地方需要引号的时候都为单引号
【例】查询员工的姓名，工资，奖金，总收入(工资+奖金)
select ename as "姓名",sal "工资",comm "奖金",sal+comm "总收入" from emp;
 --连接操作符：双竖线||
【例】查询员工的姓名，职位，工资，按'xxx的职位是xxx,工资是xx'个返回查询结果
select ename||'的职位是:'||job||',工资是:'||sal "员工信息" from emp;
 --重记录：distinct,去重
【例】查询哪些部门有员工
select distinct deptno from emp;
 --限定和排序
1、where子句，限定查询返回的记录
1）普通比较运算符：>,>=,<,<=,=,<>
【例】查询工资大于2000的员工的姓名，职位， 工资，部门号
select ename,job,sal,deptno from emp
where sal>2000;
【例】查询职位不是'MANAGER'的员工的姓名，职位，工资
select ename,job,sal from emp
where job<>'MANAGER';
2）特殊比较运算符
 --between x and y，[x,y]
【例】查询工资在[1500,3000]范围的员工的姓名，工资
select ename,sal from emp
where sal between 1500 and 3000;
 --in(value1,value2,...)，匹配列表中的任意一个值则结果为真
【例】查询职位为'CLERK','SALESMAN'或者'MANAGER'的员工的姓名，职位，工资
select ename,job,sal from emp
where job in('CLERK','SALESMAN','MANAGER');
 --like,模糊匹配
 --%，表示若干任意字符；_，表示1个任意字符
【例】查询姓名的第三个字为'L'的员工的姓名，职位，部门号
select ename,job,deptno from emp
where ename like '__L%';
 --is null,匹配空值
【例】查询奖金为空的员工的姓名，工资，奖金，部门号
select ename,sal,comm,deptno from emp
where comm is null; --不能使用comm=null
 --逻辑运算符：and、or、not
【例】查询工资在[1500,3000]范围的员工的姓名，工资
select ename,sal from emp
where sal>=1500 and sal<=3000;
【例】查询职位为'CLERK'或者'MANAGER'的员工的姓名，职位，工资
select ename,job,sal from emp
where job='CLERK' or job='MANAGER';
【例】查询姓名的第三个字不是'L'的员工的姓名，职位，部门号
select ename,job,deptno from emp
where ename not like '__L%';
2、order by子句，对查询结果排序
1）升序：asc/缺省
2）降序：desc
3）可以使用列的别名排序，可以使用多个列排序
【例】查询员工的姓名，工资，年薪(工资*12)，部门号，查询结果按部门号升序，年薪降序排列
select ename,sal,sal*12 "年薪",deptno from emp
order by deptno,"年薪" desc;
【练习】
1)查询薪水大于2000，职位是MANAGER的员工姓名、职位、工资
select ename,job,sal from emp
where sal>2000 and job='MANAGER';
2)查询年薪大于30000，职位不是MANAGER的员工编号、姓名、职位、年薪、部门号
select empno,ename,job,sal*12,deptno from emp
where sal*12>30000 and job<>'MANAGER';
3)查询薪水在1500到3000之间，职位以“M”开头的员工编号、姓名、职位、工资
select empno,ename,job,sal from emp
where sal between 1500 and 3000 and job like 'M%';
4)查询佣金为空并且部门号为20或30的员工姓名、职位、工资、佣金(佣金=薪水SAL+奖金COMM)  
select ename,job,sal,sal+comm from emp
where sal+comm is null and deptno in(20,30); 
5)查询佣金不为空或者部门号为20的员工姓名、职位、工资、奖金、部门号，要求按照薪水降序排列 
  (佣金=薪水+津贴)
  select ename,job,sal,comm,sal+comm,deptno from emp
  where sal+comm is not null or deptno=20
  order by sal desc;
6)查询年薪大于30000工作类别不是MANAGER，且部门号不是10或40的员工编号、姓名、职位、工资、部门号，
  要求按照雇员姓名进行排列
select empno,ename,job,sal,deptno from emp
where sal*12>30000 and job<>'MANAGER' and deptno not in(10,40)
order by ename;
 --单行函数
1、字符函数
1）upper(x)，将字符串x转换为大写
【例】查询职位为'MANAGER'的员工的姓名
select ename from emp where job=upper('manager');
2）lower(x),将字符串x转换为小写
【例】查询职位为'MANAGER'的员工的姓名
select ename from emp where lower(job)='manager';
 --如果函数的参数为表中列，不能加单引号
3）initcap(x)，将字符串x中每个单词的首字母转换为大写，其余字母转为小写
【例】
select initcap('good,very good') from dual;
 --当查询的内容不在某张具体的表中的时候，使用虚表dual
4）length(x)，返回字符串x中的字符数
【例】
select ename,length(ename) from emp;
5）nvl(x,value)，如果x为空，返回value，否则返回x
【例】查询员工的姓名，工资，奖金，如果奖金为空则返回0
select ename,sal,nvl(comm,0) from emp;
6）nvl2(x,value1,value2)，如果x非空，返回value1，否则返回value2
【例】查询员工的姓名，工资，奖金，总收入(工资+奖金)，如果总收入为空返回工资
select ename,sal,comm,sal+nvl2(comm,comm,0) from emp;
select ename,sal,comm,nvl2(sal+comm,sal+comm,sal) from emp;
7）replace(x,char1,char2)，将字符串x中的char1，替换为char2
【例】将员工姓名中的'A'替换为'*'
select ename,replace(ename,'A','*') from emp;
8）substr(x,start,[length]),从字符串x的start位置开始返回长度为length的子字符串
 --start：如果为正数，表示从左向右计数；如果为负数，表示从右向左计数
 --length：如果省略表示返回从start开始的所有字符
【例】从'abcdefg'中返回'efg'
 --从'abcdefg'的第5个位置开始返回长度为3的子字符串
select substr('abcdefg',5,3) from dual;
 --从'abcdefg'的第5个位置开始返回所有字符
select substr('abcdefg',5) from dual;
 --从'abcdefg'的倒数第3个位置开始返回长度为3的子字符串
select substr('abcdefg',-3,3) from dual;
9）lpad(x,length,char)，使用char将字符串x从左边补齐到长度为length
 --length，表示补齐后的总长度
【例】使用'*'将员工的姓名从左边补齐到长度为10
select ename,lpad(ename,10,'*') from emp;
10）rpad(x,length,char)，使用char将字符串x从右边补齐到长度为length
【例】使用'*'将员工的姓名从右边补齐到长度为10
select ename,rpad(ename,10,'*') from emp;
11）ltrim(x,str)，返回从x的左边截去str后的子字符串
【例】从'abcdefg'中返回'efg'
select ltrim('abcdefg','abcd') from dual;
12）rtrim(x,str)，返回从x的右边截去str后的子字符串
【例】从'abcdefg'中返回'abcd'
select rtrim('abcdefg','efg') from dual;
 --函数嵌套:在一个函数中调用另一个函数
【例】从'abcdefg'中返回'bcd'
select rtrim(ltrim('abcdefg','a'),'efg') from dual;
13）concat(str1,str2)，返回将str1和str2连接在一起的新字符串
【例】查询员工的姓名，职位，按'xxx的职位是xxx'个返回查询结果
select concat(concat(ename,'的职位是'),job) from emp;
14）instr(x,char)，返回char在字符串x中第一次出现的位置
 --如果x中不包含char则返回0
【例】返回员工姓名中'A'第一次出现的位置
select ename,instr(ename,'A') from emp;
【练习】
1)在hello的左右两边各添加5个'*',返回‘*****hello*****’（三种方法实现）
 --双竖线||
select '*****'||'hello'||'*****' from dual;
 --concat
select concat('*****',concat('hello','*****')) from dual;
 --lpad+rpad
select lpad(rpad('hello',10,'*'),15,'*') from dual;
2)从字符串‘abcdefghijklmn’中返回后三位字符，并转换为大写
select upper(substr('abcdefghijklmn',-3)) from dual;
3)查询佣金为空并且部门号为20或30的员工姓名、职位、工资、
  佣金(佣金=薪水SAL+奖金COMM)，佣金为空则显示工资的值 （2种方法实现）
select ename,job,sal,nvl(sal+comm,sal) from emp
where sal+comm is null and deptno in(20,30);
select ename,job,sal,nvl2(sal+comm,sal+comm,sal) from emp
where sal+comm is null and deptno in(20,30);
4)查询名字包含5个字符的员工的姓名，工资，奖金(奖金为空则显示为0)、职位、部门号
select ename,sal,nvl(comm,0),job,deptno from emp
where length(ename)=5;
5)查询姓名中不含‘A’的员工的编号、姓名、职位、部门号(2种方法)
select empno,ename,job,deptno from emp
where ename not like '%A%';
select empno,ename,job,deptno from emp
where instr(ename,'A')=0;
6)显示将员工姓名的第一个字符去掉后的字符串，如‘ALLEN’显示为‘LLEN’（2种方法）
select ename,substr(ename,2) from emp;
select ename,ltrim(ename,substr(ename,1,1)) from emp;
7)使用员工姓名的第一个字符，从左边将员工姓名补齐到长度为10
select ename,lpad(ename,10,substr(ename,1,1)) from emp;

2、数字函数
 --floor(x)，返回小于等于x的最大整数
【例】
select floor(4.56),floor(-4.56) from dual;
 --mod(x,y)，返回x除以y的余数
【例】
select mod(8,3),mod(3,7) from dual;
 --round(x,s)，返回将x精确到s位的结果
 --s：正数，表示精确到小数点后第s位；负数，表示精确到个位前第s位
【例】
select round(46.778,2),round(46.778,-1) from dual;
 --trunc(x,s)，返回将x截取到s位的结果
 --s：正数，表示截取到小数点后第s位；负数，表示截取到个位前第s位
【例】
select trunc(46.778,2),trunc(46.778,-1) from dual;

3、日期函数
 --sysdate，返回系统当前的日期和时间
 --add_months(x,y)，返回日期x加上y个月后的日期
【例】select add_months(sysdate,120) from dual;
 --last_day(x)，返回日期x所在月份的最后一天的日期
【例】select ename,hiredate,last_day(hiredate) from emp;
 --next_day(x,day),返回从日期x开始下一个星期几的日期
【例】select next_day(sysdate,'星期五') from dual;

4、转换函数
 --to_number,将字符串转换为数字
【例】查询20号部门的员工姓名，职位，工资
select ename,job,sal from emp
where deptno=to_number('20');
 --to_char，可以操作数字，也可以操作日期
 --操作数字：to_char(number,'[fm]数字格式')
 --fm可以禁止数字前面的0或空格
 --数字格式：9，表示1个数字；0，表示1个数字；$，表示美元；L，表示本地货币；，用于分隔数字
【例】查询员工的姓名，工资，年薪，查询结果年薪按'xx,xxx.xx'格式显示
select ename,sal,to_char(sal*12,'$99,999.99') from emp;
select ename,sal,to_char(sal*12,'fmL00,000.00') from emp;
 --操作日期：to_char(date,'[fm]日期格式')
 --yyyy，4位数字表示的年
 --mm，2位数字表示的月；month，英文全月名
 --dd，2位数字表示的天
【例】查询员工的姓名，入职的年份
select ename,hiredate,to_char(hiredate,'yyyy') from emp;
select ename,hiredate,to_char(hiredate,'mm-dd-yyyy') from emp;
 --to_date，将字符串转换为日期
【例】查询1980年12月17号入职的员工的姓名，职位，部门号
select ename,job,deptno from emp
where hiredate=to_date('1980-12-17','yyyy-mm-dd');

习题
select * from emp;
select ename,sal,hiredate,deptno,deptno from emp
where to_char(hiredate,'mm')=6;

select ename,sal,hiredate,deptno,deptno from emp
where hiredate>=to_date('1981-6','yyyy-mm') and hiredate<=to_date('1981-12','yyyy-mm');

select ename,sal,hiredate,deptno,deptno from emp
where hiredate=last_day(hiredate)-2;

 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ---
2016.8.2    多表查询
 --多表查询时，如果有n张表联合查询，至少需要n-1个连接条件
 --在列名前添加表名作为前缀，提高查询效率
1、等值连接
【例】查询员工的姓名，部门号，部门名称
select emp.ename,emp.deptno,dept.dname from emp,dept
where emp.deptno=dept.deptno;
 --表的别名，可以简化sql语句
select e.ename,e.deptno,d.dname from emp e,dept d
where e.deptno=d.deptno;
2、不等连接
select * from salgrade;
select * from emp;
【例】查询员工的姓名，工资，工资等级
select e.ename,e.sal,s.* from emp e,salgrade s
where e.sal between s.losal and s.hisal;
3、自连接(同意实体内部的1:n联系)
【例】查询员工及其经理的姓名
select w.ename,m.ename from emp w,emp m
where w.mgr=m.empno;
4、外连接：左外连接、右外连接
 --左外连接：左条件=右条件(+)   left outer join on
 --右外连接：左条件(+)=右条件   right outer join on
【例】查询员工及其经理的姓名，没有经理的员工也显示在查询结果中
select w.ename "员工姓名",m.ename "经理姓名" from emp w,emp m
where w.mgr=m.empno(+);

习题
select e.ename,e.job,e.sal,e.empno,d.deptno,d.dname from emp e,dept d
where e.deptno=d.deptno and e.deptno=20;

select e.deptno,e.ename,e.job,nvl(e.comm,0),e.deptno,e.comm,d.deptno,d.dname from emp e,dept d
where e.deptno=d.deptno and e.comm is null;

select e.ename,e.deptno,d.dname from emp e,dept d
where e.deptno(+)=d.deptno;

 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
2.6 组函数
1、组函数
 --组函数在使用时会自动的忽略空值
 --count()，计数
【例】查询员工的人数
select count(empno) from emp;
select count(nvl(comm,0)) from emp;
 --sum()，求和
【例】查询20号部门的工资支出
select sum(sal) from emp
where deptno=20;
 --avg()，返回平均值
【例】查询员工的平均工资,结果保留2位小数
select round(avg(sal),2) from emp;
select to_char(avg(sal),'9999.99') from emp;
 --max(),min()，返回最大值，最小值
【例】查询员工的最高工资和最低工资
select max(sal),min(sal) from emp;
2、group by，分组查询
【例】查询每个部门的平均工资
select deptno,avg(sal) from emp
group by deptno;
 --如果在select后面有普通列和组函数，必须使用group by子句，而且所有的普通列都必须出现在group by子句中
【例】查询每个部门中每个职位的平均工资
select deptno,job,avg(sal) from emp
group by deptno,job;
 --出现在group by中的普通列可以不在select后面
【例】
select avg(sal) from emp
group by deptno,job;
3、having，限定分组查询结果
【例】查询每个部门中每个职位的平均工资，返回平均工资大于2000的记录
select deptno,job,avg(sal) from emp
 --不能使用where avg(sal)>2000
group by deptno,job
having avg(sal)>2000;
【练习】
1)查询每个职位的平均工资(保留2位小数)，查询结果按平均工资降序排列
select job,to_char(avg(sal),'9999.99') avgsal from emp
group by job
order by avgsal desc;
2)查询每个部门每个职位的平均工资(保留2位小数)，查询结果按部门号升序，平均工资降序排列
select deptno,job,to_char(avg(sal),'9999.99') avgsal from emp
group by deptno,job
order by deptno,avgsal desc;
3)查询每个部门的人数，查询结果按以下格式显示
  10号部门人数   20号部门认识        30号部门人数
  ——————    ——————       ——————
        3                5                     6
select sum(decode(deptno,10,1,0)) "10号部门人数",
       sum(decode(deptno,20,1,0)) "20号部门人数",
       sum(decode(deptno,30,1,0)) "30号部门人数" from emp;

2.7 子查询
 --使用规则
 --子查询要用括号括起来
 --将子查询放在比较运算符的右边
 --子查询中不要加ORDER BY子句
 --对单行子查询使用单行运算符
 --对多行子查询使用多行运算符
1、单行子查询
 --单行比较运算符：>,>=,<,<=,=,<>
【例】查询职位和'ALLEN'相同的员工的姓名，职位，部门号
select ename,job,deptno from emp
where job=(select job from emp where ename='ALLEN');
 --子查询在主查询前执行，将查询结果提供给主查询
2、多行子查询
 --多行比较运算符：in、any、all
 --in
【例】查询职位与'ALLEN'或'SMITH'相同的员工的姓名，职位，部门号
select ename,job,deptno from emp
where job in(select job from emp where ename='ALLEN' or ename='SMITH');
 --all，比较子查询返回的每一个值，要求每一个值都满足条件，则结果为真
【例】查询工资大于每个部门平均工资的员工的姓名，职位，工资
select ename,job,sal from emp
where sal>all(select avg(sal) from emp group by deptno);
 -->all，相当于大于最大值；<all，相当于小于最小值
 --any，比较子查询返回的每一个值，只要有一个值满足条件，则结果为真
【例】查询工资大于任意一个部门平均工资的员工的姓名，职位，工资
select ename,job,sal from emp
where sal>any(select avg(sal) from emp group by deptno);
 -->any，相当于大于最小值；<any，相当于小于最大值
3、多列子查询，in
【例】查询与'ALLEN'在同一个部门且职位相同的员工的姓名
select ename from emp
where (deptno,job) in(select deptno,job from emp where ename='ALLEN');
4、分页查询，rownum
【例】查询第二高的工资
 --1)查询工资，去重，降序排序
select distinct sal from emp order by sal desc;
 --2)在1)的结果中使用rownum插入一列标识
select rownum rn,sal from
(select distinct sal from emp order by sal desc);
 --3)在2)的结果中查询第二高的工资
select sal from 
(select rownum rn,sal from
(select distinct sal from emp order by sal desc))where rn=2;
练习题
【练习】
1)查询薪金(工资+奖金)比“ALLEN”多的所有员工
select ename,sal+nvl(comm,0) from emp
where sal+nvl(comm,0)>(select sal+nvl(comm,0) from emp where ename='ALLEN');
2)查询在部门销售部工作的员工姓名、工资、职位
select ename,sal,job from emp
where deptno=(select deptno from dept where dname='SALES');
3)使用子查询，找出哪个部门下没有员工
select deptno,dname from dept
where deptno not in(select distinct deptno from emp);
4)使用子查询，找出那些工资低于平均工资的员工姓名、工资、职位、部门号
select ename,job,sal from emp
where sal<(select avg(sal) from emp);
5)使用子查询，找出那些工资低于其中任意一个部门的平均工资的员工
select ename,job,sal from emp
where sal<any(select avg(sal) from emp group by deptno);
6)使用sql语句查出各个部门工资最高的员工的部门编号、员工姓名及其工资的信息
select empno,ename,sal,deptno from emp
where (sal,deptno) in(select max(sal),deptno from emp group by deptno);
7)查询每个部门的部门号、部门名称、部门人数(没有员工的部门人数显示为0)
select d.deptno,d.dname,nvl(r.rs,0) from dept d,
(select deptno,count(empno) rs from emp group by deptno) r
where d.deptno=r.deptno(+);
8)查询高于自己部门平均工资的员工名字,部门号,工资,平均工资
select e.ename,e.sal,e.deptno,to_char(avgsal,'9999.99') "平均工资" from emp e,
(select deptno,avg(sal) avgsal from emp group by deptno) a
where e.deptno=a.deptno and e.sal>a.avgsal;
9)查询工资排名前三的员工信息
select ename,sal,deptno from emp
where sal in
(select sal from 
(select rownum rn,sal from
(select distinct sal from emp order by sal desc))
where rn<=3);
 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
2.8 表的集合操作
 --提高查询效率
 --union和union all，返回两个集合的并集
【例】查询职位为'CLERK'或者'MANAGER'的员工的姓名，职位，工资
select ename,job,sal from emp
where job='CLERK' or job='MANAGER';
 --
select ename,job,sal from emp where job='CLERK'
union 
select ename,job,sal from emp where job='MANAGER';
 --intersect，返回两个集合的交集
【例】查询工资在[1500,3000]范围的员工的姓名，工资
select ename,sal from emp
where sal>=1500 and sal<=3000;
 --
select ename,sal from emp where sal>=1500
intersect
select ename,sal from emp where sal<=3000;
 --minus，返回两个集合的差集
【例】查询工资大于1500且职位不是'MANAGER'的员工的姓名，职位，工资
select ename,job,sal from emp where sal>1500 and job<>'MANAGER';
 --
select ename,job,sal from emp where sal>1500 
minus
select ename,job,sal from emp where job='MANAGER';
