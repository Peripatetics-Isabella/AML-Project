
#QA across entire dataset
#Create UseCase10 table after running below query:

SELECT ACCOUNTID, QA as USE_CASE_10 FROM (SELECT
ACCOUNTID,
'Green' as QA
FROM (
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
ORDER BY
perc DESC)
WHERE
perc <= .3), (SELECT
ACCOUNTID,
'Yellow' as QA
FROM (
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
ORDER BY
perc DESC)
WHERE
perc > .3 and perc <= .7), (SELECT
ACCOUNTID,
'Red' as QA
FROM (
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
ORDER BY
perc DESC)
WHERE
perc > .7)


#Create UseCase11 table after running below query:
SELECT ACCOUNTID, QA as USE_CASE_11 FROM (SELECT
ACCOUNTID,
'Green' AS QA
FROM (
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
ACCOUNTID)
WHERE
perc <=0.25), (SELECT
ACCOUNTID,
'Yellow' AS QA
FROM (
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
ACCOUNTID)
WHERE
perc >0.25 and perc <= .5), (SELECT
ACCOUNTID,
'Use Case 1.1 - Red' AS QA
FROM (
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
ACCOUNTID)
WHERE
perc >0.5)


#Create UseCase2 table after running below query:
SELECT ACCOUNTID, QA as USE_CASE_2 FROM (SELECT
ACCOUNTID,
'Green' as QA
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'Wire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment', 1, 0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111', 1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) AS q
WHERE
perc <= .3), (
SELECT
ACCOUNTID,
'Red' as QA
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'Wire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment', 1, 0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111', 1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) AS q
WHERE
perc > .5), (SELECT
ACCOUNTID,
'Yellow' as QA
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'Wire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment', 1, 0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111', 1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) AS q
WHERE
perc <= .5 and perc > .3)


#Create UseCase3 table after running below query:
SELECT ACCOUNTID, QA as USE_CASE_3 FROM (SELECT
ACCOUNTID, 'Red' as QA
FROM (
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
ACCOUNTID ) AS q
WHERE
q.perc > .4), (SELECT
ACCOUNTID, 'Green' as QA
FROM (
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
ACCOUNTID ) AS q
WHERE
q.perc <= .25), (SELECT
ACCOUNTID, 'Yellow' as QA
FROM (
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
ACCOUNTID ) AS q
WHERE
q.perc <= .4 and q.perc > .25)


#Create UseCase4 table after running below query:
SELECT ACCOUNTID, QA as USE_CASE_4 FROM (SELECT
ACCOUNTID,
'Green' as QA
FROM (
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
ACCOUNTID)
WHERE
perc <= .3), (SELECT
ACCOUNTID,
'Yellow' as QA
FROM (
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
ACCOUNTID)
WHERE
perc > .3 and perc <= .5), (SELECT
ACCOUNTID,
'Red' as QA
FROM (
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
ACCOUNTID)
WHERE
perc > .5)


