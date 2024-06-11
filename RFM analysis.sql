-- Without normalization
SET @cur_date := STR_TO_DATE('1/9/2022', '%d/%m/%Y');

CREATE TEMPORARY TABLE temp AS
WITH rfm_values AS (
  SELECT
  ct.customerid AS customer_id,
  DATEDIFF(@cur_date, MAX(ct.Purchase_Date)) AS recency,
  COUNT(ct.Transaction_ID) AS frequency,
  SUM(ct.GMV) AS monetary
  FROM customer_registered cr
  JOIN customer_transaction ct ON cr.ID = ct.CustomerID
  WHERE
  cr.ID != 0 -- Filter out the test account
  AND cr.stopdate IS NULL -- Filter out inactive customers
  AND DATE(cr.created_date) <= @cur_date -- Filter out customers created after current date
  AND ct.GMV -- Filter out free transaction
  GROUP BY 1
),

rfm_scores AS (
  SELECT
  *,
  NTILE(4) OVER(
  ORDER BY recency DESC
  ) AS r_score,
  NTILE(4) OVER(
  ORDER BY frequency
  ) AS f_score,
  NTILE(4) OVER(
  ORDER BY monetary
  ) AS m_score
  FROM rfm_values
)

SELECT
*,
CONCAT(r_score, f_score, m_score) AS rfm,
CASE
WHEN CONCAT(r_score, f_score, m_score) IN ('444', '443', '434', '433', '424', '344', '343', '334', '333', '324', '234', '243', '244') THEN 'VIP'
WHEN CONCAT(r_score, f_score, m_score) IN ('341', '342', '332', '144', '143', '134', '133', '442', '432', '422', '132', '142', '232', '242', '141', '131', '231', '241', '331', '431') THEN 'Thân thiết'
WHEN CONCAT(r_score, f_score, m_score) IN ('223', '224', '233', '413','414', '423', '124', '323', '123', '214', '213') THEN 'Tiềm năng'
ELSE 'Vãng lai'
END AS segment
FROM rfm_scores;

-- ** Another approach ** --
-- With normalization
USE study_data;

SET @cur_date := STR_TO_DATE('1/9/2022', '%d/%m/%Y');

WITH constract_age AS (
  SELECT
  id AS customer_id,
  CASE
  WHEN DATEDIFF(@cur_date, created_date) / 365.25 < 0.1 THEN 0.1 -- Assign a default value of 0.1 for all new customers
  ELSE ROUND(DATEDIFF(@cur_date, created_date) / 365.25, 1)
  END AS constract_age_in_year
  FROM customer_registered cr
  WHERE
  cr.ID != 0 -- Filter out the test account
  AND cr.stopdate IS NULL -- Filter out inactive customers
  AND DATE(cr.created_date) <= @cur_date
),

rfm_value AS (
  SELECT
  ct.customerid AS customer_id,
  DATEDIFF(@cur_date, MAX(ct.Purchase_Date)) AS recency,
  COUNT(ct.Transaction_ID) AS frequency,
  SUM(ct.GMV) AS monetary
  FROM customer_transaction ct
  WHERE ct.GMV -- Filter out free transaction
  GROUP BY 1
),

customer_rfm_value AS (
  SELECT
  customer_id,
  recency,
  frequency / ca.constract_age_in_year AS frequency, -- Normalize frequency
  monetary / ca.constract_age_in_year AS monetary -- Normalize monetary
  FROM constract_age ca
  JOIN rfm_value rfm USING(customer_id)
  ORDER BY frequency DESC
),

customer_rfm_score AS (
  SELECT
  *,
  NTILE(4) OVER(
  ORDER BY recency DESC
  ) AS r_score,
  NTILE(4) OVER(
  ORDER BY frequency
  ) AS f_score,
  NTILE(4) OVER(
  ORDER BY monetary
  ) AS m_score
  FROM customer_rfm_value
)

SELECT
*,
CONCAT(r_score, f_score, m_score) AS rfm,
CASE
WHEN CONCAT(r_score, f_score, m_score) IN ('444', '443', '434', '433', '424', '344', '343', '334', '333', '324', '234', '243', '244') THEN 'VIP'
WHEN CONCAT(r_score, f_score, m_score) IN ('341', '342', '332', '144', '143', '134', '133', '442', '432', '422', '132', '142', '232', '242', '141', '131', '231', '241', '331', '431') THEN 'Thân thiết'
WHEN CONCAT(r_score, f_score, m_score) IN ('223', '224', '233', '413','414', '423', '124', '323', '123', '214', '213') THEN 'Tiềm năng'
ELSE 'Vãng lai'
END AS segment
FROM customer_rfm_score;
