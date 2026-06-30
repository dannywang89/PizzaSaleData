select * from pizza_sales

--Total Revenue
select round(sum(total_price),2) as Total_Revenue from pizza_sales

--Average Order Value
select round(sum(total_price)/count(distinct(order_id)),2) as avg_order_price from pizza_sales	

--Total Pizza Sold
select sum(quantity) as total_pizza_sold from pizza_sales

--Total Order
select count(distinct(order_id)) as total_orders from pizza_sales

--Average Pizza Per Order
select cast((sum(quantity)*1.0)/ (count(distinct(order_id)*1.0)) as decimal (10,2)) avg_pizza_per_order from pizza_sales


--Daily Trend
select DATENAME(dw, order_date) as order_day, count(distinct(order_id)) as total_orders
from pizza_sales
group by DATENAME(dw, order_date)

--Hourly Rate
select datepart(hh, order_time) as hour_of_day, count(distinct(order_id)) as total_orders
from pizza_sales
group by datepart(hh, order_time)
order by datepart(hh, order_time) 

--Pizza Popularity 
select distinct(pizza_category) as pizza_type, cast(sum(total_price) as decimal (10,2)) as total_revenue, cast(sum(total_price) * 100.0 / (select sum(total_price) from pizza_sales) as decimal (10,2)) as percentage_breakdown
from pizza_sales
group by pizza_category

--Pizza Size 
select pizza_size, cast(sum(total_price) as decimal (10,2)) as total_revenue, cast(sum(total_price) *100.0 / (select sum(total_price) from pizza_sales) as decimal (10,2)) as percentage_breakdown
from pizza_sales
group by pizza_size
order by 
case when pizza_size = 'S' Then 1
when pizza_size = 'M' Then 2
when pizza_size = 'L' Then 3
when pizza_size = 'XL' Then 4
when pizza_size = 'XXL' Then 5
else 6 end 

--Pizza per Category
select pizza_category, count(pizza_category) as total_quantity_sold
from pizza_sales
group by pizza_category
order by count(pizza_category) desc

--Top 5 Pizza Sold
select top 5 pizza_name, sum(quantity) as total_sold
from pizza_sales
group by pizza_name 
order by sum(quantity) desc

--Bottom 5 Pizza Sold
select top 5 pizza_name, sum(quantity) as total_sold
from pizza_sales
group by pizza_name 
order by sum(quantity) 