#Create UseCase5 table after running below query:
SELECT
ACCOUNTID,
QA AS USE_CASE_5
FROM (
SELECT
UNIQUE(ACCOUNTID) AS ACCOUNTID,
'Green' AS QA
FROM
dsathaye_cust_data.cc_trans
WHERE
ACCOUNTID NOT IN (
SELECT
ACCOUNTID
FROM ((
SELECT
ACCOUNTID,
'Yellow' AS QA
FROM (
SELECT
Total.ACCOUNTID AS ACCOUNTID,
High_Risk.HR_value/Total.Total_value AS Value_perc,
High_Risk.HR_tran/Total.Total_tran AS Tran_perc
FROM (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS Total_value,
COUNT(ACCOUNTID) AS Total_tran
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) Total
INNER JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS HR_value,
COUNT(ACCOUNTID) AS HR_tran
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY IN (
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Yellow')
GROUP BY
ACCOUNTID)AS High_Risk
ON
Total.ACCOUNTID = High_Risk.ACCOUNTID)
WHERE
((Value_perc<= 0.1
AND Value_perc > .0025)
OR (Tran_perc>.0025
AND Tran_perc <= 0.1))
AND ACCOUNTID NOT IN (
SELECT
ACCOUNTID
FROM (
SELECT
Total.ACCOUNTID AS ACCOUNTID,
High_Risk.HR_value/Total.Total_value AS Value_perc,
High_Risk.HR_tran/Total.Total_tran AS Tran_perc
FROM (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS Total_value,
COUNT(ACCOUNTID) AS Total_tran
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) Total
INNER JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS HR_value,
COUNT(ACCOUNTID) AS HR_tran
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY IN (
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red')
GROUP BY
ACCOUNTID)AS High_Risk
ON
Total.ACCOUNTID = High_Risk.ACCOUNTID)
WHERE
Value_perc>0.1
OR Tran_perc>0.1 )) ),
(
SELECT
ACCOUNTID,
'Red' AS QA
FROM (
SELECT
Total.ACCOUNTID AS ACCOUNTID,
High_Risk.HR_value/Total.Total_value AS Value_perc,
High_Risk.HR_tran/Total.Total_tran AS Tran_perc
FROM (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS Total_value,
COUNT(ACCOUNTID) AS Total_tran
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) Total
INNER JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS HR_value,
COUNT(ACCOUNTID) AS HR_tran
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY IN (
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red')
GROUP BY
ACCOUNTID)AS High_Risk
ON
Total.ACCOUNTID = High_Risk.ACCOUNTID)
WHERE
Value_perc>0.1
OR Tran_perc>0.1 ) )),
(
SELECT
ACCOUNTID,
'Red' AS QA
FROM (
SELECT
Total.ACCOUNTID AS ACCOUNTID,
High_Risk.HR_value/Total.Total_value AS Value_perc,
High_Risk.HR_tran/Total.Total_tran AS Tran_perc
FROM (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS Total_value,
COUNT(ACCOUNTID) AS Total_tran
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) Total
INNER JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS HR_value,
COUNT(ACCOUNTID) AS HR_tran
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY IN (
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red')
GROUP BY
ACCOUNTID)AS High_Risk
ON
Total.ACCOUNTID = High_Risk.ACCOUNTID)
WHERE
Value_perc>0.1
OR Tran_perc>0.1 ),
((
SELECT
ACCOUNTID,
'Yellow' AS QA
FROM (
SELECT
Total.ACCOUNTID AS ACCOUNTID,
High_Risk.HR_value/Total.Total_value AS Value_perc,
High_Risk.HR_tran/Total.Total_tran AS Tran_perc
FROM (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS Total_value,
COUNT(ACCOUNTID) AS Total_tran
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) Total
INNER JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS HR_value,
COUNT(ACCOUNTID) AS HR_tran
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY IN (
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Yellow')
GROUP BY
ACCOUNTID)AS High_Risk
ON
Total.ACCOUNTID = High_Risk.ACCOUNTID)
WHERE
((Value_perc<= .1
AND Value_perc > .0025)
OR (Tran_perc>.0025
AND Tran_perc <= 0.1))
AND ACCOUNTID NOT IN (
SELECT
ACCOUNTID
FROM (
SELECT
Total.ACCOUNTID AS ACCOUNTID,
High_Risk.HR_value/Total.Total_value AS Value_perc,
High_Risk.HR_tran/Total.Total_tran AS Tran_perc
FROM (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS Total_value,
COUNT(ACCOUNTID) AS Total_tran
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID) Total
INNER JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS HR_value,
COUNT(ACCOUNTID) AS HR_tran
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY IN (
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red')
GROUP BY
ACCOUNTID)AS High_Risk
ON
Total.ACCOUNTID = High_Risk.ACCOUNTID)
WHERE
Value_perc>0.1
OR Tran_perc>0.1 )) )


#Create UseCase6 table after running below query:
SELECT ACCOUNTID, QA as USE_CASE_6 FROM (SELECT ACCOUNTID, 'Yellow' as QA FROM (SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as percC,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as percS
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID
) WHERE ((percC <= .2 and percC > .1) OR (percS <= .2 AND percS > .1)) AND ACCOUNTID NOT IN (SELECT ACCOUNTID FROM (SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as percC,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as percS
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID
) WHERE (percC > .2 OR percS > .2 ))),
(SELECT UNIQUE(ACCOUNTID) as ACCOUNTID, 'Green' as QA FROM dsathaye_cust_data.cc_trans where ACCOUNTID NOT IN (SELECT ACCOUNTID FROM (SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as percC,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as percS
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID
) WHERE (percC > .1) OR (percS > .1))), 
(SELECT ACCOUNTID, 'Red' as QA FROM (SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as percC,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as percS
FROM
dsathaye_cust_data.cc_trans
GROUP BY
ACCOUNTID
) WHERE (percC > .2 OR percS > .2 )
)


#Create UseCase7 table after running below query:
SELECT ID, USE_CASE_7
FROM
(SELECT ACCOUNTID AS ID, "Red" AS USE_CASE_7
FROM
(SELECT ACCOUNTID,TRANSACTION_DATE,COUNT(UNIQUE(MERCHANT_COUNTRY)) AS LOCATIONS

FROM (dsathaye_cust_data.cc_trans)
WHERE TRANSACTION_TYPE="Cash Advance - ATM" OR TRANSACTION_TYPE = "Purchase"
GROUP BY ACCOUNTID,TRANSACTION_DATE
ORDER BY ACCOUNTID,TRANSACTION_DATE)
WHERE LOCATIONS >= 2),

