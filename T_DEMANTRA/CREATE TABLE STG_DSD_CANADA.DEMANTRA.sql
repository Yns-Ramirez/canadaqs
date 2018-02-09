CREATE TABLE STG_DSD_CANADA.DEMANTRA
AS
SELECT
     TRIM(COALESCE(Interface_Date,'')),
     TRIM(COALESCE(Shipment_Date,'')),
     TRIM(COALESCE(Banner_Number,'')),
     TRIM(COALESCE(Item_Number,'')),
     TRIM(COALESCE(Org_Code,'')),
     TRIM(COALESCE(Sales_Channel,'')),
     TRIM(COALESCE(Order_Type,'')),
     TRIM(COALESCE(Actual_Quantity,'')),
     TRIM(COALESCE(Return_Quantity,''))
FROM
     (
	SELECT
	      CAST(TRIM(CASE WHEN Fin.Interface_Date LIKE '0%' THEN SUBSTR(TRIM(Fin.Interface_Date) , 2,11) ELSE Fin.Interface_Date END) AS VARCHAR(240)) AS Interface_Date
	     ,CAST(TRIM(CASE WHEN Fin.Shipment_Date LIKE '0%' THEN SUBSTR(TRIM(Fin.Shipment_Date) , 2,11) ELSE Fin.Shipment_Date END) AS VARCHAR(240)) AS Shipment_Date
	     ,CAST(Fin.Banner_Number AS VARCHAR(240)) AS Banner_Number
	     ,CAST(Fin.Item_Number AS VARCHAR(240)) AS Item_Number
	     ,CAST(Fin.Org_Code AS VARCHAR(240)) AS Org_Code
	     ,CAST(Fin.Sales_Channel AS VARCHAR(240)) AS Sales_Channel
	     ,CAST(Fin.Order_Type AS VARCHAR(240)) AS Order_Type
	     ,CAST(Fin.Actual_Quantity AS VARCHAR(240)) AS Actual_Quantity
	     ,CAST(Fin.Return_Quantity AS VARCHAR(240)) AS Return_Quantity
	FROM
	     (
	          SELECT
			      CAST(
	                         CASE
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '01'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jan-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '02'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Feb-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '03'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Mar-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '04'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Apr-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '05'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-May-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '06'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jun-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '07'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jul-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '08'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Aug-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '09'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Sep-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '10'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Oct-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '11'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Nov-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '12'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Dec-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                          END
	                AS VARCHAR(240))   AS Interface_Date
			     ,CAST(
	                         CASE
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jan-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Feb-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Mar-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Apr-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-May-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jun-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jul-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Aug-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Sep-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Oct-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Nov-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Dec-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                          END
	               AS VARCHAR(240))   AS Shipment_Date
			     ,CAST(TRIM(CAST(SUBSTR(DC.VALOR,1,7)  AS VARCHAR(20)))                            AS VARCHAR(240))   AS Banner_Number
			     ,CAST(TRIM(CAST(AGY0043.CODIGO_PRODUCTO AS CHAR(20)))                             AS VARCHAR(240))   AS Item_Number
			     ,CAST(CE.PUESTOEXP                                                                AS VARCHAR(240))   AS Org_Code
			     ,CAST(AGM042.AG42DE                                                               AS VARCHAR(240))   AS Sales_Channel
			     ,CAST(AGY0043.AG19ID                                                              AS VARCHAR(240))   AS Order_Type
			     ,CAST(SUM(CASE WHEN AGY0043.AG19ID = 'IN' THEN AGY0043.CANTIDAD ELSE NULL END)    AS VARCHAR(240))   AS Actual_Quantity
			     ,CAST(SUM(CASE WHEN AGY0043.AG19ID = 'CN' THEN AGY0043.CANTIDAD*-1 ELSE NULL END) AS VARCHAR(240))   AS Return_Quantity
			FROM
			     (
			          SELECT
			                AGY004.CODIGO_AGENCIA
			               ,AGY004.AG03FC
			               ,AGY003.CLICOD
			               ,AGY004.CODIGO_PRODUCTO
			               ,AGY004.NO_FACTURA
			               ,AGY003.AG19ID
			               ,AGY004.CANTIDAD
			               ,AGY004.FACAPA
			          FROM STG_DSD_CANADA.AGY004_HIST AGY004
			          LEFT JOIN STG_DSD_CANADA.AGY003_HIST AGY003
			                ON AGY004.CODIGO_RUTA     = AGY003.CODIGO_RUTA
			               AND AGY004.AG03FC          = AGY003.AG03FC
			               AND AGY004.CODIGO_AGENCIA  = AGY003.CODIGO_AGENCIA
			               AND AGY004.NO_FACTURA      = AGY003.NO_FACTURA
			     )AGY0043
			     LEFT JOIN STG_DSD_CANADA.ENV_ConfiguracionEnvio_HIST CE ON AGY0043.CODIGO_AGENCIA = CE.CODIGO_AGENCIA
			     LEFT JOIN (SELECT * FROM STG_DSD_CANADA.EXT_DatosCatalogo_HIST WHERE CAMPO = 'BANNER') DC ON TRIM(CAST(AGY0043.CODIGO_AGENCIA AS VARCHAR(10)))= TRIM(CAST(DC.CODIGO_AGENCIA AS VARCHAR(10))) AND TRIM(CAST(AGY0043.CLICOD AS VARCHAR(20))) = TRIM(CAST(DC.PK AS VARCHAR(20)))
			     LEFT JOIN STG_DSD_CANADA.AGM001_HIST AGM001
			          ON AGY0043.CODIGO_AGENCIA = AGM001.CODIGO_AGENCIA AND AGY0043.CLICOD = AGM001.CLICOD
			     LEFT JOIN STG_DSD_CANADA.AGM042_HIST AGM042
			         ON  AGM001.CODIGO_AGENCIA = AGM042.CODIGO_AGENCIA
			         AND AGM001.AG1CAT =  AGM042.AG1CAT
			     LEFT JOIN
			               (
			                    SELECT
			                          C.CALENDAR_DATE
			                         ,CMAX.FIRST_CALENDAR_DATE
			                    FROM SYS_CALENDAR.CALENDAR C
			                    INNER JOIN
			                              (
			                                   SELECT YEAR_OF_CALENDAR, WEEK_OF_YEAR, MIN(CALENDAR_DATE) AS FIRST_CALENDAR_DATE FROM SYS_CALENDAR.CALENDAR
			                                   GROUP BY 1,2
			                              )CMAX ON C.YEAR_OF_CALENDAR = CMAX.YEAR_OF_CALENDAR AND C.WEEK_OF_YEAR = CMAX.WEEK_OF_YEAR
			               ) DA ON AGY0043.AG03FC = DA.CALENDAR_DATE
			--     LEFT JOIN DWH_OPERERP_GLOBAL.V_CUSTOMERS C ON TRIM(CAST(AGY0043.CLICOD AS VARCHAR(100))) = TRIM(CAST(C.CUSTOMER_NAME AS VARCHAR(100)))
			WHERE Banner_Number IS NOT NULL
			AND AGY0043.AG03FC BETWEEN CURRENT_DATE-7 AND CURRENT_DATE-1
			GROUP BY 1,2,3,4,5,6,7
	)Fin

	UNION ALL

	SELECT
	      CAST(TRIM(CASE WHEN Fin.Interface_Date LIKE '0%' THEN SUBSTR(TRIM(Fin.Interface_Date) , 2,11) ELSE Fin.Interface_Date END) AS VARCHAR(240)) AS Interface_Date
	     ,CAST(TRIM(CASE WHEN Fin.Shipment_Date LIKE '0%' THEN SUBSTR(TRIM(Fin.Shipment_Date) , 2,11) ELSE Fin.Shipment_Date END) AS VARCHAR(240)) AS Shipment_Date
	     ,CAST(Fin.Banner_Number AS VARCHAR(240)) AS Banner_Number
	     ,CAST(Fin.Item_Number AS VARCHAR(240)) AS Item_Number
	     ,CAST(Fin.Org_Code AS VARCHAR(240)) AS Org_Code
	     ,CAST(Fin.Sales_Channel AS VARCHAR(240)) AS Sales_Channel
	     ,CAST(Fin.Order_Type AS VARCHAR(240)) AS Order_Type
	     ,CAST(Fin.Actual_Quantity AS VARCHAR(240)) AS Actual_Quantity
	     ,CAST(Fin.Return_Quantity AS VARCHAR(240)) AS Return_Quantity
	FROM
	     (
	          SELECT
			      CAST(
	                         CASE
	                             WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '01'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jan-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '02'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Feb-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '03'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Mar-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '04'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Apr-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '05'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-May-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '06'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jun-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '07'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jul-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '08'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Aug-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '09'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Sep-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '10'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Oct-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '11'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Nov-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '12'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Dec-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                          END
	                AS VARCHAR(240))   AS Interface_Date
			     ,CAST(
	                         CASE
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jan-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Feb-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Mar-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Apr-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-May-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jun-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jul-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Aug-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Sep-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Oct-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Nov-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Dec-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                          END
	               AS VARCHAR(240))   AS Shipment_Date
	               ,CC.Banner_Customer_ID   AS Banner_Number
	               ,FG.Product_ID           AS Item_Number
	               ,CC.DC                   AS Org_Code
	               ,CC.Channel_DS           AS Sales_Channel
	               ,'IN'                    AS Order_Type
	               ,CAST(SUM(TD.Qty_Ordered) AS INTEGER)    AS Actual_Quantity
	               ,CAST(NULL AS INTEGER)     AS Return_Quantity
	          FROM STG_DSD_CANADA.T_Demantra TD
	          INNER JOIN STG_DSD_CANADA.T_FG FG ON TRIM(TD.Product_ID) = TRIM(FG.MMACode)
	          INNER JOIN STG_DSD_CANADA.T_Combined_Customer CC ON TRIM(TD.Customer_ID) = TRIM(CC.Ship_To_Customer_ID)
	          WHERE TD.Qty_Ordered > 0
	          AND TD.DateKey NOT IN ('2016206')
	          GROUP BY 1,2,3,4,5,6,7,9

	UNION ALL

	          SELECT
			      CAST(
	                         CASE
	                             WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '01'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jan-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '02'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Feb-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '03'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Mar-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '04'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Apr-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '05'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-May-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '06'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jun-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '07'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Jul-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '08'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Aug-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '09'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Sep-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '10'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Oct-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '11'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Nov-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                              WHEN SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 6,2) = '12'
	                              THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 9,2)),'-Dec-'),SUBSTR(TRIM(CAST( TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP()))AS VARCHAR(20))), 1,4))
	                          END
	                AS VARCHAR(240))   AS Interface_Date
			     ,CAST(
	                         CASE
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jan-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Feb-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Mar-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Apr-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-May-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jun-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                              WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Jul-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Aug-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Sep-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Oct-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Nov-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
                                  WHEN SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 6,2) = '01'
                                  THEN concat(concat((SUBSTR(TRIM(CAST( TO_DATE(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))), 9,2)),'-Dec-'),SUBSTR(TRIM(CAST(TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),7))AS VARCHAR(20))),1,4))
	                          END
	               AS VARCHAR(240))   AS Shipment_Date
	               ,CC.Banner_Customer_ID   AS Banner_Number
	               ,FG.Product_ID           AS Item_Number
	               ,CC.DC                   AS Org_Code
	               ,CC.Channel_DS           AS Sales_Channel
	               ,'CN'                    AS Order_Type
	               ,CAST(NULL AS INTEGER)     AS Actual_Quantity
	               ,CAST(SUM(TD.Qty_Returned)AS INTEGER)    AS Return_Quantity
	          FROM STG_DSD_CANADA.T_Demantra TD
	          INNER JOIN STG_DSD_CANADA.T_FG FG ON TRIM(TD.Product_ID) = TRIM(FG.MMACode)
	          INNER JOIN STG_DSD_CANADA.T_Combined_Customer CC ON TRIM(TD.Customer_ID) = TRIM(CC.Ship_To_Customer_ID)
	          WHERE TD.Qty_Returned > 0
               	  AND TD.DateKey NOT IN ('2016206')
	          GROUP BY 1,2,3,4,5,6,7,8
	)Fin
     )A
WHERE Banner_Number IS NOT NULL
     AND Item_Number IS NOT NULL
     AND Org_Code IS NOT NULL
     AND Sales_Channel IS NOT NULL;
