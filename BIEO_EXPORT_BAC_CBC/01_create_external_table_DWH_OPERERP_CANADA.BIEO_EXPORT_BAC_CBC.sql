
-- ================== CREATE DDL'S ==================
CREATE EXTERNAL TABLE IF NOT EXISTS `dwh_opererp_canada.BIEO_EXPORT_BAC_CBC`(
  `load_date` string,
  `sdate` string,
  `level1` string,
  `level2` string,
  `level3` string,
  `level4` string,
  `level5` string,
  `level6` string,
  `s_predx` double,
  `gb_bsline_fcst` double,
  `gb_fin_promo` double,
  `gb_fin_fcst` double,
  `gb_promo_feat` double,
  `gb_promo_ph` double,
  `gb_promo_loadin` double,
  `gb_promo_other` double,
  `gb_net_final_fcst` double,
  `gb_net_bs_fcst` double,
  `gb_net_final_promo` double,
  `record_type` double)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3a://devbimboaws/DEV_CANADA_IC/Data/dwh_opererp_canada/BIEO_EXPORT_BAC_CBC';


-- ================== TRANSFORMATIONS ==================

INSERT OVERWRITE TABLE dwh_opererp_canada.BIEO_EXPORT_BAC_CBC
SELECT * FROM gb_smntc_191_demantra.BIEO_EXPORT_BAC_CBC;