(SELECT ID,USE_CASE_7,NUM_OF_MONTH
FROM
(SELECT ID,"Red" AS USE_CASE_7, NUM_OF_MONTH
FROM
(SELECT A.ACCOUNTID AS ID, A.NUM_OF_ML/B.TOTAL_TRANS AS TRHA,A.VALUE_OF_ML/B.TOTAL_VALUE AS TRHB,B.LENGTH_OF_TRANS AS NUM_OF_MONTH
FROM
(SELECT * FROM
(SELECT ACCOUNTID, COUNT(ACCOUNTID) AS NUM_OF_ML, SUM(AMOUNT) AS VALUE_OF_ML
FROM dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY != "US" AND
TRANSACTION_TYPE = "Cash Advance - ATM" OR TRANSACTION_TYPE ="Purchase"
GROUP BY ACCOUNTID
ORDER BY ACCOUNTID) A
JOIN 
(SELECT ACCOUNTID,COUNT(ACCOUNTID) AS TOTAL_TRANS,SUM(AMOUNT) AS TOTAL_VALUE, (YEAR(MAX(TRANSACTION_DATE))-YEAR(MIN(TRANSACTION_DATE)))*12+MONTH(MAX(TRANSACTION_DATE))-MONTH(MIN(TRANSACTION_DATE)) AS LENGTH_OF_TRANS
FROM dsathaye_cust_data.cc_trans
GROUP BY ACCOUNTID) B
ON A.ACCOUNTID = B.ACCOUNTID))
WHERE TRHA >=0.5 OR TRHB >=0.5),

(SELECT ID,"Yellow" AS USE_CASE_7, NUM_OF_MONTH
FROM
(SELECT C.ACCOUNTID AS ID, C.NUM_OF_ML/D.TOTAL_TRANS AS TRHA,C.VALUE_OF_ML/D.TOTAL_VALUE AS TRHB,D.LENGTH_OF_TRANS AS NUM_OF_MONTH
FROM
(SELECT * FROM
(SELECT ACCOUNTID, COUNT(ACCOUNTID) AS NUM_OF_ML, SUM(AMOUNT) AS VALUE_OF_ML
FROM dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY != "US" AND
TRANSACTION_TYPE = "Cash Advance - ATM" OR TRANSACTION_TYPE ="Purchase"
GROUP BY ACCOUNTID
ORDER BY ACCOUNTID) C
JOIN 
(SELECT ACCOUNTID,COUNT(ACCOUNTID) AS TOTAL_TRANS,SUM(AMOUNT) AS TOTAL_VALUE, (YEAR(MAX(TRANSACTION_DATE))-YEAR(MIN(TRANSACTION_DATE)))*12+MONTH(MAX(TRANSACTION_DATE))-MONTH(MIN(TRANSACTION_DATE)) AS LENGTH_OF_TRANS
FROM dsathaye_cust_data.cc_trans
GROUP BY ACCOUNTID) D
ON C.ACCOUNTID = D.ACCOUNTID))
WHERE (TRHA<0.5 AND TRHB<0.5 AND (TRHA>=0.3 OR TRHB>=0.3))),

(SELECT ID,"Green" AS USE_CASE_7, NUM_OF_MONTH
FROM
(SELECT E.ACCOUNTID AS ID, E.NUM_OF_ML/F.TOTAL_TRANS AS TRHA,E.VALUE_OF_ML/F.TOTAL_VALUE AS TRHB,F.LENGTH_OF_TRANS AS NUM_OF_MONTH
FROM
(SELECT * FROM
(SELECT ACCOUNTID, COUNT(ACCOUNTID) AS NUM_OF_ML, SUM(AMOUNT) AS VALUE_OF_ML
FROM dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY != "US" AND
TRANSACTION_TYPE = "Cash Advance - ATM" OR TRANSACTION_TYPE ="Purchase"
GROUP BY ACCOUNTID
ORDER BY ACCOUNTID) E
JOIN 
(SELECT ACCOUNTID,COUNT(ACCOUNTID) AS TOTAL_TRANS,SUM(AMOUNT) AS TOTAL_VALUE, (YEAR(MAX(TRANSACTION_DATE))-YEAR(MIN(TRANSACTION_DATE)))*12+MONTH(MAX(TRANSACTION_DATE))-MONTH(MIN(TRANSACTION_DATE)) AS LENGTH_OF_TRANS
FROM dsathaye_cust_data.cc_trans
GROUP BY ACCOUNTID) F
ON E.ACCOUNTID = F.ACCOUNTID))
WHERE TRHA<0.3 AND TRHB<0.3),
ORDER BY ID)


#Create UseCase8 table after running below query:
SELECT ACCOUNTID, QA FROM (SELECT
ACCOUNTID, 'Red' as QA
FROM (
SELECT
ACCOUNTID,
SUM(IF(totalMerch > restTrxn,1,0)) AS total
FROM (
SELECT
q.ACCOUNTID,
q.MERCHANT_NAME,
SUM(q.merchTrxn) AS totalMerch,
SUM(q.totalTrxn) AS restTrxn
FROM (
SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit', 1, 0)) AS totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_NAME != ''
GROUP BY
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE) AS q
GROUP BY
q.ACCOUNTID,
q.MERCHANT_NAME )
GROUP BY
ACCOUNTID)
WHERE
total >= 3),

(SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID,
SUM(IF(totalMerch > restTrxn,1,0)) AS total
FROM (
SELECT
q.ACCOUNTID,
q.MERCHANT_NAME,
SUM(q.merchTrxn) AS totalMerch,
SUM(q.totalTrxn) AS restTrxn
FROM (
SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit', 1, 0)) AS totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_NAME != ''
GROUP BY
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE) AS q
GROUP BY
q.ACCOUNTID,
q.MERCHANT_NAME )
GROUP BY
ACCOUNTID)
WHERE
(total == 2 OR total == 1)), 

(SELECT UNIQUE(ACCOUNTID) as ACCOUNTID, 'Green' as QA FROM dsathaye_cust_data.cc_trans WHERE ACCOUNTID NOT IN (SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID,
SUM(IF(totalMerch > restTrxn,1,0)) AS total
FROM (
SELECT
q.ACCOUNTID,
q.MERCHANT_NAME,
SUM(q.merchTrxn) AS totalMerch,
SUM(q.totalTrxn) AS restTrxn
FROM (
SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit', 1, 0)) AS totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_NAME != ''
GROUP BY
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE) AS q
GROUP BY
q.ACCOUNTID,
q.MERCHANT_NAME )
GROUP BY
ACCOUNTID)
WHERE
(total >=1)))


