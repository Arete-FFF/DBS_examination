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
SQLCHAR data1[100],data2[100],data3[100];
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
// 10. 断开数据源连接并释放句柄资源
	SQLFreeHandle(SQL_HANDLE_STMT,V_OD_hstmt);
	SQLDisconnect(V_OD_hdbc);
	SQLFreeHandle(SQL_HANDLE_DBC,V_OD_hdbc);
	SQLFreeHandle(SQL_HANDLE_ENV, V_OD_Env);
	return(0);
}
