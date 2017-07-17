%% Queries from Initial 12 Scenario Detection Logic%%

%Query for Use Case 1.0 Red%
SELECT ACCOUNTID, 'Use Case 1.0 - Red' FROM (SELECT
ACCOUNTID, SUM(IF(BALANCE > CREDIT_LIMIT AND MERCHANT_CATEGORY_CODE = '1111' AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111' AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 1.0 - Red'
GROUP BY
ACCOUNTID
ORDER BY perc desc) WHERE perc > .7

%Query for Use Case 1.0 Yellow
SELECT ACCOUNTID, 'Use Case 1.0 - Yellow' FROM (SELECT
ACCOUNTID, SUM(IF(BALANCE > CREDIT_LIMIT AND MERCHANT_CATEGORY_CODE = '1111' AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111' AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0)) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 1.0 - Yellow'
GROUP BY
ACCOUNTID
ORDER BY perc desc) WHERE perc >= .3 and perc <= .7

%Query for Use Case 1.0 Green%
"SELECT
  ACCOUNTID,
  'Use Case 1.0 - Green'
FROM (
  SELECT
    ACCOUNTID,
    SUM(IF(BALANCE > CREDIT_LIMIT
        AND MERCHANT_CATEGORY_CODE = '1111'
        AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0))/SUM(IF(MERCHANT_CATEGORY_CODE = '1111'
        AND MERCHANT_CATEGORY_DESC = 'Customer Payment',1,0)) AS perc
  FROM
    dsathaye_cust_data.cc_trans
  WHERE
    USE_CASE = 'Use Case 1.0 - Green'
  GROUP BY
    ACCOUNTID
  ORDER BY
    perc DESC)
WHERE
  perc < .3"

  %Query for Use Case 1.1 Red%
  SELECT ACCOUNTID, perc FROM (SELECT
ACCOUNTID, SUM(IF(TRANSACTION_TYPE = 'Refund' or TRANSACTION_TYPE = 'Cash Balance Refund',1,0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 1.1 - Red'
GROUP BY
ACCOUNTID
ORDER BY perc desc) WHERE perc >= .5

 %Query for Use Case 1.1 Yellow%
"SELECT ACCOUNTID, perc FROM (SELECT
ACCOUNTID, SUM(IF(TRANSACTION_TYPE = 'Refund',1,0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 1.1 - Yellow'
GROUP BY
ACCOUNTID
ORDER BY perc desc) WHERE perc < .5 and perc >=.25"

%Query for Use Case 1.1 Green%
SELECT ACCOUNTID, perc FROM (SELECT
ACCOUNTID, SUM(IF(TRANSACTION_TYPE = 'Refund' or TRANSACTION_TYPE = 'Cash Balance Refund',1,0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 1.1 - Green'
GROUP BY
ACCOUNTID
ORDER BY perc desc) WHERE perc <= .25

%Query for Use Case 2 Red%
SELECT ACCOUNTID, q.perc FROM (SELECT
ACCOUNTID, SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'Wire Payment' OR TRANSACTION_TYPE = 'ACH PaymentCash Payment', 1, 0))/sum(IF(MERCHANT_CATEGORY_CODE = '1111', 1,0)) as perc
FROM
dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 2 - Red' GROUP BY ACCOUNTID) as q WHERE perc >= .5 ORDER BY perc desc;

$Query for Use Case 2 Yellow%
SELECT ACCOUNTID, perc FROM (SELECT
ACCOUNTID, SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'Wire Payment' OR TRANSACTION_TYPE = 'ACH PaymentCash Payment', 1, 0))/count(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 2 - Yellow' GROUP BY ACCOUNTID) WHERE perc > = .3 and perc < .5 ORDER BY perc desc;

%Query for Use Case 2 Green%
SELECT ACCOUNTID, perc FROM (SELECT
ACCOUNTID, SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'Wire Payment' OR TRANSACTION_TYPE = 'ACH PaymentCash Payment', 1, 0))/count(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 2 - Green' GROUP BY ACCOUNTID) WHERE perc < .3 ORDER BY perc desc;

%Query for Use Case 3 Red%
SELECT
ACCOUNTID,
perc
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'WSELECT ACCOUNTID
FROM [practicum-2016:shenyuan_credit_cards.cc_trans_updated1]
WHERE USE_CASE = 'Use Case 3 - Red'
GROUP BY ACCOUNTIDire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'e-Check'
OR TRANSACTION_TYPE = 'Paper Check'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check' AND MERCHANT_CATEGORY_CODE = '2222', 1, 0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 3 - Red'
GROUP BY
ACCOUNTID)
WHERE
perc >= .4
ORDER BY
perc DESC;

%Query for Use Case 3 Yellow%
SELECT
ACCOUNTID,
perc
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'ACH Payment'
OR TRANSACTION_TYPE = 'WSELECT ACCOUNTID
FROM [practicum-2016:shenyuan_credit_cards.cc_trans_updated1]
WHERE USE_CASE = 'Use Case 3 - Red'
GROUP BY ACCOUNTIDire Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'e-Check'
OR TRANSACTION_TYPE = 'Paper Check'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check' AND MERCHANT_CATEGORY_CODE = '2222', 1, 0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 3 - Red'
GROUP BY
ACCOUNTID)
WHERE
perc >= .4
ORDER BY
perc DESC;



%Query for Use Case 3 Green%
SELECT q.ACCOUNTID, q.perc FROM ( SELECT
ACCOUNTID, SUM(IF((TRANSACTION_TYPE = 'ACH Payment' OR TRANSACTION_TYPE = 'Wire Payment' OR TRANSACTION_TYPE = 'ACH PaymentCash Payment' OR TRANSACTION_TYPE = 'e-Check' OR TRANSACTION_TYPE = 'Paper Check' OR TRANSACTION_TYPE = 'ATM PaymentPaper Check')
AND (MERCHANT_CATEGORY_DESC = 'Non Customer Payment') AND (MERCHANT_CATEGORY_CODE == '2222'), 1, 0))/SUM(IF(TRANSACTION_TYPE = 'ACH Payment' OR TRANSACTION_TYPE = 'Wire Payment' OR TRANSACTION_TYPE = 'ACH PaymentCash Payment' OR TRANSACTION_TYPE = 'e-Check' OR TRANSACTION_TYPE = 'Paper Check' OR TRANSACTION_TYPE = 'ATM PaymentPaper Check'
, 1, 0)) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE USE_CASE = 'Use Case 3 - Green' GROUP BY ACCOUNTID ) as q WHERE q.perc <= .25

%Query for Use Case 4 Red%
SELECT
ACCOUNTID,
perc
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'ATM Payment'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check' AND ((MERCHANT_COUNTRY = 'MX' AND CUST_STATE IN ('CA', 'AZ', 'NM', 'TX')) OR (MERCHANT_COUNTRY = 'CA' AND CUST_STATE IN ('AL','WA','ID','MT','ND','MN','OH','PA','NY','VT','NH', 'ME' )) OR MERCHANT_COUNTRY <> CUST_COUNTRY), 1, 0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 4 - Red'
GROUP BY
ACCOUNTID)
ORDER BY
perc DESC;

%Query for Use Case 4 Yellow%
SELECT
ACCOUNTID,
perc
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'ATM Payment'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check' AND ((MERCHANT_COUNTRY = 'MX' AND CUST_STATE IN ('CA', 'AZ', 'NM', 'TX')) OR (MERCHANT_COUNTRY = 'CA' AND CUST_STATE IN ('AL','WA','ID','MT','ND','MN','OH','PA','NY','VT','NH', 'ME' )) OR MERCHANT_COUNTRY <> CUST_COUNTRY), 1, 0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 4 - Yellow'
GROUP BY
ACCOUNTID)
ORDER BY
perc DESC;

%Query for Use Case 4 Green%
SELECT
ACCOUNTID,
perc
FROM (
SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Payment'
OR TRANSACTION_TYPE = 'ACH PaymentCash Payment'
OR TRANSACTION_TYPE = 'ATM Payment'
OR TRANSACTION_TYPE = 'ATM PaymentPaper Check' AND MERCHANT_COUNTRY <> CUST_COUNTRY, 1, 0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 4 - Green'
GROUP BY
ACCOUNTID)
WHERE
perc <= .3
ORDER BY
perc DESC;

%Query for Use Case 5 Red%
SELECT ACCOUNTID, 'Use Case 5 - Red' AS QA
FROM
(SELECT Total.ACCOUNTID AS ACCOUNTID, High_Risk.HR_value/Total.Total_value AS Value_perc,High_Risk.HR_tran/Total.Total_tran AS Tran_perc FROM
(SELECT ACCOUNTID, SUM(AMOUNT) AS Total_value, COUNT(ACCOUNTID) AS Total_tran
FROM dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 5 - Red'
GROUP BY ACCOUNTID) Total
INNER JOIN
(SELECT ACCOUNTID,SUM(AMOUNT) AS HR_value, COUNT(ACCOUNTID) AS HR_tran
FROM dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 5 - Red'
AND MERCHANT_COUNTRY IN
(
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Red')
GROUP BY ACCOUNTID)AS High_Risk
ON Total.ACCOUNTID = High_Risk.ACCOUNTID)
WHERE Value_perc>0.45 OR Tran_perc>0.45 


%Query for Use Case 5 Yellow%
SELECT ACCOUNTID percS, partS, totS, percA, partC, totC FROM (SELECT
partial.ACCOUNTID,
(float(partial.sumPartAmt)/float(fulltable.sumAmt)) as percS,
partial.sumPartAmt as partS,
fulltable.sumAmt as totS,
((partial.countPartAmt)/(fulltable.countAmt)) as percA,
partial.countPartAmt as partC,
fulltable.countAmt as totC
FROM
(SELECT ACCOUNTID, SUM(AMOUNT) as sumAmt, COUNT(AMOUNT) as countAmt FROM dsathaye_cust_data.cc_trans WHERE
USE_CASE = 'Use Case 5 - Yellow' GROUP BY ACCOUNTID) as fulltable
JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS sumPartAmt,
COUNT(AMOUNT) AS countPartAmt
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
ACCOUNTID ) AS partial
ON
partial.ACCOUNTID = fulltable.ACCOUNTID
ORDER BY percS DESC, percA DESC )
WHERE ((percS < .45 AND percS >= .3) OR (percA < .45 AND percA >= .3))

%Query for Use Case 5 Green%
SELECT ACCOUNTID percS, partS, totS, percA, partC, totC FROM (SELECT
partial.ACCOUNTID,
(float(partial.sumPartAmt)/float(fulltable.sumAmt)) as percS,
partial.sumPartAmt as partS,
fulltable.sumAmt as totS,
((partial.countPartAmt)/(fulltable.countAmt)) as percA,
partial.countPartAmt as partC,
fulltable.countAmt as totC
FROM
(SELECT ACCOUNTID, SUM(AMOUNT) as sumAmt, COUNT(AMOUNT) as countAmt FROM dsathaye_cust_data.cc_trans WHERE
USE_CASE = 'Use Case 5 - Green' GROUP BY ACCOUNTID) as fulltable
JOIN (
SELECT
ACCOUNTID,
SUM(AMOUNT) AS sumPartAmt,
COUNT(AMOUNT) AS countPartAmt
FROM
dsathaye_cust_data.cc_trans
WHERE
MERCHANT_COUNTRY IN (
SELECT
COUNTRYCODE
FROM
dsathaye_cust_data.cc_country_risk
WHERE
RISKLEVEL = 'Green')
GROUP BY
ACCOUNTID ) AS partial
ON
partial.ACCOUNTID = fulltable.ACCOUNTID
ORDER BY percS DESC, percA DESC )
WHERE ((percS < .3) AND (percA < .3))

%Query for Use Case 6 Red%
SELECT ACCOUNTID, percC, percS FROM (SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as percC,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as percS
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 6 - Red'
GROUP BY
ACCOUNTID
) WHERE (percC >= .2 OR percS >= .2 )

%Query for Use Case 6 Yellow%
SELECT ACCOUNTID, percC, percS FROM (SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as percC,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as percS
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 6 - Yellow'
GROUP BY
ACCOUNTID
) WHERE ((percC < .2 and percC >= .1) OR (percS < .2 AND percS >= .1))

%Query for Use Case 6 Green%
SELECT ACCOUNTID, percC, percS FROM (SELECT
ACCOUNTID,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', 1, 0))/COUNT(AMOUNT) as percC,
SUM(IF(TRANSACTION_TYPE = 'Cash Advance - ATM', AMOUNT, 0))/SUM(AMOUNT) as percS
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 6 - Green'
GROUP BY
ACCOUNTID
) WHERE (percC < .1) AND (percS < .1)

%Query for Use Case 7 Red%
%Query for Use Case 7 Yellow%
%Query for Use Case 7 Green%
%Combined%


SELECT ID, USE_CASE_7
FROM
(SELECT ACCOUNTID AS ID, "Use case 7 - Red" AS USE_CASE_7
FROM
(SELECT ACCOUNTID,TRANSACTION_DATE,COUNT(UNIQUE(MERCHANT_COUNTRY)) AS LOCATIONS

FROM (credit_card_isabella.cc_trans)
WHERE TRANSACTION_TYPE="Cash Advance - ATM" OR TRANSACTION_TYPE = "Purchase"
GROUP BY ACCOUNTID,TRANSACTION_DATE
ORDER BY ACCOUNTID,TRANSACTION_DATE)
WHERE LOCATIONS >= 2),

(SELECT ID,USE_CASE_7,NUM_OF_MONTH
FROM
(SELECT ID,"Use Case 7 - Red" AS USE_CASE_7, NUM_OF_MONTH
FROM
(SELECT A.ACCOUNTID AS ID, A.NUM_OF_ML/B.TOTAL_TRANS AS TRHA,A.VALUE_OF_ML/B.TOTAL_VALUE AS TRHB,B.LENGTH_OF_TRANS AS NUM_OF_MONTH
FROM
(SELECT * FROM
(SELECT ACCOUNTID, COUNT(ACCOUNTID) AS NUM_OF_ML, SUM(AMOUNT) AS VALUE_OF_ML
FROM credit_card_isabella.cc_trans
WHERE
MERCHANT_COUNTRY != "US" AND
TRANSACTION_TYPE = "Cash Advance - ATM" OR TRANSACTION_TYPE ="Purchase"
GROUP BY ACCOUNTID
ORDER BY ACCOUNTID) A
JOIN 
(SELECT ACCOUNTID,COUNT(ACCOUNTID) AS TOTAL_TRANS,SUM(AMOUNT) AS TOTAL_VALUE, (YEAR(MAX(TRANSACTION_DATE))-YEAR(MIN(TRANSACTION_DATE)))*12+MONTH(MAX(TRANSACTION_DATE))-MONTH(MIN(TRANSACTION_DATE)) AS LENGTH_OF_TRANS
FROM credit_card_isabella.cc_trans
GROUP BY ACCOUNTID) B
ON A.ACCOUNTID = B.ACCOUNTID))
WHERE TRHA >=0.5 OR TRHB >=0.5),

(SELECT ID,"Use Case 7 - Yellow" AS USE_CASE_7, NUM_OF_MONTH
FROM
(SELECT C.ACCOUNTID AS ID, C.NUM_OF_ML/D.TOTAL_TRANS AS TRHA,C.VALUE_OF_ML/D.TOTAL_VALUE AS TRHB,D.LENGTH_OF_TRANS AS NUM_OF_MONTH
FROM
(SELECT * FROM
(SELECT ACCOUNTID, COUNT(ACCOUNTID) AS NUM_OF_ML, SUM(AMOUNT) AS VALUE_OF_ML
FROM credit_card_isabella.cc_trans
WHERE
MERCHANT_COUNTRY != "US" AND
TRANSACTION_TYPE = "Cash Advance - ATM" OR TRANSACTION_TYPE ="Purchase"
GROUP BY ACCOUNTID
ORDER BY ACCOUNTID) C
JOIN 
(SELECT ACCOUNTID,COUNT(ACCOUNTID) AS TOTAL_TRANS,SUM(AMOUNT) AS TOTAL_VALUE, (YEAR(MAX(TRANSACTION_DATE))-YEAR(MIN(TRANSACTION_DATE)))*12+MONTH(MAX(TRANSACTION_DATE))-MONTH(MIN(TRANSACTION_DATE)) AS LENGTH_OF_TRANS
FROM credit_card_isabella.cc_trans
GROUP BY ACCOUNTID) D
ON C.ACCOUNTID = D.ACCOUNTID))
WHERE (TRHA<0.5 AND TRHB<0.5 AND (TRHA>=0.3 OR TRHB>=0.3))),

(SELECT ID,"Use Case 7 - Green" AS USE_CASE_7, NUM_OF_MONTH
FROM
(SELECT E.ACCOUNTID AS ID, E.NUM_OF_ML/F.TOTAL_TRANS AS TRHA,E.VALUE_OF_ML/F.TOTAL_VALUE AS TRHB,F.LENGTH_OF_TRANS AS NUM_OF_MONTH
FROM
(SELECT * FROM
(SELECT ACCOUNTID, COUNT(ACCOUNTID) AS NUM_OF_ML, SUM(AMOUNT) AS VALUE_OF_ML
FROM credit_card_isabella.cc_trans
WHERE
MERCHANT_COUNTRY != "US" AND
TRANSACTION_TYPE = "Cash Advance - ATM" OR TRANSACTION_TYPE ="Purchase"
GROUP BY ACCOUNTID
ORDER BY ACCOUNTID) E
JOIN 
(SELECT ACCOUNTID,COUNT(ACCOUNTID) AS TOTAL_TRANS,SUM(AMOUNT) AS TOTAL_VALUE, (YEAR(MAX(TRANSACTION_DATE))-YEAR(MIN(TRANSACTION_DATE)))*12+MONTH(MAX(TRANSACTION_DATE))-MONTH(MIN(TRANSACTION_DATE)) AS LENGTH_OF_TRANS
FROM credit_card_isabella.cc_trans
GROUP BY ACCOUNTID) F
ON E.ACCOUNTID = F.ACCOUNTID))
WHERE TRHA<0.3 AND TRHB<0.3),
ORDER BY ID)

%Query for Use Case 8 Red%
SELECT ACCOUNTID FROM (SELECT ACCOUNTID, sum(IF(totalMerch > restTrxn,1,0)) as total FROM (SELECT q.ACCOUNTID, q.MERCHANT_NAME, sum(q.merchTrxn) as totalMerch, sum(q.totalTrxn) as restTrxn
FROM
(
SELECT
ACCOUNTID,
MERCHANT_NAME, TRANSACTION_TYPE, SUM(IF(TRANSACTION_TYPE == 'Merchant Credit', 1, 0)) as merchTrxn, SUM(IF(TRANSACTION_TYPE != 'Merchant Credit', 1, 0)) as totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 8 - Red' 
GROUP BY
ACCOUNTID,
MERCHANT_NAME, TRANSACTION_TYPE) as q GROUP BY q.ACCOUNTID, q.MERCHANT_NAME ) GROUP BY ACCOUNTID) WHERE total >= 3


%Query for Use Case 8 Yellow%
SELECT ACCOUNTID FROM (SELECT ACCOUNTID, sum(IF(totalMerch > restTrxn,1,0)) as total FROM (SELECT q.ACCOUNTID, q.MERCHANT_NAME, sum(q.merchTrxn) as totalMerch, sum(q.totalTrxn) as restTrxn
FROM
(
SELECT
ACCOUNTID,
MERCHANT_NAME, TRANSACTION_TYPE, SUM(IF(TRANSACTION_TYPE == 'Merchant Credit', 1, 0)) as merchTrxn, SUM(IF(TRANSACTION_TYPE != 'Merchant Credit', 1, 0)) as totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 8 - Yellow' 
GROUP BY
ACCOUNTID,
MERCHANT_NAME, TRANSACTION_TYPE) as q GROUP BY q.ACCOUNTID, q.MERCHANT_NAME ) GROUP BY ACCOUNTID) WHERE (total == 1 or total == 2)


%Query for Use Case 8 Green%
SELECT ACCOUNTID FROM dsathaye_cust_data.cc_trans WHERE USE_CASE = 'Use Case 8 - Green' AND ACCOUNTID NOT IN (SELECT ACCOUNTID FROM dsathaye_cust_data.cc_trans where
TRANSACTION_TYPE = 'Merchant Credit' AND USE_CASE = 'Use Case 8 - Green') GROUP BY ACCOUNTID

%Query for Use Case 9 Red%
SELECT UNIQUE(ID) FROM (SELECT
ID
FROM (
SELECT
dr1.ACCOUNTID AS ID,
COUNT(*) AS COUNTOVERLAPS
FROM (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkin:\s(.*?);') AS DATE) AS Checkindate,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkout:\s(.*?);') AS DATE) AS Checkoutdate, MERCHANT_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Red'
AND TRANS_DETAIL <> ''
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts') AS dr1
INNER JOIN (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkin:\s(.*?);') AS DATE) AS Checkindate,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkout:\s(.*?);') AS DATE) AS Checkoutdate , MERCHANT_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Red'
AND TRANS_DETAIL <> ''
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts') AS dr2
ON
dr2.ACCOUNTID == dr1.ACCOUNTID
WHERE
dr2.Checkindate >= dr1.Checkindate
AND dr1.Checkoutdate >= dr2.Checkindate
AND dr1.MERCHANT_NAME != dr2.MERCHANT_NAME
GROUP BY
ID )
WHERE
COUNTOVERLAPS > 1 ),
(SELECT qt.ACCOUNTID as ID FROM (SELECT ACCOUNTID, sum(IF(totalMerch > restTrxn,1,0)) as total FROM( SELECT q.ACCOUNTID, q.MERCHANT_NAME, sum(q.merchTrxn) as totalMerch, sum(q.totalTrxn) as restTrxn
FROM
( SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit' OR TRANSACTION_TYPE == 'Refund', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit' AND TRANSACTION_TYPE != 'Refund', 1, 0)) AS totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Red'
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts'
GROUP BY
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE ) as q GROUP BY q.ACCOUNTID, q.MERCHANT_NAME) GROUP BY ACCOUNTID) as qt WHERE qt.total > 1) 

