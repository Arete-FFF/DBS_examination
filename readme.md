# 第一章 数据查询与修改实验

## 数据导入

#### *tbCell*
```sql
DROP TABLE IF EXISTS tbCell;
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

#### *tbCellKPI*
```sql
DROP TABLE IF EXISTS tbCellKPI;
CREATE TABLE tbCellKPI(
"起始时间"	nvarchar2(255),
"网元/基站名称"	nvarchar2(255),
"小区"	nvarchar2(255),
"小区名称"	nvarchar2(255),
"RRC连接建立完成次数 (无)"	nvarchar2(255),
"RRC连接请求次数（包括重发） (无)"	nvarchar2(255),
"RRC建立成功率qf (%)"	nvarchar2(255),
"E-RAB建立成功总次数 (无)"	nvarchar2(255),
"E-RAB建立尝试总次数 (无)"	nvarchar2(255),
"E-RAB建立成功率2 (%)"	nvarchar2(255),
"eNodeB触发的E-RAB异常释放总次数 (无)"	nvarchar2(255),
"小区切换出E-RAB异常释放总次数 (无)"	nvarchar2(255),
"E-RAB掉线率(新) (%)"	nvarchar2(255),
"无线接通率ay (%)"	nvarchar2(255),
"eNodeB发起的S1 RESET导致的UE Context释放次数 (无)"	nvarchar2(255),
"UE Context异常释放次数 (无)"	nvarchar2(255),
"UE Context建立成功总次数 (无)"	nvarchar2(255),
"无线掉线率 (%)"	nvarchar2(255),
"eNodeB内异频切换出成功次数 (无)"	nvarchar2(255),
"eNodeB内异频切换出尝试次数 (无)"	nvarchar2(255),
"eNodeB内同频切换出成功次数 (无)"	nvarchar2(255),
"eNodeB内同频切换出尝试次数 (无)"	nvarchar2(255),
"eNodeB间异频切换出成功次数 (无)"	nvarchar2(255),
"eNodeB间异频切换出尝试次数 (无)"	nvarchar2(255),
"eNodeB间同频切换出成功次数 (无)"	nvarchar2(255),
"eNodeB间同频切换出尝试次数 (无)"	nvarchar2(255),
"eNB内切换成功率 (%)"	nvarchar2(255),
"eNB间切换成功率 (%)"	nvarchar2(255),
"同频切换成功率zsp (%)"	nvarchar2(255),
"异频切换成功率zsp (%)"	nvarchar2(255),
"切换成功率 (%)"	nvarchar2(255),
"小区PDCP层所接收到的上行数据的总吞吐量 (比特)"	nvarchar2(255),
"小区PDCP层所发送的下行数据的总吞吐量 (比特)"	nvarchar2(255),
"RRC重建请求次数 (无)"	nvarchar2(255),
"RRC连接重建比率 (%)"	nvarchar2(255),
"通过重建回源小区的eNodeB间同频切换出执行成功次数 (无)"	nvarchar2(255),
"通过重建回源小区的eNodeB间异频切换出执行成功次数 (无)"	nvarchar2(255),
"通过重建回源小区的eNodeB内同频切换出执行成功次数 (无)"	nvarchar2(255),
"通过重建回源小区的eNodeB内异频切换出执行成功次数 (无)"	nvarchar2(255),
"eNB内切换出成功次数 (次)"	nvarchar2(255),
"eNB内切换出请求次数 (次)"	nvarchar2(255)
/*primary key ("小区名称"),
FOREIGN KEY ("ENODEB_NAME") REFERENCES tbCell*/
);
```

#### *tbMROData*
```sql
DROP TABLE IF EXISTS tbMROData;
CREATE TABLE tbMROData(
"TimeStamp"	nvarchar2(255),
"ServingSector"	nvarchar2(255),
"InterferingSector"	nvarchar2(255),
"LteScRSRP"	nvarchar2(255),
"LteNcRSRP"	nvarchar2(255),
"LteNcEarfcn"	nvarchar2(255),
"LteNcPci"	nvarchar2(255)/*,
primary key ("TimeStamp", "ServingSector", "InterferingSector")*/
);
```

#### *tbCellTraffic*
```sql
DROP TABLE IF EXISTS tbCellTraffic;
CREATE TABLE tbCellTraffic(
"Date"	nvarchar2(255),
"Hour"	nvarchar2(255),
"Sector_ID"	nvarchar2(255),
"Traffic"	nvarchar2(255),
primary key ("Date", "Hour", "Sector_ID")
);
```
#### *tbAdjCell*
```sql
DROP TABLE IF EXISTS tbAdjCell;
CREATE TABLE tbAdjCell (
"S_SECTOR_ID" nvarchar2(255),
"N_SECTOR_ID" nvarchar2(255),
"S_EARFCN" nvarchar2(255),
"N_EARFCN" nvarchar2(255)
);
```
#### *tbSecAdjCell*
```sql
DROP TABLE IF EXISTS tbSecAdjCell;
CREATE TABLE tbSecAdjCell (
"S_SECTOR_ID" nvarchar2(255),
"N_SECTOR_ID" nvarchar2(255)
);
```

#### *tbC2I*
```sql
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

