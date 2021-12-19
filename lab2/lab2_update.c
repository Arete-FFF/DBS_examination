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
// 1. ���뻷�����
	V_OD_erg = SQLAllocHandle(SQL_HANDLE_ENV,SQL_NULL_HANDLE,&V_OD_Env);
	if ((V_OD_erg != SQL_SUCCESS) && (V_OD_erg != SQL_SUCCESS_WITH_INFO)) {
		printf("Error AllocHandle\n");
		exit(0);
	}
// 2. ���û������ԣ��汾��Ϣ��
	SQLSetEnvAttr(V_OD_Env, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);
// 3. �������Ӿ��
	V_OD_erg = SQLAllocHandle(SQL_HANDLE_DBC, V_OD_Env, &V_OD_hdbc);
	if ((V_OD_erg != SQL_SUCCESS) && (V_OD_erg != SQL_SUCCESS_WITH_INFO)) {
		SQLFreeHandle(SQL_HANDLE_ENV, V_OD_Env);
		exit(0);
	}
// 4. ������������
	SQLSetConnectAttr(V_OD_hdbc, SQL_ATTR_AUTOCOMMIT, SQL_AUTOCOMMIT_ON, 0);
//5. ��������Դ������ġ�gaussdb������֮ǰ��������Դʱ��Data Source ֵ��Ӧ
	V_OD_erg = SQLConnect(V_OD_hdbc, (SQLCHAR*) "gaussdb", SQL_NTS,
	                      (SQLCHAR*) "", SQL_NTS, (SQLCHAR*) "", SQL_NTS);
	if ((V_OD_erg != SQL_SUCCESS) && (V_OD_erg != SQL_SUCCESS_WITH_INFO)) {
		printf("Error SQLConnect %d\n",V_OD_erg);
		SQLFreeHandle(SQL_HANDLE_ENV, V_OD_Env);
		exit(0);
	}
	printf("Connected !\n");
// 6. �����������
	SQLSetStmtAttr(V_OD_hstmt,SQL_ATTR_QUERY_TIMEOUT,(SQLPOINTER *)3,0);
// 7. ���������
	SQLAllocHandle(SQL_HANDLE_STMT, V_OD_hdbc, &V_OD_hstmt);
// 8. ֱ��ִ��SQL ���
	char *sqlquery6 = "update \"tbcell\" set \"EARFCN\"='12345' , \"PCI\"='32' , \"PSS\"='1' , \"SSS\"='10' , \"TAC\"='10000' where \"ENODEBID\"='000001' ";//������� 
	SQLExecDirect(V_OD_hstmt,sqlquery6,SQL_NTS);
	printf("Update Successed!\n") ;
	char *sqlquery3 = "SELECT \"CITY\", \"SECTOR_ID\",\"SECTOR_NAME\",\"ENODEBID\",\"ENODEB_NAME\",\"EARFCN\",\"PCI\",\"PSS\",\"SSS\",\"TAC\" FROM \"tbcell\" WHERE \"SECTOR_ID\" ='000001'"; //��������� 
	SQLExecDirect(V_OD_hstmt,sqlquery3,SQL_NTS);
	V_OD_erg=SQLFetch(V_OD_hstmt);
// 9. ͨ��SQLGetData ��ȡ���������ݡ�
	int i=0;
	printf("��ѯ�������:\n");
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
	printf("�������ݳɹ� !\n");
// 10. �Ͽ�����Դ���Ӳ��ͷž����Դ
	SQLFreeHandle(SQL_HANDLE_STMT,V_OD_hstmt);
	SQLDisconnect(V_OD_hdbc);
	SQLFreeHandle(SQL_HANDLE_DBC,V_OD_hdbc);
	SQLFreeHandle(SQL_HANDLE_ENV, V_OD_Env);
	return(0);
}
	