%Query for Use Case 9 Yellow%
SELECT UNIQUE(ID) FROM (SELECT
ID
FROM (
SELECT
dr1.ACCOUNTID AS ID,
COUNT(*) AS COUNTOVERLAPS
FROM (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkin:\s(.*?);') AS DATE) AS Checkindate,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkout:\s(.*?);') AS DATE) AS Checkoutdate, MERCHANT_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Yellow'
AND TRANS_DETAIL <> ''
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts') AS dr1
INNER JOIN (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkin:\s(.*?);') AS DATE) AS Checkindate,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkout:\s(.*?);') AS DATE) AS Checkoutdate , MERCHANT_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Yellow'
AND TRANS_DETAIL <> ''
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts') AS dr2
ON
dr2.ACCOUNTID == dr1.ACCOUNTID
WHERE
dr2.Checkindate >= dr1.Checkindate
AND dr1.Checkoutdate >= dr2.Checkindate
AND dr1.MERCHANT_NAME != dr2.MERCHANT_NAME
GROUP BY
ID )
WHERE
COUNTOVERLAPS == 1 ),
(SELECT qt.ACCOUNTID as ID FROM (SELECT ACCOUNTID, sum(IF(totalMerch > restTrxn,1,0)) as total FROM( SELECT q.ACCOUNTID, q.MERCHANT_NAME, sum(q.merchTrxn) as totalMerch, sum(q.totalTrxn) as restTrxn
FROM
( SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit' OR TRANSACTION_TYPE == 'Refund', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit' AND TRANSACTION_TYPE != 'Refund', 1, 0)) AS totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Yellow'
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts'
GROUP BY
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE ) as q GROUP BY q.ACCOUNTID, q.MERCHANT_NAME) GROUP BY ACCOUNTID) as qt WHERE qt.total == 1)