#Create UseCase9 table after running below query:
SELECT ACCOUNTID, QA as USE_CASE_9 FROM (SELECT ACCOUNTID, 'Red' as QA FROM
(SELECT ACCOUNTID
FROM (SELECT Table1.ACCOUNTID, COUNT(Table1.ACCOUNTID)/2 AS times1
FROM (SELECT ACCOUNTID, CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkin:\s(.*?);') AS DATE) AS
checkin_date,
CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkout:\s(.*?);') AS DATE) AS checkout_date,
REGEXP_EXTRACT(TRANS_DETAIL, r'Hotel:\s(.*?);') AS Hotel_name
FROM(SELECT ACCOUNTID, TRANS_DETAIL,MERCHANT_CATEGORY_DESC, USE_CASE,
MERCHANT_NAME
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts')) AS Table1
JOIN
(SELECT ACCOUNTID, CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkin:\s(.*?);') AS DATE) AS
checkin_date,
CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkout:\s(.*?);') AS DATE) AS checkout_date,
REGEXP_EXTRACT(TRANS_DETAIL, r'Hotel:\s(.*?);') AS Hotel_name
FROM(SELECT ACCOUNTID, TRANS_DETAIL,MERCHANT_CATEGORY_DESC, USE_CASE,
MERCHANT_NAME
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts')) AS Table2
ON Table1.ACCOUNTID = Table2.ACCOUNTID
WHERE (Table1.checkin_date <= Table2.checkin_date AND Table1.checkout_date <
Table2.checkout_date AND Table1.checkout_date>Table2.checkin_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkout_date < Table2.checkout_date
AND Table1.checkout_date>Table2.checkin_date)
OR (Table1.checkin_date < Table2.checkin_date AND Table1.checkout_date = Table2.checkout_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkout_date = Table2.checkout_date)
OR (Table1.checkin_date <= Table2.checkin_date AND Table1.checkout_date > Table2.checkout_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkin_date <Table2.checkout_date AND
Table1.checkout_date > Table2.checkout_date)
GROUP BY Table1.ACCOUNTID
ORDER BY times1)
WHERE times1>=2),
(SELECT ACCOUNTID
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts' AND TRANSACTION_TYPE = 'Refund'
GROUP BY ACCOUNTID)
GROUP BY ACCOUNTID), 
(SELECT ACCOUNTID, 'Yellow' as QA FROM
(SELECT ACCOUNTID
FROM (SELECT Table1.ACCOUNTID, COUNT(Table1.ACCOUNTID)/2 AS times1
FROM (SELECT ACCOUNTID, CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkin:\s(.*?);') AS DATE) AS
checkin_date,
CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkout:\s(.*?);') AS DATE) AS checkout_date,
REGEXP_EXTRACT(TRANS_DETAIL, r'Hotel:\s(.*?);') AS Hotel_name
FROM(SELECT ACCOUNTID, TRANS_DETAIL,MERCHANT_CATEGORY_DESC, USE_CASE,
MERCHANT_NAME
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts')) AS Table1
JOIN
(SELECT ACCOUNTID, CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkin:\s(.*?);') AS DATE) AS
checkin_date,
CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkout:\s(.*?);') AS DATE) AS checkout_date,
REGEXP_EXTRACT(TRANS_DETAIL, r'Hotel:\s(.*?);') AS Hotel_name
FROM(SELECT ACCOUNTID, TRANS_DETAIL,MERCHANT_CATEGORY_DESC, USE_CASE,
MERCHANT_NAME
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts')) AS Table2
ON Table1.ACCOUNTID = Table2.ACCOUNTID
WHERE (Table1.checkin_date <= Table2.checkin_date AND Table1.checkout_date <
Table2.checkout_date AND Table1.checkout_date>Table2.checkin_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkout_date < Table2.checkout_date
AND Table1.checkout_date>Table2.checkin_date)
OR (Table1.checkin_date < Table2.checkin_date AND Table1.checkout_date = Table2.checkout_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkout_date = Table2.checkout_date)
OR (Table1.checkin_date <= Table2.checkin_date AND Table1.checkout_date > Table2.checkout_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkin_date <Table2.checkout_date AND
Table1.checkout_date > Table2.checkout_date)
GROUP BY Table1.ACCOUNTID
ORDER BY times1)
WHERE times1 == 1) WHERE ACCOUNTID NOT IN (SELECT ACCOUNTID
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts' AND TRANSACTION_TYPE = 'Refund'
GROUP BY ACCOUNTID) GROUP BY ACCOUNTID),(SELECT UNIQUE(ACCOUNTID) as ACCOUNTID, 'Green' as QA FROM dsathaye_cust_data.cc_trans where ACCOUNTID NOT IN 
(SELECT ACCOUNTID FROM
(
SELECT ACCOUNTID
FROM (SELECT Table1.ACCOUNTID, COUNT(Table1.ACCOUNTID)/2 AS times1
FROM (SELECT ACCOUNTID, CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkin:\s(.*?);') AS DATE) AS
checkin_date,
CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkout:\s(.*?);') AS DATE) AS checkout_date,
REGEXP_EXTRACT(TRANS_DETAIL, r'Hotel:\s(.*?);') AS Hotel_name
FROM(SELECT ACCOUNTID, TRANS_DETAIL,MERCHANT_CATEGORY_DESC, USE_CASE,
MERCHANT_NAME
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts')) AS Table1
JOIN
(SELECT ACCOUNTID, CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkin:\s(.*?);') AS DATE) AS
checkin_date,
CAST(REGEXP_EXTRACT(TRANS_DETAIL,r'Checkout:\s(.*?);') AS DATE) AS checkout_date,
REGEXP_EXTRACT(TRANS_DETAIL, r'Hotel:\s(.*?);') AS Hotel_name
FROM(SELECT ACCOUNTID, TRANS_DETAIL,MERCHANT_CATEGORY_DESC, USE_CASE,
MERCHANT_NAME
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts')) AS Table2
ON Table1.ACCOUNTID = Table2.ACCOUNTID
WHERE (Table1.checkin_date <= Table2.checkin_date AND Table1.checkout_date <
Table2.checkout_date AND Table1.checkout_date>Table2.checkin_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkout_date < Table2.checkout_date
AND Table1.checkout_date>Table2.checkin_date)
OR (Table1.checkin_date < Table2.checkin_date AND Table1.checkout_date = Table2.checkout_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkout_date = Table2.checkout_date)
OR (Table1.checkin_date <= Table2.checkin_date AND Table1.checkout_date > Table2.checkout_date)
OR (Table1.checkin_date > Table2.checkin_date AND Table1.checkin_date <Table2.checkout_date AND
Table1.checkout_date > Table2.checkout_date)
GROUP BY Table1.ACCOUNTID
ORDER BY times1)
WHERE times1 >= 1),(SELECT ACCOUNTID
FROM dsathaye_cust_data.cc_trans
WHERE MERCHANT_CATEGORY_DESC =
'Hotels/Motels/Inns/Resorts' AND TRANSACTION_TYPE = 'Refund'
)) )



#Create UseCase10 table after running below query:
SELECT ACCOUNTID FROM (SELECT UNIQUE(ACCOUNTID) as ACCOUNTID, 'Green' as QA from dsathaye_cust_data.cc_trans WHERE ACCOUNTID NOT IN (SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID,
MAX(wj) AS maxPerAccountId
FROM (
SELECT
ACCOUNTID,
DateBooked,
COUNT(1) OVER (PARTITION BY ACCOUNTID ORDER BY DateBooked RANGE BETWEEN CURRENT ROW AND 30 FOLLOWING) AS wj
FROM (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') AS DATE) AS DateBooked,
DATE_ADD(CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') AS DATE), 30, 'DAY') AS DateBookedMonth,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked,
FROM
dsathaye_cust_data.cc_trans
WHERE
// USE_CASE = 'Use Case 10 - Yellow'
MERCHANT_CATEGORY_DESC = 'Airlines') AS parsedateDetail
WHERE
CUST_NAME <> NameBooked ) AS wjAccountId
GROUP BY
ACCOUNTID ) AS maxWJ
WHERE
maxWJ.maxPerAccountId > 1) AND ACCOUNTID NOT IN
(SELECT ACCOUNTID FROM (SELECT ACCOUNTID, sum(IF(totalMerch > restTrxn,1,0)) as total FROM( SELECT q.ACCOUNTID, q.MERCHANT_NAME, sum(q.merchTrxn) as totalMerch, sum(q.totalTrxn) as restTrxn
FROM
( SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit' OR TRANSACTION_TYPE == 'Refund', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit' AND TRANSACTION_TYPE != 'Refund', 1, 0)) AS totalTrxn,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked,
CUST_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
//USE_CASE = 'Use Case 10 - Red' AND
MERCHANT_CATEGORY_DESC = 'Airlines'
GROUP BY
ACCOUNTID,
MERCHANT_NAME, NameBooked, CUST_NAME,
TRANSACTION_TYPE ) as q WHERE q.CUST_NAME <> q. NameBooked GROUP BY q.ACCOUNTID, q.MERCHANT_NAME ) GROUP BY ACCOUNTID) WHERE total != 0 GROUP BY ACCOUNTID )),
(SELECT
ACCOUNTID,
'Yellow' as QA
FROM (
SELECT
ACCOUNTID,
MAX(wj) AS maxPerAccountId
FROM (
SELECT
ACCOUNTID,
DateBooked,
COUNT(1) OVER (PARTITION BY ACCOUNTID ORDER BY DateBooked RANGE BETWEEN CURRENT ROW AND 30 FOLLOWING) AS wj
FROM (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') AS DATE) AS DateBooked,
DATE_ADD(CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') AS DATE), 30, 'DAY') AS DateBookedMonth,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked,
FROM
dsathaye_cust_data.cc_trans
WHERE
// USE_CASE = 'Use Case 10 - Yellow'
MERCHANT_CATEGORY_DESC = 'Airlines') AS parsedateDetail
WHERE
CUST_NAME <> NameBooked ) AS wjAccountId
GROUP BY
ACCOUNTID ) AS maxWJ
WHERE
(maxWJ.maxPerAccountId == 3
OR maxWJ.maxPerAccountId == 2) AND ACCOUNTID NOT IN (SELECT ACCOUNTID FROM (SELECT ACCOUNTID, sum(IF(totalMerch > restTrxn,1,0)) as total FROM( SELECT q.ACCOUNTID, q.MERCHANT_NAME, sum(q.merchTrxn) as totalMerch, sum(q.totalTrxn) as restTrxn
FROM
( SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit' OR TRANSACTION_TYPE == 'Refund', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit' AND TRANSACTION_TYPE != 'Refund', 1, 0)) AS totalTrxn,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked,
CUST_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
//USE_CASE = 'Use Case 10 - Red' AND
MERCHANT_CATEGORY_DESC = 'Airlines'
GROUP BY
ACCOUNTID,
MERCHANT_NAME, NameBooked, CUST_NAME,
TRANSACTION_TYPE ) as q WHERE q.CUST_NAME <> q. NameBooked GROUP BY q.ACCOUNTID, q.MERCHANT_NAME ) GROUP BY ACCOUNTID) WHERE total != 0 GROUP BY ACCOUNTID ) GROUP BY ACCOUNTID),
(SELECT UNIQUE(ACCOUNTID) as ACCOUNTID, 'Red' as QA FROM (SELECT ACCOUNTID FROM (SELECT ACCOUNTID, MAX(wj) as maxPerAccountId FROM ( SELECT ACCOUNTID, DateBooked, COUNT(1) OVER (PARTITION BY ACCOUNTID ORDER BY DateBooked RANGE BETWEEN CURRENT ROW AND 30 FOLLOWING) as wj FROM (SELECT
ACCOUNTID, CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE) AS DateBooked,
DATE_ADD(CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE), 30, 'DAY') as DateBookedMonth,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked
FROM
dsathaye_cust_data.cc_trans
WHERE
//USE_CASE = 'Use Case 10 - Red' AND
MERCHANT_CATEGORY_DESC = 'Airlines') as parsedateDetail WHERE CUST_NAME <> NameBooked ) as wjAccountId GROUP BY ACCOUNTID ) as maxWJ WHERE maxWJ.maxPerAccountId >= 4),
(SELECT ACCOUNTID FROM (SELECT ACCOUNTID, sum(IF(totalMerch > restTrxn,1,0)) as total FROM( SELECT q.ACCOUNTID, q.MERCHANT_NAME, sum(q.merchTrxn) as totalMerch, sum(q.totalTrxn) as restTrxn
FROM
( SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit' OR TRANSACTION_TYPE == 'Refund', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit' AND TRANSACTION_TYPE != 'Refund', 1, 0)) AS totalTrxn,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked,
CUST_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
//USE_CASE = 'Use Case 10 - Red' AND
MERCHANT_CATEGORY_DESC = 'Airlines'
GROUP BY
ACCOUNTID,
MERCHANT_NAME, NameBooked, CUST_NAME,
TRANSACTION_TYPE ) as q WHERE q.CUST_NAME <> q. NameBooked GROUP BY q.ACCOUNTID, q.MERCHANT_NAME ) GROUP BY ACCOUNTID) WHERE total != 0 GROUP BY ACCOUNTID ))


#Create UseCase11Red table after running below query:	
SELECT ACCOUNTID, 'Use Case 11 - Red' as QA FROM (SELECT ACCOUNTID, SUM(IF(Amount >= (my_avg+2*my_stdev) and
DATEDIFF(TRANSACTION_DATE , tt) >= 180 AND BALANCE <= CREDIT_LIMIT ,1,0) ) as infracPay, SUM(IF(MoneySpent >= (my_avg_money+2*my_stdev_money) and
DATEDIFF(TRANSACTION_DATE , tt) >= 180 AND BALANCE <= CREDIT_LIMIT ,1,0)) as infracPerc FROM (
Select Accountid, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE, CREDIT_LIMIT, Date2, MoneySpent,
avg(AMOUNT) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN 180
PRECEDING AND CURRENT ROW) as my_avg,
STDDEV(AMOUNT) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN
180 PRECEDING AND CURRENT ROW) as my_stdev,
avg(MoneySpent) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN 180
PRECEDING AND CURRENT ROW) as my_avg_money,
STDDEV(MoneySpent) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN
180 PRECEDING AND CURRENT ROW) as my_stdev_money,
MIN(TRANSACTION_DATE) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE) as tt
from
(
Select ACCOUNTID, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE, CREDIT_LIMIT, AMOUNT/(CREDIT_LIMIT - BALANCE + AMOUNT) as MoneySpent,
Date(DATE_ADD(TRANSACTION_DATE, -180, "DAY")) as Date2,
from dsathaye_cust_data.cc_trans where 
MERCHANT_CATEGORY_DESC = 'Customer Payment'// AND ACCOUNTID = 10786172 // Order By Accountid AND BALANCE <= CREDIT_LIMIT 
)
) GROUP BY ACCOUNTID) WHERE infracPerc > 0 GROUP BY ACCOUNTID


