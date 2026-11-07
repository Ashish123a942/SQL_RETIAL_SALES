-- sql retail slaes analysis--
CREATE DATABASE sql_project_p2;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
transactions_id	INT ,
sale_date DATE ,
sale_time TIME ,
customer_id  INT ,
gender VARCHAR(15) ,
age INT ,
category VARCHAR(15) , 
quantiy INT ,  
price_per_unit FLOAT ,
cogs   FLOAT ,
total_sale FLOAT

);
SELECT * FROM retail_sales;
LIMIT 10

SELECT COUNT(*)
FROM retail_sales


SELECT * FROM retail_sales
WHERE 
  transactions_id IS NULL
 OR
  sale_time is null
  OR 
  gender IS NULL
  OR 
  category IS NULL
  OR 
  quantiy IS NULL
  OR
  cogs IS NULL
  OR
  total_sale IS NULL


  DELETE FROM retail_sales
WHERE 
  transactions_id IS NULL
 OR
  sale_time is null
  OR 
  gender IS NULL
  OR 
  category IS NULL
  OR 
  quantiy IS NULL
  OR
  cogs IS NULL
  OR
  total_sale IS NULL
  
-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE 

SELECT COUNT(*) as total_sales FROM retail_sales

-- HOW MANY  UNIQUE CUSTOMERS WE HAVE 

SELECT COUNT (DISTINCT customer_id) as total_sale FROM retail_sales

SELECT DISTINCT category FROM retail_sales


--data analysis & business key problems

--q1 write a sql query to retrive all coloums for sales mamde on 2022 11 05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- q2 write a sql query to retrive all transictions where the category is clothing and the qunatity sold is more than 10 in the month of NOV-2022.

SELECT
*
FROM retail_sales
WHERE
category = 'Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND 
quantiy >=4

-- q3 write down to a sql query to calculate the total_sales for each caategory.

SELECT 
category,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders

FROM retail_sales
GROUP BY 1


--Q4 WRITE A SQL QUERY TO FIND THE AVERAGE GE OF CUSTOMERS WHO PURCHSED ITEMS FROM 'BEAUTY' CATEGORY.

SELECT 
 ROUND (AVG(age) ,2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Q5 WRITE A SQL QUERY TO FIND ALL THE TRANSIXTIONS WHERE THE TOTAL_SALES IS GREATER THAN 1000.
SELECT * FRON retail_sales
WHERE TOTAL_SALES > 1000


-- Q6 WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSSICTIONS MADE BY EACH GENDER

SELECT 
category ,
gender,
COUNT(*) as total_trans

FROM retail_sales
GROUP 
BY
category,
gender
ORDER BY 1

-- Q7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT THE  BEST SAKE MOTH IN EACH YEAR
SELECT
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT (MONTH FROM sale_date) as Month,
AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC

-- WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES


SELECT 
customer_id,
SUM(total_sale) as total_sales
FROM retail_sales
group by 1
ORDER BY 2 DESC
LIMIT BY 5

-- WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS
with hourly_sale
AS
(
SELECT *, 
case 
     when extract (hour from sale_time) <12 then  'Morning'
	 when extract (hour from sale_time) between 12 and 17 then 'afternoon'
	 ELSE 'evening'
	 end as shift

FROM retail_sales
)
SELECT 
shift ,
count(*) as total_orders
FROM hourly_sale
GROUP BY SHIFT 

-- END OF PROJECT







