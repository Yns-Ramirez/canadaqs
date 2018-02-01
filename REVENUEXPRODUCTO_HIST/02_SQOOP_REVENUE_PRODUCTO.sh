
beeline -u 'jdbc:hive2://edge-01.bimbo.dev:10000/default;principal=hive/_HOST@CLOUDERA'  -e "truncate table bccan_xprs_prod.INGRESOCATEGORIAS";

# 14661  10.4.2.110	BCCAN14661
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14661 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14661' AS agency from BCCAN14661.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'


# 14662	10.4.2.110	BCCAN14662
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14662 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14662' AS agency from BCCAN14662.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'


# 14664	10.4.2.110	BCCAN14664
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14664 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14664' AS agency from BCCAN14664.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14665	10.4.2.110	BCCAN14665
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14665 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14665' AS agency from BCCAN14665.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14666	10.4.2.110	BCCAN14666
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14666 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14666' AS agency from BCCAN14666.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14667	10.4.2.110	BCCAN14667
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14667 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14667' AS agency from BCCAN14667.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14672	10.4.2.110	BCCAN14672
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.2.110:3030/BCCAN14672 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14672' AS agency from BCCAN14672.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14674	10.4.3.154	BCCAN14674
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14674 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14674' AS agency from BCCAN14674.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14675	10.4.3.154	BCCAN14675
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14675 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14675' AS agency from BCCAN14675.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14676	10.4.3.154	BCCAN14676
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14676 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14676' AS agency from BCCAN14676.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14677	10.4.3.154	BCCAN14677
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14677 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14677' AS agency from BCCAN14677.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14678	10.4.3.154	BCCAN14678
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14678 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14678' AS agency from BCCAN14678.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14681	10.4.3.154	BCCAN14681
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14681 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14681' AS agency from BCCAN14681.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14682	10.4.3.154	BCCAN14682
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14682 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14682' AS agency from BCCAN14682.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'

# 14683	10.4.3.154	BCCAN14683
sqoop import --driver com.sybase.jdbc4.jdbc.SybDriver --connect jdbc:sybase:Tds:10.4.3.154:3030/BCCAN14683 --username atl_dwh --password H4d0op01 --target-dir /user/proyectos2/ingresocategorias --delete-target-dir --query "select *,'BCCAN14683' AS agency from BCCAN14683.dbo.IngresoCategorias WHERE \$CONDITIONS" --hive-import --hive-database bccan_xprs_prod --hive-table ingresocategorias --m 1 --verbose --input-fields-terminated-by '\001' --map-column-hive timestamp=string --hive-drop-import-delims --input-lines-terminated-by '\n' --input-null-string '\\N' --input-null-non-string '\\N'