#Create UseCase11Yellow table after running below query:	
SELECT ACCOUNTID, 'Use Case 11 - Yellow' as QA FROM (SELECT ACCOUNTID, SUM(IF(Amount >= (my_avg+my_stdev) and AMOUNT < (my_avg+2*my_stdev) AND
DATEDIFF(TRANSACTION_DATE , tt) >= 180 AND BALANCE <= CREDIT_LIMIT ,1,0) ) as infracPay, SUM(IF(MoneySpent < (my_avg_money+2*my_stdev_money) and MoneySpent >= (my_avg_money+my_stdev_money) and
DATEDIFF(TRANSACTION_DATE , tt) >= 180 AND BALANCE <= CREDIT_LIMIT ,1,0)) as infracPerc FROM (
Select Accountid, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE, CREDIT_LIMIT, Date2, MoneySpent,
avg(AMOUNT) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN 180
PRECEDING AND CURRENT ROW) as my_avg,
STDDEV(AMOUNT) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN
180 PRECEDING AND CURRENT ROW) as my_stdev,
avg(MoneySpent) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN 180
PRECEDING AND CURRENT ROW) as my_avg_money,
STDDEV(MoneySpent) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN
180 PRECEDING AND CURRENT ROW) as my_stdev_money,
MIN(TRANSACTION_DATE) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE) as tt
from
(
Select ACCOUNTID, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE, CREDIT_LIMIT, AMOUNT/(CREDIT_LIMIT - BALANCE + AMOUNT) as MoneySpent,
Date(DATE_ADD(TRANSACTION_DATE, -180, "DAY")) as Date2,
from dsathaye_cust_data.cc_trans where 
MERCHANT_CATEGORY_DESC = 'Customer Payment'// AND ACCOUNTID = 10786172 // Order By Accountid AND BALANCE <= CREDIT_LIMIT 
)
) GROUP BY ACCOUNTID) WHERE infracPerc > 0 AND ACCOUNTID NOT IN (SELECT ACCOUNTID FROM dsathaye_cust_data.UseCase11Red) GROUP BY ACCOUNTID