%Query for Use Case 9 Green%
SELECT UNIQUE(ACCOUNTID) FROM dsathaye_cust_data.cc_trans WHERE USE_CASE = 'Use Case 9 - Green' AND ACCOUNTID NOT IN (SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID
FROM (
SELECT
dr1.ACCOUNTID AS ACCOUNTID,
COUNT(*) AS COUNTOVERLAPS
FROM (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkin:\s(.*?);') AS DATE) AS Checkindate,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkout:\s(.*?);') AS DATE) AS Checkoutdate,
MERCHANT_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Green'
AND TRANS_DETAIL <> ''
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts') AS dr1
INNER JOIN (
SELECT
ACCOUNTID,
CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkin:\s(.*?);') AS DATE) AS Checkindate,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Checkout:\s(.*?);') AS DATE) AS Checkoutdate,
MERCHANT_NAME
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Green'
AND TRANS_DETAIL <> ''
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts') AS dr2
ON
dr2.ACCOUNTID == dr1.ACCOUNTID
WHERE
dr2.Checkindate >= dr1.Checkindate
AND dr1.Checkoutdate >= dr2.Checkindate
AND dr1.MERCHANT_NAME != dr2.MERCHANT_NAME
GROUP BY
ACCOUNTID )
WHERE
COUNTOVERLAPS > 0 ),
(
SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID,
SUM(IF(totalMerch > restTrxn,1,0)) AS total FROM (
SELECT
ACCOUNTID,
q.MERCHANT_NAME,
SUM(q.merchTrxn) AS totalMerch,
SUM(q.totalTrxn) AS restTrxn
FROM (
SELECT
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE,
SUM(IF(TRANSACTION_TYPE == 'Merchant Credit'
OR TRANSACTION_TYPE == 'Refund', 1, 0)) AS merchTrxn,
SUM(IF(TRANSACTION_TYPE != 'Merchant Credit'
AND TRANSACTION_TYPE != 'Refund', 1, 0)) AS totalTrxn
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 9 - Green'
AND MERCHANT_CATEGORY_DESC = 'Hotels/Motels/Inns/Resorts'
GROUP BY
ACCOUNTID,
MERCHANT_NAME,
TRANSACTION_TYPE ) AS q
GROUP BY
ACCOUNTID,
q.MERCHANT_NAME)
GROUP BY
ACCOUNTID) AS qt
WHERE
qt.total > 0))

