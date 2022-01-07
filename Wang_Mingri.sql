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
PRIMARY KEY ("SECTOR_ID")
);

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
PRIMARY KEY ("小区名称")/*,
FOREIGN KEY ("ENODEB_NAME") REFERENCES tbCell*/
);

DROP TABLE IF EXISTS tbMROData;
CREATE TABLE tbMROData(
"TimeStamp"	nvarchar2(255),
"ServingSector"	nvarchar2(255),
"InterferingSector"	nvarchar2(255),
"LteScRSRP"	nvarchar2(255),
"LteNcRSRP"	nvarchar2(255),
"LteNcEarfcn"	nvarchar2(255),
"LteNcPci"	nvarchar2(255)/*,
PRIMARY KEY ("TimeStamp", "ServingSector", "InterferingSector")*/
);

DROP TABLE IF EXISTS tbCellTraffic;
CREATE TABLE tbCellTraffic(
"Date"	nvarchar2(255),
"Hour"	nvarchar2(255),
"Sector_ID"	nvarchar2(255),
"Traffic"	nvarchar2(255),
PRIMARY KEY ("Date", "Hour", "Sector_ID")
);

DROP TABLE IF EXISTS tbATUC2I;
CREATE TABLE tbATUC2I(
"SECTOR_ID"	nvarchar2(255),
"NCELL_ID"	nvarchar2(255),
"RATIO_ALL"	nvarchar2(255),
"RANK"	nvarchar2(255),
"COSITE"	nvarchar2(255),
PRIMARY KEY ("SECTOR_ID", "NCELL_ID")
);

DROP TABLE IF EXISTS tbATUHandover;
CREATE TABLE tbATUHandover(
"SECTOR_ID"	nvarchar2(255),
"NSECTOR_ID"	nvarchar2(255),
"HOATT"	nvarchar2(255)
);

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

DROP TABLE IF EXISTS tbHandOver;
CREATE TABLE tbHandOver(
"CITY"	nvarchar2(255),
"SCELL"	nvarchar2(255),
"NCELL"	nvarchar2(255),
"HOATT"	nvarchar2(255),
"HOSUCC"	nvarchar2(255),
"HOSUCCRATE"	nvarchar2(255),
PRIMARY KEY ("SCELL", "NCELL")
);

/*1*/
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
    "EARFCN" DESC;

/*3*/
SELECT "SECTOR_NAME"
FROM tbcell
WHERE (
        "SECTOR_NAME" LIKE 'A池%'
        OR "SECTOR_NAME" LIKE '高铁%'
        OR    "ENODEB_NAME" LIKE '%医院%'
        OR    "ENODEB_NAME" LIKE '%实验高中%'
    )
    AND(
        "SECTOR_NAME" LIKE '%-1'
    );

/*5_1*/
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("RRC建立成功率qf (%)" as float) > 0.95 UNION
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("E-RAB建立成功率2 (%)" as float) > 0.99;

/*5_2*/
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("RRC建立成功率qf (%)" as float) > 0.95 UNION ALL
SELECT "小区名称"
FROM tbCellKPI
WHERE cast("E-RAB建立成功率2 (%)" as float) > 0.99;

/*7*/
SELECT *
FROM tbMROData, tbCellTraffic;

/*9*/
SELECT "SECTOR_NAME", "SECTOR_ID", "NCELL_ID", "NSECTOR_ID"
FROM tbcell NATURAL JOIN tbATUC2I NATURAL JOIN tbATUHandover
WHERE "SECTOR_ID" LIKE '238397-1';