#### *tbOptCell*
```sql
DROP TABLE IF EXISTS tbOptCell;
CREATE TABLE tbOptCell (
"SECTOR_ID"	nvarchar2(255),
"EARFCN"	nvarchar2(255),
"CELL_TYPE" nvarchar2(255)
);
```
#### *tbATUdata*
```sql
DROP TABLE IF EXISTS tbATUdata;
CREATE TABLE tbATUdata(
"seq"	nvarchar2(255),
"FileName"	nvarchar2(255),
"Time"	nvarchar2(255),
"Longitude"	nvarchar2(255),
"Latitude"	nvarchar2(255),
"CellID"	nvarchar2(255),
"TAC"	nvarchar2(255),
"EARFCN"	nvarchar2(255),
"PCI"	nvarchar2(255),
"RSRP"	nvarchar2(255),
"RS SINR"	nvarchar2(255),
"NCell_ID_1"	nvarchar2(255),
"NCell_EARFCN_1"	nvarchar2(255),
"NCell_PCI_1"	nvarchar2(255),
"NCell_RSRP_1"	nvarchar2(255),
"NCell_ID_2"	nvarchar2(255),
"NCell_EARFCN_2"	nvarchar2(255),
"NCell_PCI_2"	nvarchar2(255),
"NCell_RSRP_2"	nvarchar2(255),
"NCell_ID_3"	nvarchar2(255),
"NCell_EARFCN_3"	nvarchar2(255),
"NCell_PCI_3"	nvarchar2(255),
"NCell_RSRP_3"	nvarchar2(255),
"NCell_ID_4"	nvarchar2(255),
"NCell_EARFCN_4"	nvarchar2(255),
"NCell_PCI_4"	nvarchar2(255),
"NCell_RSRP_4"	nvarchar2(255),
"NCell_ID_5"	nvarchar2(255),
"NCell_EARFCN_5"	nvarchar2(255),
"NCell_PCI_5"	nvarchar2(255),
"NCell_RSRP_5"	nvarchar2(255),
"NCell_ID_6"	nvarchar2(255),
"NCell_EARFCN_6"	nvarchar2(255),
"NCell_PCI_6"	nvarchar2(255),
"NCell_RSRP_6"	nvarchar2(255),
PRIMARY KEY ("seq", "FileName")
);
```

#### *tbHandOver*
```sql
DROP TABLE IF EXISTS tbHandOver;
CREATE TABLE tbHandOver (
"CITY"	nvarchar2(255),
"SCELL"	nvarchar2(255),
"NCELL"	nvarchar2(255),
"HOATT"	nvarchar2(255),
"HOSUCC"	nvarchar2(255),
"HOSUCCRATE" nvarchar2(255)
);
```
-------------------------------------------------------------------------------

## 查询1

