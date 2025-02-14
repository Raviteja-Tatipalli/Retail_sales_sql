create database rs;
use rs;

select * from retailsales;

select count(*) from retailsales;

-- data cleaning

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

-- Data exploration

-- How many sales we have

select count(*) as total_sales from retailsales;

-- How many unique customers we have?

select count(distinct customer_id) from retailsales;

-- How many unique category we have?

select count(distinct category) as Total_category from retailsales;

-- Data analysis and business key problems and answers

-- Write a SQL query to retrieve all colomns for sales mode on 2022 11 05

select * from retailsales
where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is clothing and the quantity sold is more than 10 in the month of November 2022

select sale_date, category, quantiy from retailsales
where category = 'Clothing' and
year(sale_date) = 2022 and month(sale_date) = 11
and quantiy >= 4;


-- Write a SQL query to calculate the total sales (total sales) for each category 

select category, sum(total_sale) as Net_sale, 
count(*) as Total_orders
from retailsales
group by 1;

-- write a sql query to find the average age of customers who purchased items from The beauty category

select round(avg(age), 2) from retailsales
where category = 'beauty';

-- Write a SQL query to find all transactions where the total sale is greater than 1000

select * from retailsales
where total_sale > 1000;

-- Write a sequel query to find the total number of transactions transaction ID made by each gender in each category

select gender, category, count(*) from retailsales
group by 1,2
order by 1;

-- write a SQL query to calculate the average sale for each month find out best selling month in each year
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

-- Write a sql query to find the top 5 customers based on the highest total sales

select customer_id, sum(total_sale)
from retailsales
group by 1
order by 2 desc
limit 5;

-- Write is sql query to find the number of unique customer who purchased items from each category

select 
count(distinct customer_id), 
category from retailsales
group by 2;

-- Write a SQL query to create each shift and number of orders example morning less than or equal to 12, afternoon between 12 and 17 evenings greater than 17
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