%Query for Use Case 10 Red%
SELECT COUNT(UNIQUE(ACCOUNTID)) FROM (SELECT ACCOUNTID FROM (SELECT ACCOUNTID, MAX(wj) as maxPerAccountId FROM ( SELECT ACCOUNTID, DateBooked, COUNT(1) OVER (PARTITION BY ACCOUNTID ORDER BY DateBooked RANGE BETWEEN CURRENT ROW AND 30 FOLLOWING) as wj FROM (SELECT
ACCOUNTID, CUST_NAME,
//TRANSACTION_DATE,
//TRANS_DETAIL,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE) AS DateBooked,
DATE_ADD(CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE), 30, 'DAY') as DateBookedMonth,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked,
//REGEXP_EXTRACT(TRANS_DETAIL, r'Address:\s(.*?)[A-Z]{2}') AS City,
//REGEXP_EXTRACT(TRANS_DETAIL, r'([A-Z]{2})') AS State,
//REGEXP_EXTRACT(TRANS_DETAIL, r'(\d{5})') AS ZipCode,
//REGEXP_EXTRACT(TRANS_DETAIL, r'Source\s:(.*?);') AS Source,
//REGEXP_EXTRACT(TRANS_DETAIL, r'Destination:(.*?)$') AS Destination,
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 10 - Red'
AND MERCHANT_CATEGORY_DESC = 'Airlines') as parsedateDetail WHERE CUST_NAME <> NameBooked ) as wjAccountId GROUP BY ACCOUNTID ) as maxWJ WHERE maxWJ.maxPerAccountId >= 4),
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
USE_CASE = 'Use Case 10 - Red'
AND MERCHANT_CATEGORY_DESC = 'Airlines'
GROUP BY
ACCOUNTID,
MERCHANT_NAME, NameBooked, CUST_NAME,
TRANSACTION_TYPE ) as q WHERE q.CUST_NAME <> q. NameBooked GROUP BY q.ACCOUNTID, q.MERCHANT_NAME ) GROUP BY ACCOUNTID) WHERE total != 0 GROUP BY ACCOUNTID )