设置待查询数据取值范围为：
| name      | lower | upper |
| --------- | ----- | ----- |
| LONGITUDE | 112.2 | 112.7 |
| LATITUDE  | 33.2  | 33.7  |
| PCI       | 20    | 70    |

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
[![GaussDB1_01](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_01.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_01.csv)

## 查询2
设置待查询数据取值范围为：
| name      | lower | upper |
| --------- | ----- | ----- |
| LONGITUDE | 112.9 | 113.1 |
| LATITUDE  | 33.4  | 34    |
| PCI       | 100   | 3000  |

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
DataGrip运行界面与部分结果截图（点击图片跳转至完整输出文件）
[![GaussDB1_02_1](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_02_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_02_1.csv)
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
DataGrip运行界面与部分结果截图（点击图片跳转至完整输出文件）
[![GaussDB1_02_2](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_02_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_02_2.csv)
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
[![GaussDB1_03](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_03.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_03.csv)

## 查询4

SQL查询代码如下
```sql
SELECT DISTINCT "SECTOR_NAME"
FROM tbcell
WHERE "SECTOR_NAME" LIKE '_____-HLHF-_' AND
      LENGTH("ENODEB_NAME") > 8;
```
DataGrip运行界面与部分结果截图（点击图片跳转至完整输出文件）
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_04.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_04.csv)
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
[![GaussDB1_05_2](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_05_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_05_2.csv)

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
[![GaussDB1_05_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_05_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_05_1.csv)
由结果可见去重后的总查询时间变短

## 查询6

使用EXCEPT  
SQL查询代码如下
```sql
SELECT "SECTOR_NAME", "LATITUDE"
FROM tbcell
EXCEPT (SELECT t1."SECTOR_NAME", t1."LATITUDE"
FROM tbcell AS t1 ,tbcell AS t2
WHERE t1."LATITUDE" < t2."LATITUDE");
```
查询时间:23.469s
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_06_1.png))](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_06_1.csv)

使用EXCEPT ALL   
SQL查询代码如下
```sql
SELECT "SECTOR_NAME", "LATITUDE"
FROM tbcell
EXCEPT ALL(SELECT t1."SECTOR_NAME", t1."LATITUDE"
FROM tbcell AS t1 ,tbcell AS t2
WHERE t1."LATITUDE" < t2."LATITUDE");
```
查询时间:23.665s
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_06_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_06_2.csv)

使用 MAX 函数  
SQL查询代码如下
```sql
SELECT "SECTOR_NAME", "LATITUDE"
FROM tbcell
WHERE "LATITUDE" =  (SELECT max("LATITUDE")
                    FROM tbcell);
```
查询时间：0.072s
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_06_3.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_06_3.csv)
使用聚集函数查询时间能大大降低，查询结果并无区别

## 查询7

查询代码如下
```sql
SELECT *
FROM tbMROData, tbCellTraffic;
```
查询效果如下：
[![GaussDB1_07](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_07.png)]()  
由结果可见,大规模笛卡尔积的结果在仅显示结果头部时并不需要大量时间，但以指定查询结尾页为例，Datagrip客户端加载7分钟后报错，强行退出查询程序。  
本次查询不保留csv文件。

## 查询8

查询代码如下：
```sql
SELECT "SECTOR_ID", "SECTOR_NAME", "EARFCN", tbadjcell."N_SECTOR_ID" as "ADJ_SECTOR_ID", tbadjcell."N_EARFCN" as "ADJ_EARFCN", "EARFCN" as "SEC_ADJ_EARFCN"
FROM tbcell join (tbadjcell natural join tbsecadjcell) on "SECTOR_ID" = tbadjcell."S_SECTOR_ID"
```
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_08_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_08.csv)

## 查询9

