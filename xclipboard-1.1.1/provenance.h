/*
This header file is interface for our provence collector to the MySQL database engine.
This header file uses the utilities from mysql.h and my_global.h header files. So do
include the these files before including this file.
Written by:
	Hemant Kumar	B110142CS
	Awadhesh Kumar	B110262CS

For writng multiple queries having same selection attribute in one statement use CLIENT_MULTI_STATEMENTS in mysql_real_connection. 
*/

#define PROVENANCE_ERROR -1
#define PROVENANCE_CATASTROPHE -2

MYSQL *con;


//Initializes the database connection
int createDBConnection() {
	con = mysql_init(NULL);
	if(mysql_real_connect(con, "localhost", "provenance", "provenance", "provenance", 0, NULL, 0) == NULL) {
		printf("%s", mysql_error(con));
		return 1;
	}
}

int destroyDBConnection() {
	mysql_close(con);
}


/*Returns the database indexed unique window id for a given window and window_title pair
*/
int insertWindowInfo(int window, char * window_title, int is_to_insert) {
	char query[200];
	char db_window_title[100];
	mysql_real_escape_string(con,db_window_title, window_title, strlen(window_title));
	sprintf(query, "SELECT window_id FROM window_info WHERE window='%d' AND window_title LIKE '%s';", window, db_window_title);
	mysql_query(con, query);
	MYSQL_RES *result = mysql_store_result(con);
	MYSQL_ROW row = mysql_fetch_row(result);
	
	if(row != NULL) {
		// at this condition there MUST NOT be more than one row, if there are then we are in a great problem
		return row[0];
	}
	if(is_to_insert) {
		sprintf(query, "INSERT INTO window_info (window, window_title) VALUES ('%d','%s');", window, db_window_title);
		mysql_query(con, query);
		return mysql_insert_id(con);

	} else {
		return PROVENANCE_ERROR;
	}
}

int insertCopyInfo(int owner_id, char *data) {
	int data_len = strlen(data);
	char db_data[data_len*2];
	char query[data_len*2];

	mysql_real_escape_string(con,db_data,data,data_len);
	sprintf(query, "INSERT INTO copy_info (owner_id, data) VALUES ('%d', '%s');", owner_id, db_data);
	mysql_query(con, query);
	return mysql_insert_id(con);
}

int insertPasteInfo(int requestor_id, int data_id) {
	char query[100];
	sprintf(query, "INSERT INTO paste_info (requestor_id, data_id) VALUES ('%d', '%s');", requestor_id, data_id);
	mysql_query(con, query);
	return mysql_insert_id(con);
}
