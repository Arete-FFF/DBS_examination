#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <sqlext.h>
SQLHENV V_OD_Env; // Handle ODBC environment
SQLHSTMT V_OD_hstmt; // Handle statement
SQLHDBC V_OD_hdbc; // Handle connection
char typename[100];
SQLINTEGER value = 100;
SQLINTEGER V_OD_erg,V_OD_buffer,V_OD_err;
SQLCHAR data1[100],data2[100],data3[100],data4[100],data5[100],data6[100],data7[100],data8[100],data9[100],data10[100];
int main(int argc,char *argv[]) {
// 1. 申请环境句柄
	V_OD_erg = SQLAllocHandle(SQL_HANDLE_ENV,SQL_NULL_HANDLE,&V_OD_Env);
	if ((V_OD_erg != SQL_SUCCESS) && (V_OD_erg != SQL_SUCCESS_WITH_INFO)) {
		printf("Error AllocHandle\n");
		exit(0);
	}
// 2. 设置环境属性（版本信息）
	SQLSetEnvAttr(V_OD_Env, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);
// 3. 申请连接句柄
	V_OD_erg = SQLAllocHandle(SQL_HANDLE_DBC, V_OD_Env, &V_OD_hdbc);
	if ((V_OD_erg != SQL_SUCCESS) && (V_OD_erg != SQL_SUCCESS_WITH_INFO)) {
		SQLFreeHandle(SQL_HANDLE_ENV, V_OD_Env);
		exit(0);
	}
// 4. 设置连接属性
	SQLSetConnectAttr(V_OD_hdbc, SQL_ATTR_AUTOCOMMIT, SQL_AUTOCOMMIT_ON, 0);
//5. 连接数据源，这里的“gaussdb”需与之前配置数据源时的Data Source 值对应
	V_OD_erg = SQLConnect(V_OD_hdbc, (SQLCHAR*) "gaussdb", SQL_NTS,
	                      (SQLCHAR*) "", SQL_NTS, (SQLCHAR*) "", SQL_NTS);
	if ((V_OD_erg != SQL_SUCCESS) && (V_OD_erg != SQL_SUCCESS_WITH_INFO)) {
		printf("Error SQLConnect %d\n",V_OD_erg);
		SQLFreeHandle(SQL_HANDLE_ENV, V_OD_Env);
		exit(0);
	}
	printf("Connected !\n");
// 6. 设置语句属性
	SQLSetStmtAttr(V_OD_hstmt,SQL_ATTR_QUERY_TIMEOUT,(SQLPOINTER *)3,0);
// 7. 申请语句句柄
	SQLAllocHandle(SQL_HANDLE_STMT, V_OD_hdbc, &V_OD_hstmt);
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
// 10. 断开数据源连接并释放句柄资源
	SQLFreeHandle(SQL_HANDLE_STMT,V_OD_hstmt);
	SQLDisconnect(V_OD_hdbc);
	SQLFreeHandle(SQL_HANDLE_DBC,V_OD_hdbc);
	SQLFreeHandle(SQL_HANDLE_ENV, V_OD_Env);
	return(0);
}
	


