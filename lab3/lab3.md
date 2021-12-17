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

```