%Query for Use Case 10 Yellow%
SELECT ACCOUNTID, maxWJ.maxPerAccountId FROM (SELECT ACCOUNTID, MAX(wj) as maxPerAccountId FROM ( SELECT ACCOUNTID, DateBooked, COUNT(1) OVER (PARTITION BY ACCOUNTID ORDER BY DateBooked RANGE BETWEEN CURRENT ROW AND 30 FOLLOWING) as wj FROM (SELECT
ACCOUNTID, CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE) AS DateBooked,
DATE_ADD(CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE), 30, 'DAY') as DateBookedMonth,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked

FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 10 - Yellow'
AND MERCHANT_CATEGORY_DESC = 'Airlines') as parsedateDetail WHERE CUST_NAME <> NameBooked ) as wjAccountId GROUP BY ACCOUNTID ) as maxWJ WHERE (maxWJ.maxPerAccountId == 3 OR maxWJ.maxPerAccountId == 2) 

%Query for Use Case 10 Green%
SELECT ACCOUNTID, maxWJ.maxPerAccountId FROM (SELECT ACCOUNTID, MAX(wj) as maxPerAccountId FROM ( SELECT ACCOUNTID, DateBooked, COUNT(1) OVER (PARTITION BY ACCOUNTID ORDER BY DateBooked RANGE BETWEEN CURRENT ROW AND 30 FOLLOWING) as wj FROM (SELECT
ACCOUNTID, CUST_NAME,
CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE) AS DateBooked,
DATE_ADD(CAST(REGEXP_EXTRACT(TRANS_DETAIL, r'Date Booked:\s(.*?);') as DATE), 30, 'DAY') as DateBookedMonth,
(REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s([A-Z].*?)[A-Z]') + " " + REGEXP_EXTRACT(TRANS_DETAIL, r'Name Booked:\s[A-Z].*?([A-Z].*?);')) AS NameBooked
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case 10 - Yellow'
AND MERCHANT_CATEGORY_DESC = 'Airlines') as parsedateDetail WHERE CUST_NAME <> NameBooked ) as wjAccountId GROUP BY ACCOUNTID ) as maxWJ WHERE (maxWJ.maxPerAccountId == 3 OR maxWJ.maxPerAccountId == 2) 

