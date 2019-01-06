# sql语句的一些语法和示例

## 注释

单行注释
```sql
-- select * from emp;
```
多行注释
```sql
/* select * from dept;
select * from salgrade; */
```

## select语句

```sql
select 列1, 列2, ... // 列与列之间使用逗号分隔, 如果查询所有列可以使用*
from 表1, 表2, ... // 表和表使用逗号分隔
[where 条件1 and/or 条件2...] // 限定查询返回的结果, 条件和条件之间使用逻辑运算符连接
[group by 列1, 列2, ...] // 分组查询
[having 条件1 and/or 条件2...] // 限定分组结果
[order by 列1, 列2, ...]; // 对查询结果进行排序
```

```sql
// 查询指定列
select ename, job, sal, deptno from emp;
// 查询所有列
select * from emp;

// 算术运算: 对于数值型和日期型数据可以进行算术运算
select ename, sal, sal*12 from emp;
select ename, hiredate, (sysdate-hiredate)/7 from emp;

// 空值: 没有意义的值, 空值不是0, 不是空格
// 包含空值的算术表达式结果为空

// 列的别名
// 当别名中含有特殊符号, 空格, 区分大小写的时候需要加双引号
// 只有在给列起别名的时候会用到双引号, 其余地方需要引号的时候都为单引号
select ename as "姓名", sal "工资", comm "奖金", sal+comm "总收入" from emp;

// 连接操作符: 双竖线||
select ename||'的职位是:'||job||', 工资是:'||sal "员工信息" from emp;

// 重记录: distinct, 去重
select distinct deptno from emp;
```

### 限定和排序

### where子句, 限定查询返回的记录

1. 普通比较运算符: >, >=, <, <=, =, <>
```sql
select ename, job, sal, deptno from emp where sal>2000;
select ename, job, sal from emp where job<>'MANAGER';
```
2. 特殊比较运算符
```sql
// between x and y, [x, y]
select ename, sal from emp where sal between 1500 and 3000;

// in(value1, value2, ...), 匹配列表中的任意一个值
select ename, job, sal from emp where job in('CLERK', 'SALESMAN', 'MANAGER');

// like, 模糊匹配
// %, 表示若干任意字符; _, 表示1个任意字符
select ename, job, deptno from emp where ename like '__L%';

// is null, 匹配空值
select ename, sal, comm, deptno from emp where comm is null; -- 不能使用comm=null

// 逻辑运算符: and、or、not
select ename, sal from emp where sal>=1500 and sal<=3000;
select ename, job, sal from emp where job='CLERK' or job='MANAGER';
select ename, job, deptno from emp where ename not like '__L%';
```

### order by子句, 对查询结果排序

+ 升序: asc/缺省
+ 降序: desc
+ 可以使用列的别名排序, 可以使用多个列排序

```sql
select ename, sal, sal*12 "年薪", deptno from emp order by deptno, "年薪" desc;
```

```sql
// 查询佣金不为空或者部门号为20的员工姓名、职位、工资、奖金、部门号, 要求按照薪水降序排列 
// 佣金=薪水+津贴
select ename, job, sal, comm, sal+comm, deptno from emp
where sal+comm is not null or deptno=20
order by sal desc;

// 查询年薪大于30000工作类别不是MANAGER, 且部门号不是10或40的员工编号、姓名、职位、工资、部门号, 
// 要求按照雇员姓名进行排列
select empno, ename, job, sal, deptno from emp
where sal*12>30000 and job<>'MANAGER' and deptno not in(10, 40)
order by ename;
```

## 单行函数

### 字符函数

```sql
// upper(x), 将字符串x转换为大写
select ename from emp where job=upper('manager');

// lower(x), 将字符串x转换为小写
select floor(4.56), floor(-4.56) from dual;

// mod(x, y), 返回x除以y的余数
select mod(8, 3), mod(3, 7) from dual;

// round(x, s), 返回将x精确到s位的结果
// last_day(x), 返回日期x所在月份的最后一天的日期
// next_day(x, day), 返回从日期x开始下一个星期几的日期
```

### 转换函数

