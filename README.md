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
