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

