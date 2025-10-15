# PlantAgro Sales Dashboard

This repository documents the process of developing my personal project using SQL and Tableau Public.
The main goal of the project is to demonstrate my analytical, data preparation, and visualization skills through practical examples and interactive dashboards.

![Dashboard.pdf](https://github.com/user-attachments/files/22901990/Dashboard.pdf)

## Step 1. Setting Up and Cleaning Data
I started by downloading raw company data into a PostgreSQL database.
After that, I created the main fields and uploaded all relevant company information for further analysis.

## Step 2. Writing the Scripts
To clean, structure, and consolidate the required information, I wrote several SQL scripts using:
- JOIN and UNION functions
- Aggregation and data formatting
- CTEs (Common Table Expressions) for modular and readable queries.

SQL Code Snippets

'with u_tab as (
	select * 
    from sales_2024
    union
    select *
    from sales_2023
),
    tab_date as ( 
	select 
    u_tab.client_name,
	u_tab.sales_date,
	u_tab.goods,
	u_tab.producer,
	u_tab.manager,
	u_tab.payment_type,
	u_tab.purveyor,
	u_tab.qtity,
	u_tab.netto_price,
	u_tab.sales_price,
    u_tab.profit,
	goods.goods_group,
    goods.goods_subgroup 
from u_tab
left join goods
on u_tab.goods=goods.goods_name
), '
  

## Step 3. Downloading the tables
After preparing and validating the final tables, I exported them to CSV format and imported the files into Tableau Public for visualization.

![Image](https://github.com/user-attachments/assets/5ce93960-9276-462f-bee0-de64276322e8)


## Step 4. Creating the dashboards
The final step was creating interactive and user-friendly dashboards in Tableau Public.
I applied the following Tableau features and techniques:
- Level of Detail (LOD) Expressions
- Parameters for dynamic filtering and color changes
- Navigation Buttons
- Custom Shapes and Number Formatting.
