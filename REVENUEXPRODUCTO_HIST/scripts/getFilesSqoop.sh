#/bin/bash

DB_CONN="$HOME/Canada/REVENUEXPRODUCTO_HIST/files/dbConn.txt"

if [[ -f "$DB_CONN" ]]
then

	while IFS=$'\t' read -r idAgency ipDB nameDB
	do
	rm $HOME/Canada/REVENUEXPRODUCTO_HIST/files/agencyFiles/RevenueXProducto$idAgency.txt
	sqoop eval  --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:$ipDB:3030/$nameDB --username atl_dwh --password H4d0op01 --query "select * from $nameDB.dbo.RevenueXProducto WHERE codigo_agencia =$idAgency" >> $HOME/Canada/REVENUEXPRODUCTO_HIST/files/agencyFiles/RevenueXProducto$idAgency.txt
	done < "$DB_CONN"

fi

#rm $HOME/Canada/REVENUEXPRODUCTO_HIST/files/RevenueXProducto.txt

#sqoop eval  --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14661 --username atl_dwh --password H4d0op01 --query "select * from BCCAN14661.dbo.RevenueXProducto WHERE codigo_agencia =14661 " >> $HOME/CANADA/revenueXproducto/files/RevenueXProducto.txt

