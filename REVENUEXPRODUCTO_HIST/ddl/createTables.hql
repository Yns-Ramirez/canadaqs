CREATE DATABASE IF NOT EXISTS tmp_RevenueXProducto;

CREATE TABLE IF NOT EXISTS tmp_RevenueXProducto.RevenueXProducto_tmp (   
codigo_agencia STRING,    
codigo_ruta STRING,    
tipo_ruta STRING,    
fecha_venta STRING,    
numero_documento STRING,    
codigo_cliente STRING,    
codigo_producto STRING,    
cantidad_producto STRING,    
sub_total_producto STRING,    
tablenumber STRING,    
descripcion_revenue STRING,    
porcentaje_revenue STRING,    
total_revenue STRING,    
calculo_semanal STRING,    
bmusuario STRING,    
bmfechamod STRING)
ROW FORMAT DELIMITED 
 FIELDS TERMINATED BY '|'
 LINES TERMINATED BY '\n' 
STORED AS TEXTFILE;

CREATE VIEW IF NOT EXISTS tmp_RevenueXProducto.RevenueXProducto_v
AS
SELECT cast(trim(codigo_agencia) as INT) as codigo_agencia,
trim(codigo_ruta) as codigo_ruta,   
cast(trim(tipo_ruta) as INT) as tipo_ruta,
rtrim(ltrim(fecha_venta)) as fecha_venta,
rtrim(ltrim(numero_documento)) as numero_documento,
rtrim(ltrim(codigo_cliente)) as codigo_cliente,  
cast(trim(codigo_producto) as INT) as codigo_producto,  
cast(trim(cantidad_producto) as INT) as cantidad_producto,
cast(trim(sub_total_producto) as DOUBLE) as sub_total_producto,
trim(tablenumber) as tablenumber,
rtrim(ltrim(descripcion_revenue)) as descripcion_revenue,
cast(trim(porcentaje_revenue) as DOUBLE) as porcentaje_revenue,
cast(trim(total_revenue) as DOUBLE) as total_revenue,
cast(cast(trim(calculo_semanal) as INT) as BOOLEAN) as calculo_semanal,
rtrim(ltrim(bmusuario)) as bmusuario,
rtrim(ltrim(bmfechamod )) as bmfechamod,
FROM_UNIXTIME(UNIX_TIMESTAMP()) as storeday,
cast(trim(codigo_agencia) as INT) as agency
from tmp_RevenueXProducto.RevenueXProducto_tmp;

CREATE TABLE IF NOT EXISTS bccan_xprs.RevenueXProducto (   
codigo_agencia INT,    
codigo_ruta STRING,    
tipo_ruta INT,    
fecha_venta STRING,    
numero_documento STRING,    
codigo_cliente STRING,    
codigo_producto INT,    
cantidad_producto INT,    
sub_total_producto DOUBLE,    
tablenumber STRING,    
descripcion_revenue STRING,    
porcentaje_revenue DOUBLE,    
total_revenue DOUBLE,    
calculo_semanal BOOLEAN,    
bmusuario STRING,    
bmfechamod STRING,
storeday STRING)  
partitioned by  (agency INT )
STORED AS PARQUET;

truncate table tmp_RevenueXProducto.revenuexproducto_tmp;
