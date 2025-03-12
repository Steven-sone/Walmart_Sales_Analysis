# Walmart_Sales_Data_Analysis_SQL_Project

## About

We are examining Walmart's sales data to pinpoint top-performing branches and products, analyze sales trends across different items, and gain insights into customer purchasing behavior. The main goal is to refine and optimize sales strategies. This analysis is based on a dataset from the Kaggle Walmart Sales Forecasting Competition.

## Project Goal

The primary objective of this project is to derive insights from Walmart's sales data by exploring the key factors that impact sales across different branches.

## About Data 

This project utilizes data from the Kaggle Walmart Sales Forecasting Competition, comprising sales transactions from three Walmart branches located in Mandalay, Yangon, and Naypyitaw. The dataset includes 17 columns and 1,000 rows.

| Column | Description | Data Type |
|----------|----------|----------|
| invoice_id   | Invoice of the sales made   | VARCHAR(30)   |
| branch   | Branch at which sales were made   | VARCHAR(5)   |
| city   | The location of the branch   | VARCHAR(30)   |
| customer_type | The type of the customer |  VARCHAR(30) |
| gender | Gender of the customer making purchase | VARCHAR(10) |
| product_line | Product line of the product sold | VARCHAR(100) |
| unit_price | The price of each product | DECIMAL (10, 2) |
| quantity | The amount of product sold | INT |
| VAT | The amount of tax on purchase | FLOAT (6, 4) |
| total | The total cost of the purchase | DECIMAL (12, 4) |
| date | The date on which the purchase was made | DATETIME | 
| time | The time at which the purchase was made| TIME |
| payment | The total amount paid | DECIMAL (10, 2) |
| cogs | Cost of Goods sold | DECIMAL (10, 2) |
| gross_margin_pct | Gross margin percentage | FLOAT (11, 9) |
| gross_income | Gross Income | DECIMAL (12, 4) |
| rating | Rating | FLOAT (2, 1) | 

## Analysis List 

1. Product Analysis
Conduct an analysis of the data to uncover insights into different product lines. The goal is to identify the top-performing product lines and highlight areas in need of improvement for other lines.

2. Sales Analysis
The purpose of this analysis is to examine the sales trends of the product, addressing key questions related to sales performance. The results will help evaluate the effectiveness of existing sales strategies and identify areas where adjustments are needed to boost sales.

3. Customer Analysis
This analysis focuses on identifying distinct customer segments, understanding their purchasing behaviors, and evaluating the profitability linked to each segment.

## Approach Used

1. Data Wrangling
In this initial phase, the data is thoroughly examined to identify any NULL or missing values. Appropriate strategies are implemented to handle and replace these values effectively.

Build a Database:
Create a table and populate it with the data.
Select columns that contain NULL values. However, no NULL values are present in our database, as the table creation process specified NOT NULL for each field, automatically filtering out any NULL entries.

2. Feature Engineering
Feature engineering allows us to create new columns from existing data, adding more insights to the dataset.

Time of Day:
Add a new column called time_of_day to categorize sales based on Morning, Afternoon, and Evening. This helps us identify which part of the day generates the most sales.

Day of the Week:
Add a column named day_name that extracts the day of the week from the transaction date (e.g., Mon, Tue, Wed, Thu, Fri). This provides insights into the busiest days of the week for each branch.

Month of the Year:
Add a new column month_name that extracts the month (e.g., Jan, Feb, Mar). This helps in determining which month generates the most sales and profit.

3. Exploratory Data Analysis (EDA)
Exploratory Data Analysis is conducted to explore the dataset and provide valuable insights that address the project's objectives and key questions.

## Business Questions to answer

### Generic Questions 

1. How many different cities are present in the dataset?
2. In which city is each branch situated?

### Product Analysis

1. How many distinct product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. Which month recorded the highest Cost of Goods Sold (COGS)?
6. Which product line generated the highest revenue?
7. Which city has the highest revenue?
8. Which product line incurred the highest VAT?
9. Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' based on whether its sales are above the average.
10. Which branch sold more products than average product sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?

### Sales Analysis

1. Number of sales made in each time of the day per weekday
2. Identify the customer type that generates the highest revenue.
3. Which city has the largest tax percent/ VAT (Value Added Tax)?
4. Which customer type pays the most VAT?

### Customer Analysis

1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. Which is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give most ratings?
8. Which time of the day do customers give most ratings per branch?
9. Which day of the week has the best avg ratings?
10. Which day of the week has the best average ratings per branch?
