-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;


---------- Create table ----------
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

---------- Feature Engineering ---------- 

-- Add the time_of_day column -- 
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);


-- Add day_name column -- 

SELECT
	date,
	DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);


-- Add month_name column --

SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

 ---------------------------- Generic Questions ------------------------------

1. How many different cities are present in the dataset?
SELECT 
	DISTINCT city
FROM sales;

2. In which city is each branch situated?
SELECT 
	DISTINCT city,
    branch
FROM sales;


---------------------------- Product Analysis -------------------------------

1. How many unique product lines does the data have?

SELECT
	DISTINCT product_line
FROM sales;

2. What is the most common payment method?
  
SELECT
DISTINCT(payment_method) as payments,
COUNT(*) as times
FROM sales
GROUP BY payments
ORDER BY times DESC


3. What is the most selling product line 
  
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

4. What is the total revenue by month? 
  
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue DESC;


5. Which month recorded the highest Cost of Goods Sold (COGS)?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs DESC;


6. Which product line generated the highest revenue?
  
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

7. Which city has the highest revenue?
  
SELECT
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;


8. Which product line incurred the highest VAT?
  
SELECT
	product_line,
	AVG(VAT) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

9. Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' based on whether its sales are above the average.

WITH product_avg_sales AS (SELECT
product_line,
AVG(total) as avg_sales
FROM sales
GROUP BY product_line),

overall_avg_sales AS (
SELECT
AVG(total) as overall_avg FROM sales)

SELECT
p.product_line,
p.avg_sales,
CASE 
WHEN p.avg_sales > o.overall_avg THEN 'Good'
WHEN p.avg_sales < o.overall_avg THEN 'Bad' END AS rating
FROM product_avg_sales as p
JOIN overall_avg_sales as o ;

10. Which branch sold more products than average product sold?
  
SELECT
product_line,
SUM(VAT) as total_VAT
FROM sales
GROUP BY product_line
ORDER BY total_VAT DESC



11. What is the most common product line by gender?
  
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_count
FROM sales
GROUP BY gender, product_line
ORDER BY total_count DESC;

12. What is the average rating of each product line?
  
SELECT 
product_line,
ROUND(AVG(rating),2) as avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC

---------------------------- Sales Analysis ---------------------------------

1. Number of sales made in each time of the day per weekday.

SELECT 
COUNT(*) as sales_count,
time_of_day
FROM sales
WHERE day_name != 'Saturday' AND day_name != 'Sunday'
GROUP BY time_of_day
ORDER BY sales_count DESC

2. Identify the customer type that generates the highest revenue.

SELECT
customer_type,
SUM(total) as total_revenue 
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC


3. Which city has the largest tax percent/ VAT (Value Added Tax)?
  
SELECT
city,
ROUND(AVG(VAT),2) as avg_vat
FROM sales
GROUP BY city
ORDER BY avg_vat DESC


4. Which customer type pays the most VAT?

SELECT
customer_type,
ROUND(AVG(VAT),2) as avg_vat
FROM sales
GROUP BY customer_type
ORDER BY avg_vat DESC

-------------------------- Customer Analysis -------------------------------

1. How many unique customer types does the data have?
  
SELECT
DISTINCT(customer_type) as unique_customers
from sales

2. How many unique payment methods does the data have?
  
SELECT
	DISTINCT (payment_method) as unique_payment_method
FROM sales;

3. Which is the most common customer type?
  
SELECT
customer_type,
COUNT(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC
LIMIT 1;

4.  Which customer type buys the most?
  
SELECT
customer_type,
COUNT(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC

5. What is the gender of most of the customers?
  
SELECT
	gender,
	COUNT(*) as gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC

6. What is the gender distribution per branch?
  
SELECT 
branch,
gender,
COUNT(*) as gender_count
FROM sales
GROUP BY branch, gender

7. Which time of the day do customers give most ratings?
  
SELECT
time_of_day,
AVG(rating) as avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC

8.  Which time of the day do customers give most ratings per branch?
  
SELECT
branch,
time_of_day,
AVG(rating) as avg_rating
FROM sales
GROUP BY branch, time_of_day
ORDER BY avg_rating DESC


9. Which day of the week has the best avg ratings?
  
SELECT
day_name,
AVG(rating) as avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC

10. Which day of the week has the best average ratings per branch?
  
SELECT
day_name,
branch,
AVG(rating) as avg_rating
FROM sales
GROUP BY day_name,branch
ORDER BY avg_rating DESC
