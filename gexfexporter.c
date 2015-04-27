#include<mysql.h>
#include<my_global.h>
#include<stdio.h>

int main() {
	FILE * fp = fopen("provenance.gexf","w");

	MYSQL *con = mysql_init(NULL);
	MYSQL_RES *result;
	MYSQL_ROW row;
	if(mysql_real_connect(con, "localhost", "provenance", "provenance", "provenance",0, NULL,0) == NULL) {
		printf("%s",mysql_error(con));
		mysql_close(con);
	}

	//printing header informations
	fprintf(fp, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");

	//printing gexf information
	fprintf(fp, "<gexf xmlns=\"http://www.gexf.net/1.2draft\" version=\"1.2\">\n");

	//printing graph information
	fprintf(fp, "<graph mode=\"static\" defaultedgetype=\"directed\">\n");

	//print node information
	fprintf(fp, "<nodes>\n");

	mysql_query(con, "select * from window_info;");

	result = mysql_store_result(con);
	while((row = mysql_fetch_row(result))) {
		fprintf(fp, "<node id=\"%s\" label=\"%s\" />\n", row[0], row[2]);
	}

	//end of node information
	fprintf(fp, "</nodes>\n");

	//print edge information
	fprintf(fp, "<edges>\n");
    mysql_query(con, "select * from flowmap");
    result = mysql_store_result(con);
	int i=0;
	while((row = mysql_fetch_row(result))) {
        fprintf(fp, "<edge id=\"%d\" source=\"%s\" target=\"%s\" weight=\"%s\" label=\"%s\" />\n", i, row[0], row[1], row[2], row[4]);
		i++;
    }


	//end of edge information
	fprintf(fp, "</edges>\n");

	//end of grpah information
	fprintf(fp, "</graph>\n");

	//end of gexf inforamtion
	fprintf(fp, "</gexf>");


	return 0;
}
