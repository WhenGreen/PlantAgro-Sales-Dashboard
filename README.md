# PlantAgro Sales Dashboard

This repository documents the process of developing my personal project using SQL and Tableau Public.
The main goal of the project is to demonstrate my analytical, data preparation, and visualization skills through practical examples and interactive dashboards.

![Dashboard.pdf](https://github.com/user-attachments/files/22901990/Dashboard.pdf)

Full version of this report you can find <a href="https://public.tableau.com/app/profile/maria.vengrin/viz/Companyprjct/Dashboard?publish=yes">here</a>.

## Step 1. Setting Up and Cleaning Data
I started by downloading raw company data into a PostgreSQL database.
After that, I created the main fields and uploaded all relevant company information for further analysis.

## Step 2. Writing the Scripts
To clean, structure, and consolidate the required information, I wrote several SQL scripts using:
- JOIN and UNION functions
- Aggregation and data formatting
- CTEs (Common Table Expressions) for modular and readable queries.

### *SQL Code Snippets*

```sql
select *
from goods
limit 10;

select *
from payments_2024
limit 10;

select *
from sales_plan_2024
limit 10;

select *
from sales_2024
limit 10;

select *
from sales_2023
limit 10;
```

```sql
with u_tab as (
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
),  
```   

```sql
 s_tab as (	
       select 
	   client_name,
	   to_timestamp(sales_date, 'DD.MM.YYYY HH24:MI:SS')::date 
	             as date_of_sales,
    	goods,
	    producer,
	    manager,
     	payment_type,
    	purveyor,
	    qtity,
	    netto_price,
        sales_price,
        profit,
	    goods_group,
        goods_subgroup 
 from tab_date
``` 

```sql
select
	client_name,
	date_of_sales,
	goods,
	producer,
	manager,
	payment_type,
	purveyor,
	qtity,
	netto_price,
    sales_price,
    profit,
	goods_group,
    goods_subgroup,
	 case when date_of_sales < DATE '2023-11-01'
	      then 2023 else 2024
	 end as season,
	to_char(date_of_sales, 'Mon') AS sales_month,
    
    -- Month number starting November as 1
    ((EXTRACT(MONTH FROM date_of_sales)::int + 2 - 1) % 12) + 1 AS season_month_num
    
	from s_tab;
``` 

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
