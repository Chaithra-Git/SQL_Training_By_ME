-- Show the difference between the consecutive orders for each customer
SELECT
customer_id,
order_id,
order_date,
lag(order_date,2,order_date) over(partition by customer_id order by order_date) as previous_order_date,
order_date - lag(order_date,2,order_date)over(partition by customer_id order by order_date) as days_since_last_order
FROM
orders;

-- Show the next expensive price and prodct in each category
SELECT
category_id,
product_id,
product_name,
unit_price,
lead(unit_price) over(partition by category_id order by unit_price) as next_higher_price,
lead(product_name) over(partition by category_id order by unit_price) as next_expensive_product
from 
products;


-- weekly Difference in no of orders handled by employees 
SELECT
employee_id,
count(order_id) as no_of_orders,
order_date,
lag(count(order_id),7) over (partition by employee_id order by order_date) as prev_week_orders,
count(order_id) - lag(count(order_id),7) over (partition by employee_id order by order_date) as diff_no_of_orders_handled
from orders
group by employee_id,order_date;


