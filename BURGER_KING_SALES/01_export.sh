#!/bin/bash
cd /home/proyectos2/Canada/BurgerKing/datos
rm *.csv
hive -e 'set hive.cli.print.header=true; select * STG_DSD_CANADA.Burger_King_Sales' | sed 's/[\t]/|/g'  > DISTRIBUTION_SUPPLIER_PLANT.csv