```sql
// to_number, 将字符串转换为数字
select ename, job, sal from emp where deptno=to_number('20');

// to_char, 可以操作数字, 也可以操作日期

// 操作数字: to_char(number, '[fm]数字格式')
// fm可以禁止数字前面的0或空格
// 数字格式: 9, 表示1个数字; 0, 表示1个数字; $, 表示美元; L, 表示本地货币; , 用于分隔数字
select ename, sal, to_char(sal*12, '$99, 999.99') from emp;
select ename, sal, to_char(sal*12, 'fmL00, 000.00') from emp;

// 操作日期: to_char(date, '[fm]日期格式')
// yyyy, 4位数字表示的年
// mm, 2位数字表示的月; month, 英文全月名
// dd, 2位数字表示的天
select ename, hiredate, to_char(hiredate, 'yyyy') from emp;
select ename, hiredate, to_char(hiredate, 'mm-dd-yyyy') from emp;

// to_date, 将字符串转换为日期
select ename, job, deptno from emp
where hiredate=to_date('1980-12-17', 'yyyy-mm-dd');
```

```sql
select ename, sal, hiredate, deptno, deptno from emp
where to_char(hiredate, 'mm')=6;

select ename, sal, hiredate, deptno, deptno from emp
where hiredate>=to_date('1981-6', 'yyyy-mm') and hiredate<=to_date('1981-12', 'yyyy-mm');

select ename, sal, hiredate, deptno, deptno from emp
where hiredate=last_day(hiredate)-2;
```

## 多表查询

+ 多表查询时, 如果有n张表联合查询, 至少需要n-1个连接条件
+ 在列名前添加表名作为前缀, 提高查询效率

1、等值连接
```sql
select emp.ename, emp.deptno, dept.dname from emp, dept
where emp.deptno=dept.deptno;

// 使用别名, 可以简化sql语句
select e.ename, e.deptno, d.dname from emp e, dept d
where e.deptno=d.deptno;
```

2、不等连接
```sql
select e.ename, e.sal, s.* from emp e, salgrade s
where e.sal between s.losal and s.hisal;
```

3、自连接(同一实体内部的1:n联系)
```sql
select w.ename, m.ename from emp w, emp m
where w.mgr=m.empno;
```

4、外连接: 左外连接、右外连接

+ 左外连接: 左条件=右条件(+)   left outer join on
+ 右外连接: 左条件(+)=右条件   right outer join on

```sql
select w.ename "员工姓名", m.ename "经理姓名" from emp w, emp m
where w.mgr=m.empno(+);
```

```sql
select e.ename, e.job, e.sal, e.empno, d.deptno, d.dname from emp e, dept d
where e.deptno=d.deptno and e.deptno=20;

select e.deptno, e.ename, e.job, nvl(e.comm, 0), e.deptno, e.comm, d.deptno, d.dname from emp e, dept d
where e.deptno=d.deptno and e.comm is null;

select e.ename, e.deptno, d.dname from emp e, dept d
where e.deptno(+)=d.deptno;
```

## 组函数

组函数在使用时会自动的忽略空值

```sql
// count(), 计数
select count(empno) from emp;
select count(nvl(comm, 0)) from emp;

// sum(), 求和
select sum(sal) from emp where deptno=20;

// avg(), 返回平均值
select round(avg(sal), 2) from emp;
select to_char(avg(sal), '9999.99') from emp;

// max(), min(), 返回最大值, 最小值
select max(sal), min(sal) from emp;
```

## group by, 分组查询

```sql
//如果在select后面有普通列和组函数, 必须使用group by子句
select deptno, avg(sal) from emp group by deptno;

//所有的普通列都必须出现在group by子句中
select deptno, job, avg(sal) from emp group by deptno, job;

// 出现在group by中的普通列可以不在select后面
select avg(sal) from emp group by deptno, job;
```

### having, 限定分组查询结果

```sql
// 不能使用where avg(sal)>2000
select deptno, job, avg(sal) from emp group by deptno, job having avg(sal)>2000;
```

```sql
// 查询每个职位的平均工资(保留2位小数), 查询结果按平均工资降序排列
select job, to_char(avg(sal), '9999.99') avgsal from emp
group by job
order by avgsal desc;

// 查询每个部门每个职位的平均工资(保留2位小数), 查询结果按部门号升序, 平均工资降序排列
select deptno, job, to_char(avg(sal), '9999.99') avgsal from emp
group by deptno, job
order by deptno, avgsal desc;

// 查询每个部门的人数
select sum(decode(deptno, 10, 1, 0)) "10号部门人数",
       sum(decode(deptno, 20, 1, 0)) "20号部门人数",
       sum(decode(deptno, 30, 1, 0)) "30号部门人数" from emp;
```

