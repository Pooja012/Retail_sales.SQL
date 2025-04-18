-- SQL Retail Sales Analysis 

SELECT `retail sales`.`ï»¿Transactions_id`,
    `retail sales`.`sale_date`,
    `retail sales`.`sale_time`,
    `retail sales`.`customer_id`,
    `retail sales`.`gender`,
    `retail sales`.`age`,
    `retail sales`.`category`,
    `retail sales`.`quantiy`,
    `retail sales`.`price_per_unit`,
    `retail sales`.`cogs`,
    `retail sales`.`total_sale`,
    `retail sales`.`month`,
    `retail sales`.`year`,
    `retail sales`.`day`,
    `retail sales`.`minutes`,
    `retail sales`.`hours`
FROM `sales`.`retail sales`;




SELECT 
COUNT(*)
FROM `sales`.`retail sales`;

-- DATA CLEANING 

SELECT *
FROM `sales`.`retail sales`
WHERE ï»¿transactions_id is null
OR 
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;

-- 
DELETE FROM 
`sales`.`retail sales`
WHERE ï»¿transactions_id is null
OR 
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;

-- DATA EXPLORATION

-- how many sales we have?

SELECT 
COUNT(*) as total_sales 
FROM `sales`.`retail sales`;

-- how many customers we have?

SELECT 
COUNT(distinct customer_id) as total_sale 
FROM `sales`.`retail sales`;

-- how many categories we have?
SELECT 
COUNT(distinct category) as no_of_categories
FROM `sales`.`retail sales`;

-- DATA Analysis & Business Key Problems & Answers

-- MY ANALYSIS & FINDINGS

-- Q.1 Write a SQL Query to retieve all columns for sales made on '05-11-2022'
SELECT *
FROM `sales`.`retail sales`
WHERE sale_date = '05-11-2022';

-- Q.2 Write a SQL Query to retrieve all transactionns where the category is 'clothing' and the quamtity sold is more than 10 in the month of Nov 2022.
SELECT *
FROM `sales`.`retail sales`
where category = 'Clothing'
AND 
sale_date like'%-11-2022'
AND quantiy >= 4
;

-- Q.3 Write a SQL Query to calculate the total sales (total_sale) for each category.
SELECT 
category,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM `sales`.`retail sales`
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
round(AVG(age), 2)
FROM `sales`.`retail sales`
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total-sale is greater than 1000.
SELECT * FROM `sales`.`retail sales`
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (ï»¿transactions_id) made by each gender in each category.
SELECT category, gender,
COUNT(*) as total_transactions
FROM `sales`.`retail sales`
group by category, gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
WITH monthly_sales as (
SELECT year, 
month, 
AVG(total_sale) as avg_monthly_sale,
SUM(total_sale) as total_monthly_sale
FROM `sales`.`retail sales`
group by year, month
),

best_months as(
select year,
month,
avg_monthly_sale,
total_monthly_sale,
RANK() OVER(partition by year order by total_monthly_sale DESC) as rank_in_year
FROM monthly_sales
)
select year,
month,
avg_monthly_sale,
total_monthly_sale,
rank_in_year
FROM best_months
WHERE rank_in_year + 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
customer_id,
SUM(total_sale) as total_sales
FROM `sales`.`retail sales`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
category,
COUNT(distinct customer_id) as cnt_unique_cus
FROM `sales`.`retail sales`
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon Between 12 &17, Evening > 17).
WITH hourly_sale
AS
(
SELECT * ,
CASE
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END as shift
FROM `sales`.`retail sales`
)
SELECT 
shift,
COUNT(*) as total_orders
FROM hourly_sale
group by shift;

-- END of project






