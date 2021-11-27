# 第一章 数据查询与修改实验

## 数据导入——tbCell建表

```sql
CREATE TABLE tbCell (
"CITY" nvarchar2(255),
"SECTOR_ID" nvarchar2(255),
"SECTOR_NAME" nvarchar2(255),
"ENODEBID" nvarchar2(255),
"ENODEB_NAME" nvarchar2(255),
"EARFCN" nvarchar2(255),
"PCI" nvarchar2(255),
"PSS" nvarchar2(255),
"SSS" nvarchar2(255),
"TAC" nvarchar2(255),
"VENDOR" nvarchar2(255),
"LONGITUDE" nvarchar2(255),
"LATITUDE" nvarchar2(255),
"STYLE" nvarchar2(255),
"AZIMUTH" nvarchar2(255),
"HEIGHT" nvarchar2(255),
"ELECTTILT" nvarchar2(255),
"MECHTILT" nvarchar2(255),
"TOTLETILT" nvarchar2(255),
primary key ("SECTOR_ID")
);
```


## 查询1

设置待查询数据取值范围为：
|name|lower|upper|
|-|-|-|
|LONGITUDE|112.2|112.7|
|LATITUDE|33.2|33.7|
|PCI|20|70|

SQL查询代码如下
```sql
SELECT "SECTOR_ID", "SECTOR_NAME", "ENODEBID", "ENODEB_NAME", "LONGITUDE",
       "LATITUDE", "PCI" AS "Physical Cell Identity", "AZIMUTH", "HEIGHT"
FROM tbcell
WHERE "CITY" = 'sanxia'
AND "LONGITUDE" BETWEEN '112.2' AND '112.7'
AND "LATITUDE" BETWEEN '33.2' AND '33.7'
AND "PCI" BETWEEN '20' AND '70'
AND "VENDOR" IS NOT NULL
ORDER BY "LONGITUDE" DESC,
    "LATITUDE" DESC,
    "EARFCN" DESC
```
DataGrip运行界面与部分结果截图（点击图片跳转至完整输出文件）
[![GaussDB1_01_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_01_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_01.csv)


## 查询3

SQL查询代码如下
```sql
SELECT "SECTOR_NAME"
FROM tbcell
WHERE ("SECTOR_NAME" LIKE 'A池%' OR
    "SECTOR_NAME" LIKE '高铁%' OR
    "ENODEB_NAME" LIKE '%医院%' OR
    "ENODEB_NAME" LIKE '%实验高中%') AND
    ("SECTOR_NAME" LIKE '%-1');

```
DataGrip运行界面与部分结果截图（点击图片跳转至完整输出文件）
[![GaussDB1_03_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_03_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_03.csv)