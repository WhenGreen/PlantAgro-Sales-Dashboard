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


-- union tables
with u_tab as (
	select * 
    from sales_2024
    union
    select *
    from sales_2023
),
-- join main table with goods info 
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
-- converting to date format
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
)
-- setting sales periods (seasons)
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