查询代码如下：
```sql
SELECT "SECTOR_NAME", "SECTOR_ID", "NCELL_ID", "NSECTOR_ID"
FROM tbcell NATURAL JOIN tbATUC2I NATURAL JOIN tbATUHandover
WHERE "SECTOR_ID" LIKE '238397-1';
```
查询效果如下:
[![GaussDB1_09](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_09.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_09.csv)


## 查询10

查询代码如下：
```sql
SELECT "SCELL", A."SECTOR_NAME" AS "M_NAME", "NCELL", B."SECTOR_NAME" AS "N_NAME","C2I_Mean"
FROM (tbC2I join tbcell on tbcell."SECTOR_ID" = tbC2I."SCELL" ) AS A join tbcell AS B on A."NCELL" = B."SECTOR_ID"
WHERE A."C2I_Mean" > (SELECT "C2I_Mean"
                      FROM tbC2I
                      WHERE tbC2I."SCELL" = '124673-0' AND
                            tbC2I."NCELL" = '259772-0')
ORDER BY "C2I_Mean" DESC
```
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_10.jpg)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_10.csv)


## 查询11
本查询使用一个公共头和两组接口对应题干要求的两个查询。  
设置待查询数据取值范围为：
| name      | lower | upper |
| --------- | ----- | ----- |
| LONGITUDE | 112.2 | 112.7 |
| LATITUDE  | 33.2  | 33.7  | 

查询代码如下：
```sql
/*11_HEAD*/
with TEMP_11 AS(
    /*将数据汇总为每月忙时时段*/
    SELECT "SECTOR_ID", sum("dailysum_Traffic") AS "sum_Traffic"
    FROM (/*将数据汇总为每天忙时时段*/
        SELECT "SECTOR_ID", "Date", sum("Traffic") AS "dailysum_Traffic"
        FROM tbCellTraffic, tbCell
        WHERE "SECTOR_ID" = "Sector_ID"
        GROUP BY "SECTOR_ID", "Date", "Hour", "LONGITUDE", "LATITUDE"
        HAVING "Date" LIKE '%/5/2020%'
        AND ("Hour" BETWEEN '9' AND '11'
            OR "Hour" BETWEEN '19' AND '21'
        )
        AND "LONGITUDE" BETWEEN '112.2' AND '112.7'
        AND "LATITUDE" BETWEEN '33.2' AND '33.7'
    )
    GROUP BY "SECTOR_ID"
),
TABLE_11 AS(
    SELECT max("sum_Traffic") AS "max_Traffic",
       min("sum_Traffic") AS "min_Traffic",
       avg("sum_Traffic") AS "avg_Traffic"
    FROM TEMP_11
)
/*在使用时需要删除另一个查询入口*/

/*11_1*/
SELECT * FROM TABLE_11;

/*11_2*/
SELECT "SECTOR_ID", "SECTOR_NAME", "LONGITUDE", "LATITUDE", "sum_Traffic"
FROM (TEMP_11 NATURAL JOIN tbCell), TABLE_11
WHERE "sum_Traffic" = "max_Traffic";
```