%Query for Use Case 11 Red%
Select ACCOUNTID, 'Use Case 11 - Red' as QA from(
Select ACCOUNTID,
SUM(IF(Amount >= (my_avg+ 2*my_stdev) and
DATEDIFF(TRANSACTION_DATE , tt)<180,1,0)) as val2 from
(
Select Accountid, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE, Date2,
avg(Amount) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN 180
PRECEDING AND CURRENT ROW) as my_avg,
STDDEV(Amount) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN
180 PRECEDING AND CURRENT ROW) as my_stdev,
MIN(TRANSACTION_DATE) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE) as tt
from
(
Select ACCOUNTID, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE,
Date(DATE_ADD(TRANSACTION_DATE, -180, "DAY")) as Date2,
from dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 11 - Red' and
TRANSACTION_TYPE contains 'Payment' AND BALANCE <= CREDIT_LIMIT Order By Accountid
)
)
group by Accountid ) where val2 > 0


%Query for Use Case 11 Yellow%
Select ACCOUNTID from(
Select ACCOUNTID,
SUM(IF(Amount >= (my_avg+ my_stdev) and Amount < (my_avg+2*my_stdev) and
DATEDIFF(TRANSACTION_DATE , tt)<180,1,0)) as val2 from
(
Select Accountid, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE, Date2,
avg(Amount) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN 180
PRECEDING AND CURRENT ROW) as my_avg,
STDDEV(Amount) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN
180 PRECEDING AND CURRENT ROW) as my_stdev,
MIN(TRANSACTION_DATE) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE) as tt
from
(
Select ACCOUNTID, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE,
Date(DATE_ADD(TRANSACTION_DATE, -180, "DAY")) as Date2,
from dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 11 - Yellow' and
TRANSACTION_TYPE contains 'Payment' AND BALANCE <= CREDIT_LIMIT Order By Accountid
)
)
group by Accountid ) where val2 > 0

