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