查询结果如下：  
（1）全部小区的最大月忙时话务量、最小月忙时话务量、平均月忙时话务量;
[![GaussDB1_11_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_11_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_11_1.csv)  
（2）具有最大月忙时话务量的小区，列出该小区ID、名称、经纬度位置，以及月忙时话务量。
[![GaussDB1_11_2](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_11_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_11_2.csv)

## 查询12
查询代码如下：
```sql
WITH A AS(SELECT "S_SECTOR_ID",count("S_SECTOR_ID")
          FROM tbadjcell
          GROUP BY "S_SECTOR_ID"
          HAVING count("S_SECTOR_ID") > 10)
SELECT B."SECTOR_ID", B."SECTOR_NAME", B."count"
FROM (A join tbcell on A."S_SECTOR_ID" = tbcell."SECTOR_ID" ) AS B natural join tboptcell
WHERE "CELL_TYPE" = '优化区'
ORDER BY B."count" DESC
```
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_12.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_12.csv)


## 查询13

查询代码如下：
```sql
WITH TEMP_13 AS(/*将数据汇总为每天忙时时段*/
    SELECT "SECTOR_ID", avg("sum_Traffic") AS "avg_Traffic"
    FROM(
        SELECT "SECTOR_ID", sum("Traffic") AS "sum_Traffic"
        FROM tbCellTraffic, tbCell
        WHERE "SECTOR_ID" = "Sector_ID"
        AND "Date" LIKE '%2020%'
        GROUP BY "SECTOR_ID"
        UNION /*用UNION的方式将2019年总量与2020年总量拼接起来，再求两年总量的平均值*/
        SELECT "SECTOR_ID", sum("Traffic") AS "sum_Traffic"
        FROM tbCellTraffic, tbCell
        WHERE "SECTOR_ID" = "Sector_ID"
        AND "Date" LIKE '%2019%'
        GROUP BY "SECTOR_ID"
    )
    GROUP BY "SECTOR_ID"
)
SELECT "SECTOR_ID", "SECTOR_NAME", "avg_Traffic"
FROM TEMP_13 NATURAL JOIN tbCell
WHERE "avg_Traffic" > (SELECT avg("avg_Traffic") AS "avg_All" FROM TEMP_13)
ORDER BY "avg_Traffic" DESC;
```
查询效果如下:
[![GaussDB1_13](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_13.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_13.csv)

## 查询14 
使用set membership查询  
查询代码如下：
```sql
SELECT tbcell."SECTOR_ID", tbcell."SECTOR_NAME", tbcell."PCI" AS "PCI_OLD", tbpciassignment."PCI" AS "PCI_NEW"
FROM tbcell JOIN tbpciassignment ON tbcell."SECTOR_ID" = tbpciassignment."SECTOR_ID"
WHERE
  tbcell."SECTOR_ID" in (SELECT "SECTOR_ID" FROM tboptcell WHERE "CELL_TYPE" = '优化区') AND
  tbcell."PCI" <> tbpciassignment."PCI"
```
查询时间：83ms  
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_14_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_14_1.csv)

使用非嵌套查询  
查询代码如下：
```sql
SELECT tbcell."SECTOR_ID", tbcell."SECTOR_NAME", tbcell."PCI" AS "PCI_OLD", tbpciassignment."PCI" AS "PCI_NEW"
FROM (tbcell JOIN tbpciassignment ON tbcell."SECTOR_ID" = tbpciassignment."SECTOR_ID") JOIN tboptcell ON tbcell."SECTOR_ID" = tboptcell."SECTOR_ID"
WHERE "CELL_TYPE" = '优化区' AND tbcell."PCI" <> tbpciassignment."PCI"
```

查询时间：72ms  
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_14_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_14_2.csv)

## 查询15 

1. 
查询代码如下:   
```sql
SELECT "SECTOR_NAME", "SECTOR_ID", "HEIGHT"
FROM tbCell
WHERE "HEIGHT" > SOME(
    SELECT "HEIGHT"
    FROM tbCell
    WHERE "LONGITUDE" BETWEEN '112.2' AND '112.7'
        AND "LATITUDE" BETWEEN '33.2' AND '33.7'
);
```
查询结果如下：
[![GaussDB1_15_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_15_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_15_1.csv)  

2. 
设置待查询数据取值范围为：
| name      | lower | upper |
| --------- | ----- | ----- |
| LONGITUDE | 112.2 | 112.7 |
| LATITUDE  | 33.2  | 33.7  | 

查询代码如下:
```sql
SELECT "SECTOR_ID", "SECTOR_NAME", "RSRP"
FROM (/*获取题干要求的ID与RSRP值*/
         SELECT "CellID" AS "SECTOR_ID", "RSRP"
         FROM tbATUdata
         WHERE "RSRP" > some (
             SELECT "RSRP"
             FROM (/*获取ENodeBID为253903的小区编号*/
                      SELECT "SECTOR_ID" AS "CellID"
                      FROM tbCell
                      WHERE "ENODEBID" = '253903'
                  )
                      NATURAL JOIN tbATUdata
         )
     )NATURAL JOIN tbCell/*此处自然连接补充小区名称*/
```
查询结果如下：
[![GaussDB1_15_2](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_15_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_15_2.csv)

## 查询16

1. 
查询代码如下:   
```sql
SELECT "Sector_ID", count("Hour") AS "Hour_count"
FROM tbcelltraffic
GROUP BY "Sector_ID"
HAVING "Hour_count" >= all (SELECT count("Hour") AS "Hour_count"
                            FROM tbcelltraffic
                            GROUP BY "Sector_ID")
```
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_16_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_16_1.csv)


2. 
查询代码如下：
```sql
SELECT "SCELL", "NCELL", "HOATT"
FROM tbhandover
WHERE "HOATT" >= all (SELECT max("HOATT")
                      FROM tbhandover);

```

查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_16_2.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_16_2.csv)


