# 第三章 完整性约束实验

## 利用Create table/Alter table 语句建立完整性约束

### 利用creat table 创建相关约束

创建tbCellcopy表代码如下：

```sql
CREATE TABLE tbCellcopy (
"CITY" nvarchar2(255),
"SECTOR_ID" nvarchar2(255),
"SECTOR_NAME" nvarchar2(255),
"ENODEBID" int,
"ENODEB_NAME" nvarchar2(255),
"EARFCN" int,
"PCI" int,
"PSS" int,
"SSS" int,
"TAC" nvarchar2(255),
"VENDOR" nvarchar2(255),
"LONGITUDE" float,
"LATITUDE" float,
"STYLE" nvarchar2(255),
"AZIMUTH" float,
"HEIGHT" float,
"ELECTTILT" nvarchar2(255),
"MECHTILT" nvarchar2(255),
"TOTLETILT" nvarchar2(255),
primary key ("SECTOR_ID");
```

建表过程中创建了"主键"
创建结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_01_01.png)

### 使用alter table 语句，在该表上添加约束。

添加候选键：

```sql
ALTER TABLE tbcellcopy
ADD CONSTRAINT UQ_SECTOR_NAME
UNIQUE ("SECTOR_NAME");
```

结果如下:
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_01_02_01.png)

添加非空属性:

```sql
ALTER TABLE "tbcellcopy"
ALTER COLUMN "ENODEBID" SET NOT NULL;
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_01_02_02.png)

添加check约束：

```sql
ALTER TABLE tbcellcopy
ADD CONSTRAINT CK_PCI CHECK(("PCI"=3*"SSS") + "PSS" AND "PCI" >=0  AND "PCI" <= 503);

ALTER TABLE tbcellcopy
ADD CONSTRAINT CK_EARFCN CHECK("EARFCN" = 37900 OR "EARFCN" = 38098 OR "EARFCN" = 38400 OR "EARFCN" = 38950 OR "EARFCN" = 39148);

ALTER TABLE tbcellcopy
ADD CONSTRAINT CK_PSS CHECK ( "PSS" >= 0 AND "PSS" <= 2);

ALTER TABLE tbcellcopy
ADD CONSTRAINT CK_SSS CHECK ( "SSS" >= 0 AND "PSS" <= 167);
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_01_02_03.png)

添加默认\缺省值约束:

```sql
ALTER TABLE tbcellcopy
ALTER  "LATITUDE" SET DEFAULT 112.77068;

ALTER TABLE tbcellcopy
ALTER  "LONGITUDE" SET DEFAULT 33.810396;

ALTER TABLE tbcellcopy
ALTER  "AZIMUTH" SET DEFAULT 0;

ALTER TABLE tbcellcopy
ALTER  "HEIGHT" SET DEFAULT 20;
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_01_02_04.png)

添加完成所有约束后表的结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_01_02_05.png)

## 主键/候选键/空值/check/默认值约束验证

### 主键约束

#### 使用分组聚集运算语句，判断是否满足主键约束

查询语言如下:

```sql
SELECT "SECTOR_ID", count(*)
FROM tbcellcopy
GROUP BY "SECTOR_ID"
HAVING count(*)>1;
SELECT * FROM tbCellcopy WHERE "SECTOR_ID" IS NULL
```

查询结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_01_01.png)
均未能查到任何结果，满足主键约束。

#### 向该表插入在主属性上取值为空的元组，观察DBMS反应

插入代码如下：

```sql
INSERT INTO tbCellcopy VALUES ("SECTOR_ID" = NULL, "CITY" = 'beijing');
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_01_02.png)
DBMS报错，不能插入主键为空的元组。

#### 选取表中某个元组，使这些元组与表中已有其它元组的主属性取值相同，观察DBMS 反应

更改代码如下：