## 子查询

使用规则:
+ 子查询要用括号括起来
+ 将子查询放在比较运算符的右边
+ 子查询中不要加ORDER BY子句
+ 对单行子查询使用单行运算符
+ 对多行子查询使用多行运算符

1、单行子查询
单行比较运算符: >, >=, <, <=, =, <>
```sql
select ename, job, deptno from emp
where job=(select job from emp where ename='ALLEN');
```
子查询在主查询前执行, 将查询结果提供给主查询

2、多行子查询
多行比较运算符: in、any、all
```sql
// in
select ename, job, deptno from emp
where job in(select job from emp where ename='ALLEN' or ename='SMITH');

// all, 比较子查询返回的每一个值, 要求每一个值都满足条件, 则结果为真
// >all, 相当于大于最大值; <all, 相当于小于最小值
select ename, job, sal from emp
where sal>all(select avg(sal) from emp group by deptno);

// any, 比较子查询返回的每一个值, 只要有一个值满足条件, 则结果为真
// >any, 相当于大于最小值; <any, 相当于小于最大值
select ename, job, sal from emp
where sal>any(select avg(sal) from emp group by deptno);
```

3、多列子查询, in
```sql
select ename from emp
where (deptno, job) in(select deptno, job from emp where ename='ALLEN');
```

4、分页查询, rownum
```sql
// 查询工资, 去重, 降序排序
select distinct sal from emp order by sal desc;

// 使用rownum插入一列标识
select rownum rn, sal from
(select distinct sal from emp order by sal desc);

// 查询第二高的工资
select sal from 
(select rownum rn, sal from
(select distinct sal from emp order by sal desc))where rn=2;
```

```sql
// 查询薪金(工资+奖金)比“ALLEN”多的所有员工
select ename, sal+nvl(comm, 0) from emp
where sal+nvl(comm, 0)>(select sal+nvl(comm, 0) from emp where ename='ALLEN');

// 使用子查询, 找出哪个部门下没有员工
select deptno, dname from dept
where deptno not in(select distinct deptno from emp);

// 使用子查询, 找出那些工资低于平均工资的员工姓名、工资、职位、部门号
select ename, job, sal from emp
where sal<(select avg(sal) from emp);

// 使用sql语句查出各个部门工资最高的员工的部门编号、员工姓名及其工资的信息
select empno, ename, sal, deptno from emp
where (sal, deptno) in(select max(sal), deptno from emp group by deptno);

// 查询每个部门的部门号、部门名称、部门人数(没有员工的部门人数显示为0)
select d.deptno, d.dname, nvl(r.rs, 0) from dept d,
(select deptno, count(empno) rs from emp group by deptno) r
where d.deptno=r.deptno(+);

// 查询高于自己部门平均工资的员工名字, 部门号, 工资, 平均工资
select e.ename, e.sal, e.deptno, to_char(avgsal, '9999.99') "平均工资" from emp e,
(select deptno, avg(sal) avgsal from emp group by deptno) a
where e.deptno=a.deptno and e.sal>a.avgsal;

// 查询工资排名前三的员工信息
select ename, sal, deptno from emp
where sal in
(select sal from 
(select rownum rn, sal from
(select distinct sal from emp order by sal desc))
where rn<=3);
```

## 表的集合操作

提高查询效率

1. union和union all, 返回两个集合的并集
```sql
select ename, job, sal from emp
where job='CLERK' or job='MANAGER';

select ename, job, sal from emp where job='CLERK'
union 
select ename, job, sal from emp where job='MANAGER';
```

2. intersect, 返回两个集合的交集
```sql
select ename, sal from emp
where sal>=1500 and sal<=3000;

select ename, sal from emp where sal>=1500
intersect
select ename, sal from emp where sal<=3000;
```

3. minus, 返回两个集合的差集
```sql
select ename, job, sal from emp where sal>1500 and job<>'MANAGER';

select ename, job, sal from emp where sal>1500 
minus
select ename, job, sal from emp where job='MANAGER';
```
