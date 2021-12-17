# 第二章 数据库接口实验
### 插入
#### 添加一条'beijing','000001', 'haidian-HLHF-1',000001,'haidian-HLHF'的数据到数据库。

关键代码如下：
```C
// 8. 直接执行SQL 语句
	char *sqlquery2 = "insert into \"tbcell\"(\"CITY\", \"SECTOR_ID\", \"SECTOR_NAME\",\"ENODEBID\",\"ENODEB_NAME\")values('beijing','000001', 'haidian-HLHF-1','000001','haidian-HLHF')";//插入语句 
	SQLExecDirect(V_OD_hstmt,sqlquery2,SQL_NTS);
	printf("Insert Successed!\n");
	char *sqlquery3 = "SELECT \"CITY\", \"SECTOR_ID\", \"SECTOR_NAME\",\"ENODEBID\",\"ENODEB_NAME\" FROM \"tbcell\" WHERE \"SECTOR_ID\" = '000001'"; //检查插入语句 
	SQLExecDirect(V_OD_hstmt,sqlquery3,SQL_NTS);
	V_OD_erg=SQLFetch(V_OD_hstmt);
// 9. 通过SQLGetData 获取并返回数据。
	int i=0;
	printf("CITY \t SECTOR_ID \tSECTOR_NAME  \tENODEBID  \tENODEB_NAME\n");
	printf("---------------------------------------------------------------\n");
	while(V_OD_erg != SQL_NO_DATA) {
		SQLGetData(V_OD_hstmt,1,SQL_C_CHAR,(SQLPOINTER)&data1,100,NULL);
		SQLGetData(V_OD_hstmt,2,SQL_C_CHAR,(SQLPOINTER)&data2,100,NULL);
		SQLGetData(V_OD_hstmt,3,SQL_C_CHAR,(SQLPOINTER)&data3,100,NULL);
		SQLGetData(V_OD_hstmt,4,SQL_C_CHAR,(SQLPOINTER)&data4,100,NULL);
		SQLGetData(V_OD_hstmt,5,SQL_C_CHAR,(SQLPOINTER)&data5,100,NULL);
		printf("%-9s %-13s %-20s %-8s %-8s\n",data1,data2,data3,data4,data5);
		V_OD_erg=SQLFetch(V_OD_hstmt);
		i++;
		if(i>30) {
			break;
		}
	};
	printf("成功搜索到插入数据，插入成功!\n");
```

实验结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab2/img/GaussDB2_01.png)

### 查询
#### 查sanxia 城市中，经度（longitude）大于111.5 的所有基站id 和名字，经度（enodebid，enodeb_name,longitude),且按照经度降序排列注意相同的只显示一次。、

关键代码如下:
```C
// 8. 直接执行SQL 语句
	char *sqlquery5 = "SELECT \"ENODEBID\",\"ENODEB_NAME\",\"LONGITUDE\" FROM \"tbcell\" WHERE \"LONGITUDE\">'111.5' ORDER BY \"LONGITUDE\" DESC";//查询语句
	SQLExecDirect(V_OD_hstmt,sqlquery5,SQL_NTS);
	V_OD_erg=SQLFetch(V_OD_hstmt);
// 9. 通过SQLGetData 获取并返回数据。
	int i=0;
	printf("ENODEBID \tENODEB_NAME \tLONGITUDE\n");
	printf("-------------------------------------------\n");
	while(V_OD_erg != SQL_NO_DATA) {
		SQLGetData(V_OD_hstmt,1,SQL_C_CHAR,(SQLPOINTER)&data1,100,NULL);
		SQLGetData(V_OD_hstmt,2,SQL_C_CHAR,(SQLPOINTER)&data2,100,NULL);
		SQLGetData(V_OD_hstmt,3,SQL_C_CHAR,(SQLPOINTER)&data3,100,NULL);
		printf("%-9s %-20s %-20s \n",data1,data2,data3);
		V_OD_erg=SQLFetch(V_OD_hstmt);
		i++;
	};
	printf("成功搜索到%d条数据!\n", i);
```
实验结果如下:
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab2/img/GaussDB2_02.png)

