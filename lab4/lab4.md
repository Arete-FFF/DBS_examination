# 第四章 事务及并发控制实验

## 单事务与串行事务

### 违反check 约束的update 操作

#### 实验内容
在TD-LTE 网络数据库中，小区/基站工参表tbCell 中的小区天线高度不能小于0。  
在关系表tbCell（注意：实验前备份该表，以防实验造成数据丢失）上，用Alter table add check 添加约束，并在该备份表上完成以下实验内容：  
Step1. 查询小区/基站工参表的小区天线高度（HEIGHT）小于20 的SECTOR_ID、SECTOR_NAME和HEIGHT；  
Step2. 更新小区/基站工参表将step1 中的HEIGHT 设置为当前值减去15（注意此时有可能违反check 约束）  
Step3. 查询小区/基站工参表的小区天线高度（HEIGHT）小于20 的SECTOR_ID、SECTOR_NAME和HEIGHT；  
针对以上操作分别进行如下的操作：  
(1) 将以上操作组织成普通的SQL 语句，顺序执行。  
(2) 将以上操作组织成事务执行（以start transaction; 开始，以commit;结束）。  
查看数据库，观察两次的执行结果有何异同。

#### 实验步骤
```sql
alter table tbcell add check ( "HEIGHT">=0 );
select * from tbcell where "HEIGHT"<10;
start transaction;
    select * from tbcell where "HEIGHT"<10;
    update tbcell set "HEIGHT"="HEIGHT"-8 where "HEIGHT"<10;
    select *from tbcell where "HEIGHT"<10;
commit;
select * from tbcell where "HEIGHT"<10;
```

实验截图:  
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_01_01.png)

实验分析:  
第一次查询到603条数据  
然后在事务内执行update 语句之后发现报错，check 约束不合法，会导致语句回滚。  
结合下条查询语句可以看到，结果集仍是602 条，再观察两次查询数据对比后发现未发生变化。  
说明当有check 约束时，某行更新失败会使得整条语句全部回滚，并非是只跳过check 不通过的那些行。

### 事务commit/rollback 操作

#### 实验内容
分别以显示提交和隐式提交两种事务执行模式，在关系表tbCell 上执行以下操作，并观察、分析、解释执行结果。注意：实验前备份该表，以防实验造成数据丢失。  
Step1. 查看小区ID 在'122880-0'和'122882-2'之间的小区配置的频点编号；  
Step2. 将小区ID 在'122880-0'和'122882-2''的小区配置的频点编号更新为37900;  
Step3. 再次查看小区ID 在'122880-0'和'122882-2'之间的小区配置的频点编号。  
将step1、step2 和step3的数据库访问组织成1个单一事务T1，再将step3作为一个独立事务提交DBMS，串行执行这2个事务，观察T1中的rollback、commit 对事务执行结果的影响。  
由step1、step2 和step3 组成的事务T1 采用以下2 种结束方式：  
（1）以commit 结束。  
（2）以rollback 结束。  
#### 实验步骤

commit操作:

```sql
start transaction;
    select "SECTOR_ID","EARFCN" from tbcell where "SECTOR_ID" between '124672-0' and '124675-2';
    update tbcell set "EARFCN"=38950 where "SECTOR_ID" between '124672-0' and '124675-2';
    select "SECTOR_ID","EARFCN" from tbcell where "SECTOR_ID" between '124672-0' and '124675-2';
commit;
select "SECTOR_ID" ,"EARFCN" from tbcell where "SECTOR_ID" between '124672-0' and '124675-2';
```

实验结果：
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_02_01.png)
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_02_02.png)
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_02_03.png)

从上到下依次为三次查询的输出，可见在事务中，更改前的查询前后进行了更改。  
在第三张图片中，commit之后的查询中依旧为已经更改的数据。可以看出事务中的更新操作成功更改了表中的数据。

rollback操作:
```sql
start transaction;
    select "SECTOR_ID","EARFCN" from tbcell where "SECTOR_ID" between '124672-0' and '124675-2';
    update tbcell set "EARFCN"=38950 where "SECTOR_ID" between '124672-0' and '124675-2';
    select "SECTOR_ID","EARFCN" from tbcell where "SECTOR_ID" between '124672-0' and '124675-2';
rollback;
select "SECTOR_ID" ,"EARFCN" from tbcell where "SECTOR_ID" between '124672-0' and '124675-2';
```

实验结果：
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_02_04.png)
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_02_05.png)
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_02_06.png)
从上到下依次为三次查询的输出，可见在事务中，更改前的查询前后进行了更改。  
在第三张图片中，rollback之后的查询中为更改之前的数据。可以看出事务中的更新操作未能更改表中的数据。

