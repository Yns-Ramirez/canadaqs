#!/bin/bash
cd /home/proyectos2/Canada/Wendy/datos 

rm *.csv
hive -e 'set hive.cli.print.header=true; select * from APP_INTELCOMERCIAL_DM.DISTRIBUTION_SUPPLIER_PLANT' | sed 's/[\t]/|/g'  > DISTRIBUTION_SUPPLIER_PLANT.csv
hive -e 'set hive.cli.print.header=true; select * from APP_INTELCOMERCIAL_DM.DISTRIBUTOR_ACCOUNT_BT_ST' | sed 's/[\t]/|/g'  > DISTRIBUTOR_ACCOUNT_BT_ST.csv
hive -e 'set hive.cli.print.header=true; select * from APP_INTELCOMERCIAL_DM.DISTRIBUTOR_ACCOUNT_VF' | sed 's/[\t]/|/g'  > DISTRIBUTOR_ACCOUNT_VF.csv

echo "-= Finalizo la extracción"