```sql
UPDATE tbCellcopy
SET "SECTOR_ID" = '124672-4'
WHERE "SECTOR_ID" = '124672-0';
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_01_03.png)
DBMS报错，改键对应的值无法更改

### 空值约束

#### 向表中插入新元组

插入代码如下：

```sql
INSERT INTO tbcellcopy VALUES ('beijing', '000001', 'haidian', null);
```

结果如下:
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_02_01.png)

"ENODEBID"列不能为空，无法插入

#### 修改表中已有元组时，如果导致该属性上取值为空，DBMS 的反应和处理方式

修改代码如下：

```sql
UPDATE tbcellcopy
SET "ENODEBID" = null
WHERE "SECTOR_ID" = '124672-0';
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_02_02.png)
"ENODEBID"列不能为空，无法更改

### check约束

#### 向表中插入新元组

插入代码如下：

```sql
INSERT INTO tbcellcopy VALUES ('beijing', '000001', 'haidian', 1, 'haidian', 123456);
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_03_01.png)

不满足check约束，无法插入

#### 修改表中已有元组时，违反表中已经定义的check约束，DBMS的不同反应和

修改代码如下：

```sql
UPDATE tbcellcopy
SET "PCI" = 1000
WHERE "SECTOR_ID" = '124672-0';
```

结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_03_02.png)

不满足check约束，无法修改

### 默认值

#### 向表中插入在该属性上取值为null 的新元组

插入代码如下:

```sql
INSERT INTO tbcellcopy
VALUES ('beijing', '000001', 'haidian', 1, 'haidian', 38400, NULL, NULL, NULL, NULL, NULL, NULL);
SELECT *
FROM tbCellcopy
WHERE "SECTOR_ID" = '000001';
```

查询结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_04_01.png)
结果表明：若手动设置默认值为NULL，则该元组此处对应的值为NULL，而不是默认值。

#### 将表中已有元组在在该属性上取值修改为null 时，观察修改后的元组

修改代码如下：

```sql
UPDATE tbcellcopy
SET "LONGITUDE" = NULL
WHERE "SECTOR_ID" = '124672-0';
```

![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab3/img/GaussDB3_02_04_02.png)
结果表明：修改了定义了默认值属性的元组，该属性上的取值部位默认值，而是修改之后的结果

## 外键/参照完整性约束验证

### 参照完整性约束验证

#### 判断参照完整性约束是否满足
首先，利用分布式版本数据库对于tbCell是否覆盖所有数据进行探查。以tbCell与tbAdjCell之间的外键依赖为例，通过如下所述的SQL语句进行测试：
```sql
SELECT "S_SECTOR_ID"
FROM tbAdjCell
WHERE NOT EXISTS(
    SELECT "SECTOR_ID"
    FROM tbCell
    WHERE "SECTOR_ID" = "S_SECTOR_ID"
) UNION
SELECT "N_SECTOR_ID"
FROM tbAdjCell
WHERE NOT EXISTS(
    SELECT "SECTOR_ID"
    FROM tbCell
    WHERE "SECTOR_ID" = "N_SECTOR_ID"
);
```
执行效果如图所示：  
[![GaussDB3_03_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_03_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/lab3/GaussDB3_03_1.csv)    
显然，参照完整性约束并不满足，tbAdjCell的N_SECTOR_ID中的部分值并不在tbCell中。

#### 改造参照关系表，以满足完整性要求

处理tbAdjCell中的异常数据，使得剔除这部分数据后的tbAdjCell满足参照完整性约束。代码实现如下：  
```sql
DELETE FROM tbAdjCell
WHERE "S_SECTOR_ID" = SOME(
    SELECT "S_SECTOR_ID"
    FROM tbAdjCell
    WHERE NOT EXISTS(
            SELECT "SECTOR_ID"
            FROM tbCell
            WHERE "SECTOR_ID" = "S_SECTOR_ID"
        )
    );
DELETE FROM tbAdjCell
WHERE "N_SECTOR_ID" = SOME(
    SELECT "N_SECTOR_ID"
    FROM tbAdjCell
    WHERE NOT EXISTS(
            SELECT "SECTOR_ID"
            FROM tbCell
            WHERE "SECTOR_ID" = "N_SECTOR_ID"
        )
    );