### 修改数据库模式

#### 实验内容
针对小区/基站信息表tbCell（注意备份原表）  
Step1. 修改TD-LTE 数据库中的tbCell 表，删除列pss（使用alter table drop）；  
Step2. 修改tbCell 表，增加列pss（使用alter table add）。  
将step1、step2 的数据库访问组织成1 个单一事务（以显式事务的方式），采用以下2 种结束方式：  
（1）以commit 结束；  
（2）以rollback 结束。  
查看数据库（用select 语句查看被删除/增加的列），观察数据库模式修改语句（alter table），是否会受到rollback，commit 语句的影响。  
也可以自行选择或创建表、删除其它关系表，重复以上两步，查看数据库，观察数据库模式定义语句
（create table）模式修改语句（drop table）是否会受到rollback，commit 语句的影响。

#### 实验步骤

rollback操作:
```sql
start transaction;
    select "PSS" from tbcell limit 5;
    alter table tbcell drop column "PSS";
    alter table tbcell add column "PSS" int8;
rollback;
select "PSS" from tbcell limit 5;
```

实验结果:
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_03_01.png)

第二次select查询结果非空，说明rollback取消了对PSS列的删除。

### 保存点Savepoint 设置与回滚实验

#### 实验内容
本实验要求在事务内部不同执行位置设置，例如添加之后、添加之前、删除之后等，使用SAVETRANSACTION savepoint_name 语句创建保存点,使用ROLLBACK savepoint_name 语句将事务回滚，观察每次操作的结果。  
保存点提供了回滚部分事务的机制，而不是回滚到事务的开始。  
以小区PCI 优化调整结果表tbPCIAssignment 为访问对象，在创建的事务中insert 插入语句后设置保存点，然后删除添加的信息，并回滚至保存点并提交事务；事务完成后再查询相应的行，观察执行结果是否插入成功，具体如下：  

Step1. 查询小区PCI 优化调整结果表的小区PCI 为106 的小区的SECTOR_ID；  
Step2. 在小区PCI 优化调整结果表中，添加一条SECTOR_ID 为“220102-5”、PCI 为106 的信息；  
Step3. 设置保存点；  
Step4. 删除step2 所添加的信息；  
Step5. 回滚至保存点；  
Step6. 事务提交结束；  
Step7. 查询小区PCI 优化调整结果表的小区PCI 为106 的小区的SECTOR_ID；  

#### 实验步骤

```sql
start transaction;
    select "SECTOR_ID" from tbcell where "SECTOR_ID" ='111100-1';
    insert into tbcell("SECTOR_ID","PCI") values('111100-1',106);
    savepoint sp;
    delete from tbcell where "SECTOR_ID"='111100-1';
    rollback to sp;
commit;
select "SECTOR_ID" from tbcell where "SECTOR_ID" ='111100-1';
```

实验结果:
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_04_01.png)

由上图右边两次查询，发现插入成功，所以可以利用savepoint 来达到局部回滚的目的。

## 并发事务控制

### Read committed 隔离级别下的幻读
将数据库系统隔离级别修改为read committed，开启一个事务，并执行查询语句：
```sql
start transaction;
select "EARFCN" from tboptcell where "SECTOR_ID" = '15113-3';
```
结果如下:
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_05_01.png)
在另一个窗口执行隐式事务，执行下面这条插入语句：
```sql
insert into  tboptcell ("SECTOR_ID", "EARFCN")values ('15113-3', '99998')
```
结果如下:
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_05_02.png)
返回事务窗口中再次执行查询，发现返回集中多了一条数据，出现幻读：
```sql
select "EARFCN" from tboptcell where "SECTOR_ID" = '15113-3';
```
结果如下:
![](https://github.com/Arete-FFF/DBS_examination/blob/main/lab4/img/GaussDB4_05_03.png)
假设事务A 对某些行的内容作了更改，但是还未提交，此时事务B 插入了与事务A 更改前的记录相同的记录行，并且在事务A 提交之前先提交了。而这时，在事务A 中查询，会发现好像刚刚的更改对于某些数据未起作用，但其实是事务B刚插入进来的，让用户感觉出现了幻觉，称为幻读。   

幻读关注点是insert操作。简单来说，幻读前后数据量不同，前后读取到的内容不同。

### Repeatable read 隔离级别下多事务访问

将数据库系统隔离级别修改为Repeatable read，开启一个事务，并执行查询语句：
```sql
start transaction;
select "EARFCN" from tboptcell where "SECTOR_ID" = '15113-3';
```
结果如下:




