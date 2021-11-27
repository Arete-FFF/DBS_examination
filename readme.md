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
DataGrip运行界面与部分结果截图
[![image.png](https://github.com/Wang-Mingri/Pic/blob/main/GaussDB1_01_1.png)](https://github.com/Arete-FFF/DBS_examination/blob/main/test.csv)

## 查询2

设置带查询数据取值范围为：