```
执行效果如图所示：  
[![GaussDB3_03_3](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_03_3.png)]()  

再次执行上述完整性约束判断，效果如图所示：  
[![GaussDB3_03_4](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_03_4.png)]()  
本次探查未检索到非法数据，也就说明修改后的tbAdjCell表格满足了与tbCell之间的参照完整性约束。

#### 非级联外键依赖关联的构建

受迫于原先实验完全在分布式版数据库中实现，首先在主备版finance数据库中重新建表导入数据，SQL语句如下：

```sql
DROP TABLE IF EXISTS tbcell;
CREATE TABLE tbCell (
"CITY" nvarchar2(255),
"SECTOR_ID" nvarchar2(255),
"SECTOR_NAME" nvarchar2(255),
"ENODEBID" int,
"ENODEB_NAME" nvarchar2(255),
"EARFCN" int,
"PCI" int,
"PSS" int,
"SSS" int,
"TAC" nvarchar2(255),
"VENDOR" nvarchar2(255),
"LONGITUDE" float,
"LATITUDE" float,
"STYLE" nvarchar2(255),
"AZIMUTH" float,
"HEIGHT" float,
"ELECTTILT" nvarchar2(255),
"MECHTILT" nvarchar2(255),
"TOTLETILT" nvarchar2(255),
primary key ("SECTOR_ID")
);

ALTER TABLE tbcell ADD CONSTRAINT UQ_SECTOR_NAME UNIQUE ("SECTOR_NAME");
ALTER TABLE "tbcell" ALTER COLUMN "ENODEBID" SET NOT NULL;
ALTER TABLE tbcell ADD CONSTRAINT CK_PCI CHECK(("PCI"=3*"SSS") + "PSS" AND "PCI" >=0  AND "PCI" <= 503);
ALTER TABLE tbcell ADD CONSTRAINT CK_EARFCN CHECK("EARFCN" = 37900 
    OR "EARFCN" = 38098 OR "EARFCN" = 38400 OR "EARFCN" = 38950 OR "EARFCN" = 39148);
ALTER TABLE tbcell ADD CONSTRAINT CK_PSS CHECK ( "PSS" >= 0 AND "PSS" <= 2);
ALTER TABLE tbcell ADD CONSTRAINT CK_SSS CHECK ( "SSS" >= 0 AND "PSS" <= 167);
ALTER TABLE tbcell ALTER  "LATITUDE" SET DEFAULT 112.77068;
ALTER TABLE tbcell ALTER  "LONGITUDE" SET DEFAULT 33.810396;
ALTER TABLE tbcell ALTER  "AZIMUTH" SET DEFAULT 0;
ALTER TABLE tbcell ALTER  "HEIGHT" SET DEFAULT 20;

/****************************************/

DROP TABLE IF EXISTS tbAdjCell;
CREATE TABLE tbAdjCell (
"S_SECTOR_ID" nvarchar2(255),
"N_SECTOR_ID" nvarchar2(255),
"S_EARFCN" nvarchar2(255),
"N_EARFCN" nvarchar2(255)
);

DROP TABLE IF EXISTS tbSecAdjCell;
CREATE TABLE tbSecAdjCell (
"S_SECTOR_ID" nvarchar2(255),
"N_SECTOR_ID" nvarchar2(255)
);

DROP TABLE IF EXISTS tbHandOver;
CREATE TABLE tbHandOver (
"CITY"	nvarchar2(255),
"SCELL"	nvarchar2(255),
"NCELL"	nvarchar2(255),
"HOATT"	nvarchar2(255),
"HOSUCC"	nvarchar2(255),
"HOSUCCRATE" nvarchar2(255)
);

