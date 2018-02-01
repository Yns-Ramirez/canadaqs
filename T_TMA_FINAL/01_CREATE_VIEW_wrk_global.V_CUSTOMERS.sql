CREATE VIEW if not exists wrk_global.V_CUSTOMERS
AS
SELECT 
      BAN.CUSTOMERORACLE_ID
     ,BAN.CUSTOMERSAP_ID
     ,BAN.CUSTOMER_NAME
     ,BAN.ACCOUNT_NAME
     ,BAN.BANNER_CUSTOMERORACLE_ID
     ,BAN.BANNER_CUSTOMERSAP_ID
     ,BAN.BANNER_CUSTOMER_NAME
     ,REG.HIJO_ID AS REGIONAL_CUSTOMERORACLE_ID
     ,BAN.REGIONAL_CUSTOMERSAP_ID
     ,REG.HIJO_NAME AS REGIONAL_CUSTOMER_NAME
     ,NAT.HIJO_ID AS NATIONAL_CUSTOMERORACLE_ID
     ,BAN.NATIONAL_CUSTOMERSAP_ID
     ,NAT.HIJO_NAME AS NATIONAL_CUSTOMER_NAME
     ,BAN.CHANNEL_ID
     ,BAN.CUSTOMER_GROUP
     ,BAN.COUNTRY_NAME
     ,BAN.ORG_ID 
FROM 
     (
     SELECT 
           PS.PARTY_SITE_ID AS CUSTOMERORACLE_ID
          ,HCASA.ORIG_SYSTEM_REFERENCE AS CUSTOMERSAP_ID
          ,PS.PARTY_SITE_NAME AS CUSTOMER_NAME
          ,HCA.ACCOUNT_NAME AS ACCOUNT_NAME
          ,HCA.PARTY_ID AS BANNER_CUSTOMERORACLE_ID
          ,HCASA.ATTRIBUTE10 AS BANNER_CUSTOMERSAP_ID
          ,HPB.PARTY_NAME AS BANNER_CUSTOMER_NAME
          ,PS.ATTRIBUTE1 AS REGIONAL_CUSTOMERSAP_ID
          ,HPR.PARTY_NAME AS REGIONAL_CUSTOMER_NAME
          ,PS.ATTRIBUTE15 AS NATIONAL_CUSTOMERSAP_ID
          ,HPN.PARTY_NAME AS NATIONAL_CUSTOMER_NAME
          ,HCASA.ATTRIBUTE11 AS CHANNEL_ID
          ,HPB.GROUP_TYPE AS CUSTOMER_GROUP
          ,HPB.COUNTRY AS COUNTRY_NAME
          ,HCASA.ORG_ID AS ORG_ID
     FROM erp_pgbari_sz.HZ_CUST_ACCOUNTS_AR HCA
      ,erp_pgbari_sz.HZ_CUST_ACCT_SITES_ALL_AR HCASA   
      ,erp_pgbari_sz.HZ_PARTIES_AR HPB
      ,erp_pgbari_sz.HZ_PARTIES_AR HPR
      ,erp_pgbari_sz.HZ_PARTIES_AR HPN
     , erp_pgbari_sz.HZ_PARTY_SITES_AR PS
     WHERE HCA.PARTY_ID = HPB.PARTY_ID
       AND HCA.PARTY_ID = HPR.PARTY_ID
       AND HCA.PARTY_ID = HPN.PARTY_ID
       AND HCA.PARTY_ID = PS.PARTY_ID
       AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID
       AND HCASA.ORG_ID = 714
     GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
     ) BAN
          LEFT JOIN 
                    (
                         SELECT 
                               N.PAPA_ID
                              ,N.PAPA_NAME
                              ,N.RELATIONSHIP_CODE
                              ,N.HIJO_ID
                              ,N.HIJO_NAME
                              ,N.RELATIONSHIP_TYPE
                         FROM
                         (
                              SELECT 
                                    A.PARTY_ID AS PAPA_ID
                                   ,A.PARTY_NAME AS PAPA_NAME
                                   ,B.RELATIONSHIP_CODE AS RELATIONSHIP_CODE
                                   ,C.PARTY_ID AS HIJO_ID
                                   ,C.PARTY_NAME AS HIJO_NAME
                                   ,B.RELATIONSHIP_TYPE AS RELATIONSHIP_TYPE
                                   ,B.LAST_UPDATE_DATE
                              FROM erp_pgbari_sz.HZ_PARTIES_AR A
                                   INNER JOIN erp_pgbari_sz.HZ_RELATIONSHIPS_AR B ON A.PARTY_ID = B.SUBJECT_ID
                                   INNER JOIN erp_pgbari_sz.HZ_PARTIES_AR C ON B.OBJECT_ID = C.PARTY_ID
                              --WHERE B.RELATIONSHIP_TYPE = 'PARENT/SUBSIDIARY'
                              WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'
                              AND C.PARTY_NAME LIKE '%(REG)%'
                              AND B.STATUS = 'A'
                         )N
                              INNER JOIN
                                        (
                                             SELECT 
                                                   A.PARTY_ID AS PAPA_ID
                                                  ,MAX(B.LAST_UPDATE_DATE) AS LAST_UPDATE_DATE
                                             FROM erp_pgbari_sz.HZ_PARTIES_AR A
                                                  INNER JOIN erp_pgbari_sz.HZ_RELATIONSHIPS_AR B ON A.PARTY_ID = B.SUBJECT_ID
                                                  INNER JOIN erp_pgbari_sz.HZ_PARTIES_AR C ON B.OBJECT_ID = C.PARTY_ID
                                             --WHERE B.RELATIONSHIP_TYPE = 'PARENT/SUBSIDIARY'
                                             WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'
                                             AND C.PARTY_NAME LIKE '%(REG)%'
                                             AND B.STATUS = 'A'
                                             GROUP BY 1
                                        )M ON N.PAPA_ID = M.PAPA_ID AND N.LAST_UPDATE_DATE = M.LAST_UPDATE_DATE
                    ) REG ON BAN.BANNER_CUSTOMERORACLE_ID = REG.PAPA_ID
          LEFT JOIN 
                    (
                         SELECT 
                               A.PARTY_ID AS PAPA_ID
                              ,A.PARTY_NAME AS PAPA_NAME
                              ,B.RELATIONSHIP_CODE AS RELATIONSHIP_CODE
                              ,C.PARTY_ID AS HIJO_ID
                              ,C.PARTY_NAME AS HIJO_NAME
                              ,B.RELATIONSHIP_TYPE AS RELATIONSHIP_TYPE
                         FROM erp_pgbari_sz.HZ_PARTIES_AR A
                              INNER JOIN erp_pgbari_sz.HZ_RELATIONSHIPS_AR B ON A.PARTY_ID = B.SUBJECT_ID
                              INNER JOIN erp_pgbari_sz.HZ_PARTIES_AR C ON B.OBJECT_ID = C.PARTY_ID
                         --WHERE B.RELATIONSHIP_TYPE = 'PARENT/SUBSIDIARY'
                         WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'
                         AND C.PARTY_NAME LIKE '%(NAT)%'
                         AND B.STATUS = 'A'
                    ) NAT ON REG.HIJO_ID = NAT.PAPA_ID
WHERE BAN.BANNER_CUSTOMER_NAME NOT LIKE '%(NAT)%'
AND BAN.BANNER_CUSTOMER_NAME NOT LIKE '%(REG)%';