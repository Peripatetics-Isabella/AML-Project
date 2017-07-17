%%Queries for the Risk Model%
%Each 8 below query was saved as a subtables and then joined together for the last table%
%Use Case 1.0%
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Refund', 1, 0))/SUM(IF(MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0)) AS perc
FROM (
SELECT
ACCOUNTID,
USE_CASE,
TRANSACTION_TYPE,
MERCHANT_CATEGORY_DESC,
ROWNUM
FROM
dsathaye_cust_data.cc_trans )
GROUP BY
ACCOUNTID

%Use Case 1.1%
SELECT
ACCOUNTID,
SUM(IF(BALANCE > CREDIT_LIMIT
AND MERCHANT_CATEGORY_CODE = '1111'
AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111'
AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID

%Use Case 2%
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'Wire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment', 1, 0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111', 1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID

#SELECT *, 1 as HIGH_RISK FROM combined_test_set.cc_trans where ACCOUNTID IN (SELECT ACCOUNTID FROM combined_test_set.TOP_529) ORDER BY
#  ACCOUNTID, TRANSACTION_DATE limit 10000
  
#  SELECT *, 0 as HIGH_RISK FROM combined_test_set.cc_trans where ACCOUNTID NOT IN (SELECT ACCOUNTID FROM combined_test_set.TOP_529) ORDER BY
#  ACCOUNTID, TRANSACTION_DATE limit 10000

%Use Case 3%
SELECT
ACCOUNTID,
SUM(IF((TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Wire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'e-Check'
OR TRANSACTION_TYPE = 'Paper Check'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check')
AND (MERCHANT_CATEGORY_DESC = 'Non Customer Payment')
AND (MERCHANT_CATEGORY_CODE == '2222'), 1, 0))/SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Wire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'e-Check'
OR TRANSACTION_TYPE = 'Paper Check'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check', 1, 0)) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID

#SELECT *, 1 as HIGH_RISK FROM combined_test_set.cc_trans where ACCOUNTID IN (SELECT ACCOUNTID FROM combined_test_set.TOP_529) ORDER BY
#  ACCOUNTID, TRANSACTION_DATE limit 10000
  
#  SELECT *, 0 as HIGH_RISK FROM combined_test_set.cc_trans where ACCOUNTID NOT IN (SELECT ACCOUNTID FROM combined_test_set.TOP_529) ORDER BY
#  ACCOUNTID, TRANSACTION_DATE limit 10000

%Use Case 4%
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'ATM Payment'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check'
AND ((MERCHANT_COUNTRY = 'MX'
AND CUST_STATE IN ('CA',
'AZ',
'NM',
'TX'))
OR (MERCHANT_COUNTRY = 'CA'
AND CUST_STATE IN ('AL',
'WA',
'ID',
'MT',
'ND',
'MN',
'OH',
'PA',
'NY',
'VT',
'NH',
'ME' ))
OR MERCHANT_COUNTRY <> CUST_COUNTRY), 1, 0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111',1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID

%Use Case 5%
SELECT ACCOUNTid, Value_perc, Tran_perc, FROM (SELECT Total.ACCOUNTID AS ACCOUNTID, High_Risk.HR_value/Total.Total_value AS Value_perc,High_Risk.HR_tran/Total.Total_tran AS Tran_perc FROM
(SELECT ACCOUNTID, SUM(AMOUNT) AS Total_value, COUNT(ACCOUNTID) AS Total_tran
FROM dsathaye_cust_data.cc_trans
GROUP BY ACCOUNTID) Total
INNER JOIN
(SELECT ACCOUNTID,SUM(AMOUNT) AS HR_value, COUNT(ACCOUNTID) AS HR_tran
FROM dsathaye_cust_data.cc_trans WHERE MERCHANT_COUNTRY IN
(
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red')
GROUP BY ACCOUNTID)AS High_Risk
ON Total.ACCOUNTID = High_Risk.ACCOUNTID), (SELECT UNIQUE(ACCOUNTID), 0 as Value_perc, 0 as Tran_perc FROM dsathaye_cust_data.cc_trans WHERE MERCHANT_COUNTRY NOT IN
(
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red'))

%Use Case 6%
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as Count_Perc,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as Amount_perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID

%Use Case 8%
SELECT ACCOUNTID, Value_perc, Trans_perc FROM (SELECT Total.ACCOUNTID AS ACCOUNTID, High_Risk.HR_value/Total.Total_value AS Value_perc,High_Risk.HR_tran/Total.Total_tran AS Trans_perc FROM
(SELECT ACCOUNTID, SUM(AMOUNT) AS Total_value, COUNT(ACCOUNTID) AS Total_tran
FROM dsathaye_cust_data.cc_trans
GROUP BY ACCOUNTID) Total
INNER JOIN
(SELECT ACCOUNTID,SUM(AMOUNT) AS HR_value, COUNT(ACCOUNTID) AS HR_tran
FROM dsathaye_cust_data.cc_trans WHERE MERCHANT_COUNTRY IN
(
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red')
GROUP BY ACCOUNTID)AS High_Risk
ON Total.ACCOUNTID = High_Risk.ACCOUNTID),(
  SELECT
    ACCOUNTID,
    0 AS Value_perc,
    0 AS Trans_perc
  FROM
    combined_test_set.uber_cust
  WHERE
    ACCOUNTID NOT IN (
    SELECT
      ID
    FROM
      combined_test_set.partial_5))

%Use Case 12%

SELECT
ACCOUNTID,
SUM(IF(MERCHANT_COUNTRY != 'US',1,0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID

%Join tables to create a Pct table to be fed into the logistic/random forest%
SELECT
  UseCase110Pct.ACCOUNTID as ACCOUNTID, UseCase110Pct.perc as USE_CASE_110perc, UseCase111Pct.perc as USE_CASE_111perc, UseCase2Pct.perc as USE_CASE_2perc, 
UseCase3Pct.perc as USE_CASE_3perc,
UseCase4Pct.perc as USE_CASE_4perc, UseCase5Pct.Value_perc as USE_CASE5Value_perc, UseCase5Pct.Trans_perc as USE_CASE5Trans_perc,
UseCase6Pct.Amount_perc as USE_CASE6Count_perc, UseCase6Pct.Amount_perc as USE_CASE6Amount_perc, UseCase8Pct.total as USE_CASE_8perc, UseCase12Pct.perc as USE_CASE_12perc,
FROM
  combined_test_set.UseCase110Pct as UseCase110Pct
JOIN
  combined_test_set.UseCase111Pct as UseCase111Pct
ON
  UseCase110Pct.ACCOUNTID == UseCase111Pct.ACCOUNTID
JOIN
  combined_test_set.UseCase2Pct as UseCase2Pct
ON
  UseCase110Pct.ACCOUNTID = UseCase2Pct.ACCOUNTID
JOIN
  combined_test_set.UseCase3Pct as UseCase3Pct
ON
  UseCase110Pct.ACCOUNTID = UseCase3Pct.ACCOUNTID
JOIN
  combined_test_set.UseCase4Pct as UseCase4Pct
ON
  UseCase110Pct.ACCOUNTID = UseCase4Pct.ACCOUNTID
JOIN 
 combined_test_set.UseCase5Pct as UseCase5Pct
ON
  UseCase5Pct.ACCOUNTID = UseCase110Pct.ACCOUNTID
JOIN
 combined_test_set.UseCase6Pct as UseCase6Pct
ON
  UseCase6Pct.ACCOUNTID = UseCase110Pct.ACCOUNTID
JOIN
 combined_test_set.UseCase8Pct as UseCase8Pct
ON
  UseCase8Pct.ACCOUNTID = UseCase110Pct.ACCOUNTID
JOIN 
 combined_test_set.UseCase12Pct as UseCase12Pct
ON
  UseCase12Pct.ACCOUNTID = UseCase110Pct.ACCOUNTID