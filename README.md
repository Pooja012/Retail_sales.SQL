# Retail_sales.SQL

## Project Overview

**Project Title** : Retail Sales Analysis

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
1.**Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2.**Data Cleaning**: Identify and remove any records with missing or null values.
3.**Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4.**Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Dataset used
- <a href="https://github.com/Pooja012/Retail_sales.SQL/blob/main/SQL%20-%20Retail%20Sales%20Analysis_utf%20%20(1).csv">Dataset</a>
## Dashboard
- <a href="https://github.com/Pooja012/Retail_sales.SQL/blob/main/DashBoard-RetailSalesAnalysis.s.xlsx">Dashboard</a>
## Questions
-*Write a SQL Query to retieve all columns for sales made on '05-11-2022'.*
-Write a SQL Query to retrieve all transactionns where the category is 'clothing' and the quamtity sold is more than 4 in the month of Nov 2022.
-Write a SQL Query to calculate the total sales (total_sale) for each category.
-Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-Write a SQL query to find all transactions where the total-sale is greater than 1000.
-Write a SQL query to find the total number of transactions (ï»¿transactions_id) made by each gender in each category.
-Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
-Write a SQL query to find the top 5 customers based on the highest total sales.
-Write a SQL query to find the number of unique customers who purchased items from each category.
-Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon Between 12 &17, Evening > 17).

## Project Structure

### Data Exploration & Cleaning
- **Record Count**:Determine the total number of records in the dataset.
- **Customer Count**:Find out how many unique customers are in the dataset.
- **Category Count**:Identify all unique product categories in the dataset.
- **Null Value Check**:Check for any null values in the dataset and delete records with missing data.

``` sql

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

```

### Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1.**Write a SQL query to retrieve all columns for sales made on '2022-11-05:**
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
2.**Write a SQL Query to retrieve all transactionns where the category is 'clothing' and the quamtity sold is more than 4 in the month of Nov 2022.**
```sql
SELECT *
FROM `sales`.`retail sales`
where category = 'Clothing'
AND 
sale_date like'%-11-2022'
AND quantiy >= 4
;
```
3.**Write a SQL Query to calculate the total sales (total_sale) for each category.**
```sql
SELECT 
category,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM `sales`.`retail sales`
group by category;
```

4.**Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
SELECT 
round(AVG(age), 2)
FROM `sales`.`retail sales`
WHERE category = 'Beauty';
```
5.**Write a SQL query to find all transactions where the total-sale is greater than 1000.**
``` sql
SELECT * FROM `sales`.`retail sales`
WHERE total_sale > 1000;
```

6.**Write a SQL query to find the total number of transactions (ï»¿transactions_id) made by each gender in each category.**
```sql
SELECT category, gender,
COUNT(*) as total_transactions
FROM `sales`.`retail sales`
group by category, gender;
```

7.**Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**
```sql
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
```

8.**Write a SQL query to find the top 5 customers based on the highest total sales.**
```sql
SELECT 
customer_id,
SUM(total_sale) as total_sales
FROM `sales`.`retail sales`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```
9.**Write a SQL query to find the number of unique customers who purchased items from each category.**
```
SELECT 
category,
COUNT(distinct customer_id) as cnt_unique_cus
FROM `sales`.`retail sales`
group by category;
```

10.**Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon Between 12 &17, Evening > 17).**
```sql
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
```
## Findings
- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**:Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**:Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports
- **Sales Summary**: detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**:Insights into sales trends across different months and shifts.
- **Customer Insights**:Reports on top customers and unique customer counts per category.

## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Dash board
![image](https://github.com/user-attachments/assets/5613a320-b5ba-4a0d-a691-427acc7549de)

**Thank you**