/*11_HEAD*/
with TEMP_11 AS(/*将数据汇总为每月忙时时段*/
    SELECT "SECTOR_ID", sum("dailysum_Traffic") AS "sum_Traffic"
    FROM (/*将数据汇总为每天忙时时段*/
        SELECT "SECTOR_ID", "Date", sum("Traffic") AS "dailysum_Traffic"
        FROM tbCellTraffic, tbCell
        WHERE "SECTOR_ID" = "Sector_ID"
        GROUP BY "SECTOR_ID", "Date", "Hour", "LONGITUDE", "LATITUDE"
        HAVING "Date" LIKE '%/5/2020%'
        AND (
            "Hour" BETWEEN '9' AND '11'
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

/*13*/
WITH TEMP_13 AS(/*将数据汇总为每天忙时时段*/
    SELECT "SECTOR_ID", avg("sum_Traffic") AS "avg_Traffic"
    FROM (
             SELECT "SECTOR_ID", sum("Traffic") AS "sum_Traffic"
             FROM tbCellTraffic,
                  tbCell
             WHERE "SECTOR_ID" = "Sector_ID"
               AND "Date" LIKE '%2020%'
             GROUP BY "SECTOR_ID"
             UNION
             /*用UNION的方式将2019年总量与2020年总量拼接起来，再求两年总量的平均值*/
             SELECT "SECTOR_ID", sum("Traffic") AS "sum_Traffic"
             FROM tbCellTraffic,
                  tbCell
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

/*15_1*/
SELECT "SECTOR_NAME", "SECTOR_ID", "HEIGHT"
FROM tbCell
WHERE "HEIGHT" > SOME(
    SELECT "HEIGHT"
    FROM tbCell
    WHERE "LONGITUDE" BETWEEN '112.2' AND '112.7'
        AND "LATITUDE" BETWEEN '33.2' AND '33.7'
);

/*15_2*/
SELECT "SECTOR_ID", "SECTOR_NAME", "RSRP"/*尾部自然连接补充小区名称*/
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
     )NATURAL JOIN tbCell;

/*17_1*/
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

/*17_2*/
SELECT DISTINCT fri1."S_SECTOR_ID"
FROM tbadjcell AS fri1
WHERE NOT EXISTS(
        (/*fri1中某个记录的所有一阶邻小区*/
            SELECT fri2."N_SECTOR_ID"
            FROM tbadjcell AS fri2
            WHERE fri1."S_SECTOR_ID" = fri2."S_SECTOR_ID"
        )
        EXCEPT
        (/*fri1中某个记录的所有二阶邻小区*/
            SELECT "N_SECTOR_ID"
            FROM tbsecadjcell AS sec
            WHERE fri1."S_SECTOR_ID" = sec."S_SECTOR_ID"
        )
    )
OR (/*查找另一种包含情况，不做赘述*/
    NOT EXISTS(
            (
                SELECT "N_SECTOR_ID"
                FROM tbsecadjcell AS sec
                WHERE fri1."S_SECTOR_ID" = sec."S_SECTOR_ID"
            )
            EXCEPT
            (
                SELECT fri2."N_SECTOR_ID"
                FROM tbadjcell AS fri2
                WHERE fri1."S_SECTOR_ID" = fri2."S_SECTOR_ID"
            )
        )
    );

/*19*/
SELECT "SECTOR_ID", "avg_RRC"
FROM (
         SELECT "小区名称" AS "SECTOR_NAME", avg("RRC建立成功率qf (%)") AS "avg_RRC"
         FROM tbCellKPI
         WHERE (
                     "起始时间" LIKE '07/17/2020%'
                 OR "起始时间" LIKE '07/18/2020%'
                 OR "起始时间" LIKE '07/19/2020%'
             )
         GROUP BY "小区名称"
     ) NATURAL JOIN tbCell;

/*21*/
WITH TEMP_21 AS (
    SELECT "SCELL", count("NCELL") AS "count_NCELL"
    FROM (
             SELECT DISTINCT tb1."SCELL", tb1."NCELL"
             FROM tbHandOver AS tb1,
                  tbHandOver AS tb2
             WHERE tb1."SCELL" = tb2."SCELL"
         )
    GROUP BY "SCELL"
)
SELECT "SCELL", "MAX_count"
FROM (
         SELECT max("count_NCELL") AS "MAX_count"
         FROM TEMP_21
     ) NATURAL JOIN TEMP_21
WHERE "MAX_count" = "count_NCELL";

/*23*/
SELECT DISTINCT *
FROM tbpciassignment NATURAL JOIN (
    SELECT COUNT("PCI") AS COUNT_PCI
    FROM tbpciassignment
    GROUP BY "ENODEB_ID"
)
WHERE COUNT_PCI > 1;

/*25*/
INSERT INTO tbadjcell("S_SECTOR_ID", "N_SECTOR_ID")
SELECT "S_SECTOR_ID", "N_SECTOR_ID"
FROM tbsecadjcell
WHERE "S_SECTOR_ID" = '124673-0';

/*27*/
UPDATE tbCell
SET("PCI") =(
    SELECT ("PCI")
    FROM tbpciassignment AS ASS
    WHERE ASS."SECTOR_ID" = tbCell."SECTOR_ID"
    );

/*******************************************************************/

/*3.3*/
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


INSERT INTO tbAdjCell
VALUES ('INSERT_TEST', 'INSERT_TEST', 'INSERT_TEST', 'INSERT_TEST');

UPDATE tbAdjCell
SET "N_SECTOR_ID" = 'UPDATE_TEST' WHERE "S_SECTOR_ID" = '124673-0';

DELETE FROM tbAdjCell
WHERE "S_SECTOR_ID" = '124673-0';

/*3_4*/
SELECT DISTINCT tb1."ENODEBID", tb1."LONGITUDE", tb1."LATITUDE", tb2."LONGITUDE", tb2."LATITUDE"
FROM tbCell AS tb1, tbCell AS tb2
WHERE tb1."ENODEBID" = tb2."ENODEBID" AND (
    tb1."LONGITUDE" <> tb2."LONGITUDE" OR tb1."LATITUDE" <> tb2."LATITUDE")
ORDER BY tb1."ENODEBID", tb1."LONGITUDE", tb1."LATITUDE", tb2."LONGITUDE", tb2."LATITUDE";

/*3_5*/
/*
开发一个数据插入查重触发器，实现：
向一张表中插入一行新数据时，如果新数据的主键与表中已有其它元组的主键不相同，则直接插入；
如果新数据的主键与表中已有元组的主键相同，则根据新插入元组的属性值修改已有元组的属性值，
或者：先删除主键相同的已有元组，再插入新元组。
*/

CREATE FUNCTION insert_func() RETURNS TRIGGER
AS $$ DECLARE
    cnt INTEGER ;
BEGIN
    cnt = (SELECT count(*)
           FROM tbcell
           WHERE "SECTOR_ID" = NEW."SECTOR_ID");
    IF cnt >= 1 THEN
        DELETE FROM tbcell
        WHERE "SECTOR_ID" = NEW."SECTOR_ID";
    END IF;
    RETURN NEW;
END;

$$ LANGUAGE PLPGSQL;


CREATE TRIGGER INSERT_TRIGGER
BEFORE INSERT
ON tbcell
FOR EACH ROW
EXECUTE PROCEDURE insert_func();