#Create UseCase11 table after running below query and running the two above queries saving the appropriate table names:
SELECT ACCOUNTID, QA as UseCase111 FROM (SELECT
UNIQUE(ACCOUNTID) AS ACCOUNTID,
'Green' AS QA
FROM
dsathaye_cust_data.cc_trans
WHERE
ACCOUNTID NOT IN (
SELECT
ACCOUNTID
FROM
dsathaye_cust_data.UseCase11Red)
AND ACCOUNTID NOT IN (
SELECT
ACCOUNTID
FROM
dsathaye_cust_data.UseCase11Yellow)), dsathaye_cust_data.UseCase11Yellow, dsathaye_cust_data.UseCase11Red	


#Once all 12 tables have been create, one can now merge them:
SELECT
  UseCase10.ACCOUNTID as ACCOUNTID, UseCase10.USE_CASE_10 as USE_CASE_10, UseCase11.USE_CASE_11 as USE_CASE_11, UseCase2.USE_CASE_2 as USE_CASE_2, 
UseCase2.USE_CASE_2 as USE_CASE_2, UseCase3.USE_CASE_3 as USE_CASE_3,
UseCase4.USE_CASE_4 as USE_CASE_4, UseCase5.USE_CASE_5 as USE_CASE_5, 
UseCase6.USE_CASE_6 as USE_CASE_6, UseCase7.USE_CASE_7 as USE_CASE_7,
UseCase8.USE_CASE_8 as USE_CASE_8, UseCase9.USE_CASE_9 as USE_CASE_9,
UseCase110.USE_CASE_110 as USE_CASE_110, UseCase111.USE_CASE_111 as USE_CASE_110
FROM
  dsathaye_cust_data.UseCase10 as UseCase10
