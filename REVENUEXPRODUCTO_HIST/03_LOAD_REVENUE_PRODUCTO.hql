
truncate table bccan_xprs.RevenueXProducto;

insert into bccan_xprs.RevenueXProducto partition(agency)
select codigo_agencia,
codigo_ruta,   
tipo_ruta,
fecha_venta,
numero_documento,
codigo_cliente,  
codigo_producto,  
cantidad_producto,
sub_total_producto,
trim(tablenumber) as tablenumber,
descripcion_revenue,
porcentaje_revenue,
total_revenue,
calculo_semanal,
bmusuario,
bmfechamod,
storeday,
agency
from tmp_RevenueXProducto.RevenueXProducto_v;



---- This is a temporary process ----
drop table if exists STG_DSD_Canada.RevenueXProducto_HIST;

create table STG_DSD_Canada.RevenueXProducto_HIST 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/STG_DSD_Canada/RevenueXProducto_HIST'
as select * from bccan_xprs.RevenueXProducto;

