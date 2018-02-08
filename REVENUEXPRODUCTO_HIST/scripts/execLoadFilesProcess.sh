#/bin/bash

source $HOME/Canada/Config/parametersCanada.txt
DB_CONN="$HOME/Canada/REVENUEXPRODUCTO_HIST/files/dbConn.txt"

BASE_DIR=$(dirname $0)
DDL_DIRECTORY="$BASE_DIR/../ddl/"
CREATE_OBJ="createTables.hql"
LOAD_REV_PROD="loadRevenueProduct.hql"
DIR_HQL_SQL="/home/proyectos2/Canada/REVENUEXPRODUCTO_HIST/scripts/hql_sql/"
LOAD_DATA_INPATH="load data inpath "
FILES_PATH_REV_PROD="$BASE_DIR/../files/agencyFiles"

# Create Objects
$BEELINE_URL $HQL_INIT -f $DDL_DIRECTORY$CREATE_OBJ

# Cleaning files stage 
if [[ -f "$DB_CONN"  ]]
then
	while IFS=$'\t' read -r idAgency ipDB nameDB
	do

	tail -n +4 $FILES_PATH_REV_PROD/RevenueXProducto$idAgency.txt | head -n -1 > $FILES_PATH_REV_PROD/RevenueXProductoNew$idAgency.txt && mv $FILES_PATH_REV_PROD/RevenueXProductoNew$idAgency.txt $FILES_PATH_REV_PROD/RevenueXProducto$idAgency.txt
	awk '{$1 = ""; print}' $FILES_PATH_REV_PROD/RevenueXProducto$idAgency.txt  > $FILES_PATH_REV_PROD/RevenueXProductoNew$idAgency.txt && mv $FILES_PATH_REV_PROD/RevenueXProductoNew$idAgency.txt $FILES_PATH_REV_PROD/RevenueXProducto$idAgency.txt
	hdfs dfs -rm -r -skipTrash /user/hive/warehouse/tmp/RevenueXProducto$idAgency.txt
	hdfs dfs -put $FILES_PATH_REV_PROD/RevenueXProducto$idAgency.txt /user/hive/warehouse/tmp/
	hdfs dfs -chmod 755 /user/hive/warehouse/tmp/RevenueXProducto$idAgency.txt

	$BEELINE_URL $HQL_INIT -e "$LOAD_DATA_INPATH '/user/hive/warehouse/tmp/RevenueXProducto$idAgency.txt' into table tmp_RevenueXProducto.RevenueXProducto_tmp;"

done < "$DB_CONN"

fi

#$BEELINE_URL $HQL_INIT -e "truncate table tmp_RevenueXProducto.revenuexproducto_tmp;"
#$BEELINE_URL $HQL_INIT -e "$LOAD_DATA_INPATH '/user/hive/warehouse/tmp/RevenueXProducto.txt' into table tmp_RevenueXProducto.RevenueXProducto_tmp;"

$BEELINE_URL -i $HQL_INIT -f $DIR_HQL_SQL$LOAD_REV_PROD

