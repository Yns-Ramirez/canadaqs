---la  tabla erp_pgbari_sz.gl_je_lines_gl esta  vacia
---LOCATION
---'hdfs://HdfsHA/user/hive/warehouse/erp_pgbari_sz.db/gl_je_lines_gl'
CREATE TABLE IF NOT EXISTS stg_dsd_canada.GL_TMA_CB
AS
SELECT      gjh.period_name,
            gjh.je_category,
            gjl.description line_description,
            cc.segment1,
            cc.segment2,
            cc.segment3,
            cc.segment4,
            cc.segment5,
            cc.segment6,
            cc.segment7,
        zeroifnull(cast(sum(gjl.accounted_dr) as float ) ) accounted_dr,
         zeroifnull(cast(sum(gjl.accounted_cr) as float) )  accounted_cr
FROM (SELECT * FROM DWH_OPERERP_GLOBAL.gl_je_headers WHERE ledger_id = 2508 ) gjh
INNER JOIN DWH_OPERERP_GLOBAL.gl_je_lines gjl ON gjh.je_header_id = gjl.je_header_id
LEFT JOIN  DWH_OPERERP_GLOBAL.gl_code_combinations cc ON gjl.code_combination_id = cc.code_combination_id
WHERE cc.chart_of_accounts_id = 50568
AND cc.segment1 = '191'
AND cc.segment2 IN( '4991','4992','4993','4994')
AND gjh.Je_category NOT IN ('IGIGBSPR')
AND gjh.period_name = 'P01-18'
AND gjl.ledger_id = 2508
AND  (gjl.accounted_dr <> 0 or gjl.accounted_cr<> 0)
AND cast(cc.code_combination_id as string) in

/*
--Liability
(
'947466'
,'947491'
,'947439'
,'947408'
,'974993'
,'974967'
,'974953'
,'974980'
,'947441'
,'947411'
,'947469'
,'947493'
,'947440'
,'947409'
,'947492'
,'947467'
,'947407'
,'947490'
,'947438'
,'947465'
,'952077'
,'947471'
,'947443'
,'952078'
,'947442'
,'947412'
,'947494'
,'947470'
,'947468'
,'952079'
,'952080'
,'947410'
,'1020526')
 */
 -- Expense
(
'977742',
'977739',
'977741',
'977740',
'947650',
'947675',
'947685',
'947662',
'952055',
'952056',
'952053',
'952054',
'1179014',
'952064',
'952061',
'952063',
'952062',
'952052',
'952050',
'952049',
'952051',
'952066',
'952068',
'952067',
'952065',
'952071',
'952072',
'952069',
'952070',
'1200600',
'977787',
'977788',
'977786',
'977789',
'952075',
'952073',
'952074',
'952076',
--new
'1245844',
'1238706',
'1241269',
'1238600',
'1244166',
'1238599',
'1241268',
'1241270'
)
GROUP BY 1,2,3,4,5,6,7,8,9,10
ORDER BY 1,2,3,4,5,6,7,8,9,10;