%Query for Use Case 11 Green%
Select ACCOUNTID, 'Use Case 11 - Green' as QA from(
Select ACCOUNTID,
SUM(IF(Amount < (my_avg+ my_stdev) and
DATEDIFF(TRANSACTION_DATE , tt)<180,1,0)) as val2 from
(
Select Accountid, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE, Date2,
avg(Amount) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN 180
PRECEDING AND CURRENT ROW) as my_avg,
STDDEV(Amount) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE RANGE BETWEEN
180 PRECEDING AND CURRENT ROW) as my_stdev,
MIN(TRANSACTION_DATE) OVER (PARTITION BY ACCOUNTID ORDER BY TRANSACTION_DATE) as tt
from
(
Select ACCOUNTID, TRANSACTION_DATE, TRANSACTION_TYPE ,AMOUNT, BALANCE,
Date(DATE_ADD(TRANSACTION_DATE, -180, "DAY")) as Date2,
from dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case 11 - Green' and
TRANSACTION_TYPE contains 'Payment' AND BALANCE <= CREDIT_LIMIT Order By Accountid
)
)
group by Accountid ) where val2 > 0

%Use Case Out of the Country - US%
SELECT UNIQUE(ACCOUNTID) FROM dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case Out of Country - US' AND ACCOUNTID NOT IN (SELECT ACCOUNTID FROM dsathaye_cust_data.cc_trans where USE_CASE = 'Use Case Out of Country - US' AND MERCHANT_COUNTRY != 'US')

