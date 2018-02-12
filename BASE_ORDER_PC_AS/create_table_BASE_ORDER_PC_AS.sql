
drop table if exists app_canada_dm.base_order_pc_as;

CREATE table app_canada_dm.base_order_pc_as
                ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
                LINES TERMINATED BY '\n'
                STORED AS TEXTFILE
                LOCATION 's3a://devbimboaws/DEV_CANADA_IC/Data/app_canada_dm/BASE_ORDER_PC_AS'
                AS
SELECT DISTINCT concat(substr(fecha_entrega, 9, 2), '/', 
                substr(fecha_entrega, 6, 2), '/', 
                substr(fecha_entrega, 1, 4)) fecha_entrega,
                codigo_agencia,
                clicod, 
                codigo_producto,
                fecha, 
                pedido, 
                orden_compra, 
                asignacion, 
                codigo_ruta, 
                pedidobasefechamod, 
                exhibicionadicional, 
                tacticacomercial, 
                consolidaciondsd,
                cambiofisico, 
                pedidobasemodificado, 
                id_pedido, 
                id_naturaleza_operacion, 
                cantidadpedidobase, 
                ag47id,
                `timestamp`, 
                ajusteundia 
                FROM bccan_xprs.pedido_base_pc_as 
                WHERE substr(fecha_entrega, 1, 10) BETWEEN date_add(now(),-1) AND date_add(now(), 15);
                