DROP TABLE IF EXISTS tbC2I;
CREATE TABLE tbC2I (
"CITY"	nvarchar2(255),
"SCELL"	nvarchar2(255),
"NCELL"	nvarchar2(255),
"PrC2I9"nvarchar2(255),
"C2I_Mean"	nvarchar2(255),
"std"	nvarchar2(255),
"SampleCount"	nvarchar2(255),
"WeightedC2I" nvarchar2(255)
);
```

```sql
ALTER TABLE tbAdjCell
ADD CONSTRAINT "FK_S_SECTOR_ID" FOREIGN KEY ("S_SECTOR_ID") REFERENCES tbCell("SECTOR_ID");
ALTER TABLE tbAdjCell
ADD CONSTRAINT "FK_N_SECTOR_ID" FOREIGN KEY ("N_SECTOR_ID") REFERENCES tbCell("SECTOR_ID");

ALTER TABLE tbSecAdjCell
ADD CONSTRAINT "FK_S_SECTOR_ID" FOREIGN KEY ("S_SECTOR_ID") REFERENCES tbCell("SECTOR_ID");
ALTER TABLE tbSecAdjCell
ADD CONSTRAINT "FK_N_SECTOR_ID" FOREIGN KEY ("N_SECTOR_ID") REFERENCES tbCell("SECTOR_ID");

ALTER TABLE tbHandOver
ADD CONSTRAINT "FK_SCELL" FOREIGN KEY ("SCELL") REFERENCES tbCell("SECTOR_ID");
ALTER TABLE tbHandOver
ADD CONSTRAINT "FK_NCELL" FOREIGN KEY ("NCELL") REFERENCES tbCell("SECTOR_ID");

ALTER TABLE tbC2I
ADD CONSTRAINT "FK_SCELL" FOREIGN KEY ("SCELL") REFERENCES tbCell("SECTOR_ID");
ALTER TABLE tbC2I
ADD CONSTRAINT "FK_NCELL" FOREIGN KEY ("NCELL") REFERENCES tbCell("SECTOR_ID");
```
执行效果如图所示：  
[![GaussDB3_03_2](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_03_2.png)]()


### 非级联外键关联下数据访问
分别设置三组增删修改的语句，各自执行后的效果如下所述
```sql
INSERT INTO tbAdjCell
VALUES ('INSERT_TEST', 'INSERT_TEST', 'INSERT_TEST', 'INSERT_TEST');

UPDATE tbAdjCell
SET "N_SECTOR_ID" = 'UPDATE_TEST' WHERE "S_SECTOR_ID" = '124673-0';

DELETE FROM tbAdjCell
WHERE "S_SECTOR_ID" = '124673-0';
```
各自的执行效果如下：  
- 增加  

[![GaussDB3_03_5](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_03_5.png)]()  
- 修改  

[![GaussDB3_03_6](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_03_6.png)]()   
- 删除  

[![GaussDB3_03_7](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_03_7.png)]()  


由上述三项操作的成功与否可以看出，前两项操作的失败是由于添加了并未出现在tbCell表格内已存在的项目所以导致。而删除某项数据因未引入不存在与tbCell内的依赖项而可以正常执行。

## 函数依赖分析验证

### 判断函数依赖关系是否存在
为判断函数依赖关系函数依赖：  
*ENODEBID → LONGITUDE, LATITUDE（即 α → β）*  
是否成立，需判断  
*∀ t1, t2 ∈ tbCell，t1[α]=t2[α] ⇒ t1[β]=t2[β]*  
是否成立。  

其求解SQL语句如下：  
```sql
SELECT DISTINCT tb1."ENODEBID", tb1."LONGITUDE", tb1."LATITUDE", tb2."LONGITUDE", tb2."LATITUDE"
FROM tbCell AS tb1, tbCell AS tb2
WHERE tb1."ENODEBID" = tb2."ENODEBID" AND (
    tb1."LONGITUDE" <> tb2."LONGITUDE" OR tb1."LATITUDE" <> tb2."LATITUDE");
```
执行效果如下：  
[![GaussDB3_04_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB3_04_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/lab3/GaussDB3_04_1.csv)  
因存在不满足条件的记录，故当前三者之间不存在函数依赖关系

### 寻找函数依赖不存在的元组
特别声明，上述寻得的86条记录未经过去重，tb1与tb2的反身对应记录未经筛除。