## 查询17
1. 
查询代码如下:   
```sql
SELECT DISTINCT "SCELL"
FROM tbHandOver AS tb1
WHERE NOT EXISTS(/*恰好全部减掉说明后一个集合完全覆盖了前一个集合，故NOT EXISTS返回True*/
        /*生成四元素集合以供求差*/
        (
            SELECT '15290-128'
            UNION
            SELECT '259595-1'
            UNION
            SELECT '124711-0'
            UNION
            SELECT '47444-1'
        )
        EXCEPT
        /*对于tb1的每一条记录，用倍增法将所有同SCELL的值抽出来叠放在一起，tb2用于铺陈不同NCELL的结果*/
        (
            SELECT tb2."NCELL"
            FROM tbHandOver AS tb2
            WHERE tb1."SCELL" = tb2."SCELL"
        )
    );
```
查询结果如下：
[![GaussDB1_17_1](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_17_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_17_1.csv)  



## 查询18
根据题目要求
使用unique查询代码如下
```sql
SELECT tbadjcell."S_SECTOR_ID"
 FROM tbadjcell
 WHERE not UNIQUE(
       select tbadjcell."S_SECTOR_ID"
       from tbcell,tbadjcell
       where tbcell."ENODEBID"=15114 AND
       tbcell."SECTOR_ID"=tbadjcell."N_SECTOR_ID" )
```
执行代码过程出错：
”UNIQUE predicate is not yet implemented“


不使用unique查询代码如下：
```sql
SELECT "SECTOR_ID", "SECTOR_NAME"
FROM tbcell join tbadjcell on tbcell."SECTOR_ID" = tbAdjCell."S_SECTOR_ID"
WHERE tbAdjCell."N_SECTOR_ID" IN (SELECT DISTINCT "SECTOR_ID"
                                    FROM (tbcell join tbadjcell on tbcell."SECTOR_ID" = tbAdjCell."N_SECTOR_ID") AS B
                                    WHERE B."ENODEBID" = '15114')
GROUP BY "SECTOR_ID", "SECTOR_NAME"
HAVING count("SECTOR_ID")>1
```
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_18.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_18.csv)

## 查询20
查询代码如下：
```sql
WITH A AS(SELECT "小区名称", avg("RRC建立成功率qf (%)") AS "avg_RPC"
          FROM tbcellkpi
          GROUP BY "小区名称")
SELECT "SECTOR_ID" AS "小区ID", "小区名称", "avg_RPC"
FROM tbcell , A
WHERE "小区名称" = "SECTOR_NAME" AND
      "avg_RPC" > 0.992
```
查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_20.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_20.csv)


## 查询22
查询代码如下
```sql
SELECT "TimeStamp", "ServingSector", "InterferingSector",  count("LteNcPci")
FROM tbmrodata
GROUP BY "TimeStamp", "ServingSector", "InterferingSector"
HAVING count("LteNcPci") > 1;
```

根据题目要求可知，判断"TimeStamp", "ServingSector", "InterferingSector"是否组成超键。将这三列进行聚类，然后随机统计其他列个数，若存在大于1的行，则证明这三个键不能组成超键

查询结果如下：
[![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/img/GaussDB1_22.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/GaussDB1_22.csv)
由查询结果可知，存在许多count>1的元组  
故"TimeStamp", "ServingSector", "InterferingSector"不能组成超键

