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

## 查询2
设置带查询数据取值范围为：
|name|lower|upper|
|-|-|-|
|LONGITUDE|112.9|113.1|
|LATITUDE|33.4|34|
|PCI|100|3000|

未去重情况：  
SQL查询代码如下
```sql
select "ENODEBID", "ENODEB_NAME", "STYLE", "VENDOR"
from tbcell
where "CITY" = 'sanxia'
and "LONGITUDE" between '112.9' and '113.1'
and "LATITUDE" between '33.4' and '34'
and "PCI" between '100' and '300'
order by "LONGITUDE" asc, "LATITUDE" desc
;
```
查询结果：66条  
查询时间：76ms
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_02_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_02_01.csv)
去重情况下：
SQL查询代码如下
```sql
select  "ENODEBID", "ENODEB_NAME", "STYLE", "VENDOR"
from (select  distinct "ENODEBID", "ENODEB_NAME", "STYLE", "VENDOR"，"LONGITUDE","LATITUDE"
from tbcell
where "CITY" = 'sanxia'
and "LONGITUDE" between '112.9' and '113.1'
and "LATITUDE" between '33.4' and '34'
and "PCI" between '100' and '300')
order by "LONGITUDE" desc ,"LATITUDE"asc
;
```
查询结果：25条  
查询时间：64ms
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_02_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_02_02.csv)
由结果可见去重后的总查询时间变短


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


## 查询5

未去重情况：  
SQL查询代码如下
```sql
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("RRC建立成功率qf (%)" as float) > 0.95 UNION
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("E-RAB建立成功率2 (%)" as float) > 0.99;
```
查询结果：646条  
查询时间：64ms
[![GaussDB1_01_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_05_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_05_2.csv)

去重情况下：
SQL查询代码如下
```sql
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("RRC建立成功率qf (%)" as float) > 0.95 UNION ALL
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("E-RAB建立成功率2 (%)" as float) > 0.99;
```
查询结果：323条  
查询时间：62ms
[![GaussDB1_01_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_05_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_05_2.csv)
由结果可见去重后的总查询时间变短