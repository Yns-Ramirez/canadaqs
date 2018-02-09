#!/bin/bash
cd /home/proyectos2/Canada/Demantra/datos

rm *.csv
hive -e 'set hive.cli.print.header=true; select * from STG_DSD_CANADA.DEMANTRA' | sed 's/[\t]/|/g'  > DISTRIBUTION_SUPPLIER_PLANT.csv
echo "-= Finalizo la extracción"
