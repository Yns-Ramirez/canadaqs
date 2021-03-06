
-- ================== CREATE DDL'S ==================
CREATE EXTERNAL TABLE IF NOT EXISTS DWH_OPERERP_CANADA.BIEO_EXPORT_BAC
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
location 's3a://devbimboaws/DEV_CANADA_IC/Data/dwh_opererp_canada/BIEO_EXPORT_BAC'
AS
SELECT 
      substr(cast(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP()),6) as string),1,10) AS LOAD_DATE
     ,SDATE
     ,LEVEL1
     ,LEVEL2
     ,LEVEL3
     ,LEVEL4
     ,LEVEL5
     ,LEVEL6
     ,S_PREDX
     ,GB_BSLINE_FCST
     ,GB_FIN_PROMO
     ,GB_FIN_FCST
     ,GB_PROMO_FEAT
     ,GB_PROMO_PH
     ,GB_PROMO_LOADIN
     ,GB_PROMO_OTHER
     ,GB_NET_FINAL_FCST
     ,GB_NET_BS_FCST
     ,GB_NET_FINAL_PROMO
     ,RECORD_TYPE
 FROM gb_smntc_191_demantra.BIEO_EXPORT_BAC_CBC
 where 1!=1;


 -- ================== TRANSFORMATIONS ==================

INSERT OVERWRITE TABLE dwh_opererp_canada.BIEO_EXPORT_BAC
SELECT * FROM gb_smntc_191_demantra.BIEO_EXPORT_BAC_CBC;