# Retail_sales_sql

Project overview
project title: Retail sales Analysis
database: rs

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyse retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

Project structure
Database setup
•	Database Creation: The project starts by creating a database named rs.
•	Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
```sql
    create database rs;
    use rs;
    
    select * from retailsales;
    
    select count(*) from retailsales;
```
-- Data cleaning
```sql
  select * from retailsales
  where 
  transactions_id is null
  or
  sale_date is null
  or
  sale_time is null
  or
  customer_id is null
  or
  gender is null
  or
  age is null
  or
  category is null
  or
  price_per_unit is null
  or
  cogs is null
  or
  total_sale is null
  ;
```

-- Data exploration
-- How many sales we have
```sql
  select count(*) as total_sales
  from retailsales;
```

-- How many unique customers we have?
```sql
  select count(distinct customer_id)
  from retailsales;
```

-- How many unique category we have?
```sql
  select count(distinct category) as Total_category
  from retailsales;
```

-- Data analysis and business key problems and answers
-- Write a SQL query to retrieve all colomns for sales mode on 2022 11 05
```sql
  select * from retailsales
  where sale_date = '2022-11-05';

```

-- Write a SQL query to retrieve all transactions where the category is clothing and the quantity sold is more than 10 in the month of November 2022
```sql
  select sale_date, category, quantiy from retailsales
  where category = 'Clothing' and
  year(sale_date) = 2022 and
  month(sale_date) = 11 and
  quantiy >= 4;
```

-- Write a SQL query to calculate the total sales (total sales) for each category 
```sql
  select category, sum(total_sale) as Net_sale, 
  count(*) as Total_orders
  from retailsales
  group by 1;
```

-- write a sql query to find the average age of customers who purchased items from The beauty category
```sql
  select round(avg(age), 2)
  from retailsales
  where category = 'beauty';
```

-- Write a SQL query to find all transactions where the total sale is greater than 1000
```sql
  select * from retailsales
  where total_sale > 1000;
```

-- Write a sequel query to find the total number of transactions transaction ID made by each gender in each category
```sql
  select gender, category, count(*)
  from retailsales
  group by 1,2
  order by 1;
```

-- write a SQL query to calculate the average sale for each month find out best selling month in each year
```sql
  select year, month, avg_sale
   from (
  			select 
  			year(sale_date) as year,
  			month(sale_date) as month,
  			avg(total_sale) as avg_sale, 
  			rank() over (partition by year(sale_date) order by avg(total_sale) desc) as position
  			from retailsales
  			group by 1,2
  ) as sq
  where position = 1;
```

-- Write a sql query to find the top 5 customers based on the highest total sales
```sql
  select customer_id, sum(total_sale)
  from retailsales
  group by 1
  order by 2 desc
  limit 5;
```

-- Write is sql query to find the number of unique customer who purchased items from each category
```sql
select 
count(distinct customer_id), 
category from retailsales
group by 2;
```

-- Write a SQL query to create each shift and number of orders example morning less than or equal to 12, afternoon between 12 and 17 evenings greater than 17
```sql
  with hourly_sale
  as (
  select *,
  	case
  		when hour(sale_time) < 12  then 'morning'
  		when hour(sale_time) between 12 and 17 then 'afternoon'
  	else 'evening'
  	end as shift
  from retailsales
  )
  select shift, 
  count(*) as total_orders
  from hourly_sale
  group by shift
  order by 2 desc;
```

Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.