JOIN
  dsathaye_cust_data.UseCase11 as UseCase11
ON
  UseCase10.ACCOUNTID == UseCase11.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase2 as UseCase2
ON
  UseCase10.ACCOUNTID = UseCase2.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase3 as UseCase3
ON
  UseCase10.ACCOUNTID = UseCase3.ACCOUNTID
JOINs
  dsathaye_cust_data.UseCase4 as UseCase4
ON
  UseCase10.ACCOUNTID = UseCase4.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase5 as UseCase5
ON
  UseCase10.ACCOUNTID = UseCase5.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase6 as UseCase6
ON
  UseCase10.ACCOUNTID = UseCase6.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase7 as UseCase7
ON
  UseCase10.ACCOUNTID = UseCase7.ID
JOIN
  dsathaye_cust_data.UseCase8 as UseCase8
ON
  UseCase10.ACCOUNTID = UseCase8.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase9 as UseCase9
ON
  UseCase10.ACCOUNTID = UseCase9.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase110 as UseCase110
ON
  UseCase10.ACCOUNTID = UseCase110.ACCOUNTID
JOIN
  dsathaye_cust_data.UseCase111 as UseCase111
ON
  UseCase10.ACCOUNTID = UseCase111.ACCOUNTID
Next update the uber_cust table with these risk ratings by saving the below query as the new uber_cust.
SELECT
  ROWNUM,
  HIGH.ACCOUNTID,
  ACCT_TYPE,
  NUM_CCS,
  NAME,
  M_NAME,
  SSN,
  AUTHORIZED_NAME2,
  M_NAME2,
  SSN2,
  AUTHORIZED_NAME3,
  M_NAME3,
  SSN3,
  AUTHORIZED_NAME4,
  M_NAME4,
  SSN4,
  CREDITCARDNUMBER,
  CREDITCARDTYPE,
  EMPLOYER,
  CUSTEMAIL,
  OCCUPATION,
  CITY,
  STATE,
  ZIP,
  COUNTRY,
  PREVIOUS_CITY,
  PREVIOUS_STATE,
  PREVIOUS_ZIP,
  PREVIOUS_COUNTRY,
  DOB,
  PEP,
  SAR,
  CLOSEDACCOUNT,
  RELATED_ACCT,
  RELATED_TYPE,
  PARTY_TYPE,
  PARTY_RELATION,
  PARTY_STARTDATE,
  PARTY_ENDDATE,
  LARGE_CASH_EXEMPT,
  DEMARKET_FLAG,
  DEMARKET_DATE,
  PROB_DEFAULT_RISKR,
  OFFICIAL_LANG_PREF,
  CONSENT_SHARING,
  PREFERRED_CHANNEL,
  PRIMARY_BRANCH_NO,
  DEPENDANTS_COUNT,
  SEG_MODEL_ID,
  SEG_MODEL_TYPE,
  SEG_MODEL_NAME,
  SEG_MODEL_GROUP,
  SEG_M_GRP_DESC,
  SEG_MODEL_SCORE,
  ARMS_MANUFACTURER,
  AUCTION,
  CASHINTENSIVE_BUSINESS,
  CASINO_GAMBLING,
  CHANNEL_ONBOARDING,
  CHANNEL_ONGOING_TRANSACTIONS,
  CLIENT_NET_WORTH,
  COMPLEX_HI_VEHICLE,
  DEALER_PRECIOUS_METAL,
  DIGITAL_PM_OPERATOR,
  EMBASSY_CONSULATE,
  EXCHANGE_CURRENCY,
  FOREIGN_FINANCIAL_INSTITUTION,
  FOREIGN_GOVERNMENT,
  FOREIGN_NONBANK_FINANCIAL_INSTITUTION,
  INTERNET_GAMBLING,
  MEDICAL_MARIJUANA_DISPENSARY,
  MONEY_SERVICE_BUSINESS,
  NAICS_CODE,
  NONREGULATED_FINANCIAL_INSTITUTION,
  NOT_PROFIT,
  PRIVATELY_ATM_OPERATOR,
  PRODUCTS,
  SALES_USED_VEHICLES,
  SERVICES,
  SIC_CODE,
  STOCK_MARKET_LISTING,
  THIRD_PARTY_PAYMENT_PROCESSOR,
  TRANSACTING_PROVIDER,
  HIGH_NET_WORTH,
  HIGH_RISK,
  RISK_RATING,
  USE_CASE_SCENARIO
FROM
  dsathaye_cust_data.MergedHighRiskCnts AS HIGH
JOIN (
  SELECT
    * EXCEPT(HIGH_RISK,
      RISK_RATING)
  FROM
    dsathaye_cust_data.uber_cust) AS CUST_DATA
ON
  CUST_DATA.ACCOUNTID = HIGH.ACCOUNTID