%Use Case Out of the Country - 40%
SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID,
SUM(IF(MERCHANT_COUNTRY != 'US',1,0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case Out of Country - 40'
GROUP BY
ACCOUNTID) WHERE perc >= .60

%Use Case Out of the Country - 50%
SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID,
SUM(IF(MERCHANT_COUNTRY != 'US',1,0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case Out of Country - 50'
GROUP BY
ACCOUNTID) WHERE perc >= .50

%Use Case Out of the Country  10%
"SELECT
  ACCOUNTID
FROM (
  SELECT
    ACCOUNTID,
    SUM(IF(MERCHANT_COUNTRY != 'US',1,0))/COUNT(ROWNUM) AS perc
  FROM
    dsathaye_cust_data.cc_trans
  WHERE
    USE_CASE = 'Use Case Out of Country - 10'
  GROUP BY
    ACCOUNTID) WHERE perc >= .9  "

%Use Case Out of the Country 95%
SELECT
ACCOUNTID
FROM (
SELECT
ACCOUNTID,
SUM(IF(MERCHANT_COUNTRY != 'US',1,0))/COUNT(ROWNUM) AS perc
FROM
dsathaye_cust_data.cc_trans
WHERE
USE_CASE = 'Use Case Out of Country - 95'
GROUP BY
ACCOUNTID) WHERE perc >= .05     