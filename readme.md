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
"eNB内切换出请求次数 (次)"	nvarchar2(255),
primary key ("小区名称")/*,
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

#### *tbC21*
```sql
DROP TABLE IF EXISTS tbC21;
CREATE TABLE tbC21 (
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
设置带查询数据取值范围为：
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