### 更改
#### 将（1）中插入的数据，中的earfcn，pci，pss，sss，tac 更新为12345,32,1,10,10000,并打印该行信息
关键代码如下:
```C
// 8. 直接执行SQL 语句
	char *sqlquery6 = "update \"tbcell\" set \"EARFCN\"='12345' , \"PCI\"='32' , \"PSS\"='1' , \"SSS\"='10' , \"TAC\"='10000' where \"ENODEBID\"='000001' ";//更改语句 
	SQLExecDirect(V_OD_hstmt,sqlquery6,SQL_NTS);
	printf("Update Successed!\n") ;
	char *sqlquery3 = "SELECT \"CITY\", \"SECTOR_ID\",\"SECTOR_NAME\",\"ENODEBID\",\"ENODEB_NAME\",\"EARFCN\",\"PCI\",\"PSS\",\"SSS\",\"TAC\" FROM \"tbcell\" WHERE \"SECTOR_ID\" ='000001'"; //检查更改语句 
	SQLExecDirect(V_OD_hstmt,sqlquery3,SQL_NTS);
	V_OD_erg=SQLFetch(V_OD_hstmt);
// 9. 通过SQLGetData 获取并返回数据。
	int i=0;
	printf("查询结果如下:\n");
	printf("\"CITY\"  \"SECTOR_ID\"     \"SECTOR_NAME\" \t\"ENODEBID\"  \"ENODEB_NAME\"  \"EARFCN\"  \"PCI\"  \"PSS\"  \"SSS\"  \"TAC\"\n");
	printf("-----------------------------------------------------------------------------------------------------------\n");
	while(V_OD_erg != SQL_NO_DATA) {
		SQLGetData(V_OD_hstmt,1,SQL_C_CHAR,(SQLPOINTER)&data1,100,NULL);
		SQLGetData(V_OD_hstmt,2,SQL_C_CHAR,(SQLPOINTER)&data2,100,NULL);
		SQLGetData(V_OD_hstmt,3,SQL_C_CHAR,(SQLPOINTER)&data3,100,NULL);
		SQLGetData(V_OD_hstmt,4,SQL_C_CHAR,(SQLPOINTER)&data4,100,NULL);
		SQLGetData(V_OD_hstmt,5,SQL_C_CHAR,(SQLPOINTER)&data5,100,NULL);
		SQLGetData(V_OD_hstmt,6,SQL_C_CHAR,(SQLPOINTER)&data6,100,NULL);
		SQLGetData(V_OD_hstmt,7,SQL_C_CHAR,(SQLPOINTER)&data7,100,NULL);
		SQLGetData(V_OD_hstmt,8,SQL_C_CHAR,(SQLPOINTER)&data8,100,NULL);
		SQLGetData(V_OD_hstmt,9,SQL_C_CHAR,(SQLPOINTER)&data9,100,NULL);
		SQLGetData(V_OD_hstmt,10,SQL_C_CHAR,(SQLPOINTER)&data10,100,NULL);
		printf("%-9s %-13s %-20s %-8s %-8s %-8s %-8s %-8s %-8s %-8s\n",data1,data2,data3,data4,data5,data6,data7,data8,data9,data10);
		V_OD_erg=SQLFetch(V_OD_hstmt);
		i++;
	};
	printf("更改数据成功 !\n");
```
实验结果如下：
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab2/img/GaussDB2_03.png)

### 删除
#### 删除（1）插入的信息，并打印整张表
关键代码如下:
```C
// 8. 直接执行SQL 语句
	char *sqlquery8 = "DELETE FROM \"tbcell\" WHERE \"CITY\"='beijing'";
	SQLExecDirect(V_OD_hstmt,sqlquery8,SQL_NTS);
	printf("Delete Successed!\n");
	char *sqlquery1 = "SELECT \"CITY\", \"SECTOR_ID\", \"SECTOR_NAME\",\"PCI\" FROM \"tbcell\"";
	SQLExecDirect(V_OD_hstmt,sqlquery1,SQL_NTS);
	V_OD_erg=SQLFetch(V_OD_hstmt);
// 9. 通过SQLGetData 获取并返回数据。
	int i=0;
	printf("只输出前20条数据\n");
	printf("\"CITY\"   \"SECTOR_ID\"   \"SECTOR_NAME\"     \"PCI\"\n");
	printf("------------------------------------------------------\n");
	while(V_OD_erg != SQL_NO_DATA) {
		if(i<20) {
			SQLGetData(V_OD_hstmt,1,SQL_C_CHAR,(SQLPOINTER)&data1,100,NULL);
			SQLGetData(V_OD_hstmt,2,SQL_C_CHAR,(SQLPOINTER)&data2,100,NULL);
			SQLGetData(V_OD_hstmt,3,SQL_C_CHAR,(SQLPOINTER)&data3,100,NULL);
			SQLGetData(V_OD_hstmt,4,SQL_C_CHAR,(SQLPOINTER)&data4,100,NULL);
			printf("%-9s %-13s %-20s %-8s\n",data1,data2,data3,data4 );
		}
		V_OD_erg=SQLFetch(V_OD_hstmt);
		i++;
	};
	printf("成功删除(1)插入数据，共查询到%d条数据 !\n", i);
```

实验结果如下:
![](https://cdn.jsdelivr.net/gh/Arete-FFF/DBS_examination/lab2/img/GaussDB2_04.png)


### 实验总结
    在实验过程中，首先是执行SQL语言与将SQL执行之后的输出在代码中需要分两部分解决。并且在输出过程中对数据抓取不太方便，需要每次单独调用。并且数据抓取形式类似于数组抓取，但并不能简单的角标对应。故对于四个小实验均需要分别写出输出程序。
    虽然抓取数据比较麻烦，但是通过完成接口实验，我们小组更加深刻的理解数据库，能够将代码与数据联系起来，对编写程序前后端的理解更加深刻。对之后的进一步学习更有帮助。