-- Min and MAX
Select 
MIN(unit_price) as min_price, 
MAX(unit_price) as max_price,
SUM(unit_price) as sum_unit_price,
COUNT(*) as no_of_products,
COUNT(product_id) as no_of_nonnull_products
from products


Select 
category_id,
MIN(unit_price) as min_price, 
MAX(unit_price) as max_price,
SUM(unit_price) as sum_unit_price,
COUNT(*) as no_of_products,
COUNT(product_id) as no_of_nonnull_products
from products
GROUP BY category_id
ORDER BY category_id;


-- employees — Group by title

SELECT 
title, COUNT(*) AS total_employees
FROM
employees
GROUP BY 
title;

-- employees — Group by title where/having clause

SELECT 
title, COUNT(*) AS total_employees
FROM
employees
GROUP BY 
title
HAVING title='Sales Representative';



SELECT 
title, COUNT(*) AS total_employees
FROM
employees
WHERE title='Sales Representative'
GROUP BY 
title;

select * from employees;


-- order_details — Group by product (top-selling products)

SELECT product_id,SUM(quantity) AS total_units_sold
FROM order_details 
GROUP BY product_id
ORDER BY total_units_sold DESC
LIMIT 10;




-- show total freight costs by country, but only for orders shipped in 1997:
SELECT 
    ship_country,	
    COUNT(*) as order_count,
    ROUND(SUM(freight)::numeric, 2) as total_freight	
FROM 
    orders
WHERE 
    EXTRACT(YEAR FROM order_date) = 1997
GROUP BY 
    ship_country
ORDER BY 
    total_freight DESC;

select * from orders limit 10;
	

-- shows cities with high shipping activity (more than 10 orders and freight costs over $1000):
SELECT 
    ship_city,
    COUNT(*) as number_of_orders,
    ROUND(SUM(freight)::numeric, 2) as total_freight
FROM 
    orders
GROUP BY 
    ship_city
HAVING 
    COUNT(*) > 10 
    AND SUM(freight) > 1000
ORDER BY 
    total_freight DESC


-- Group by both columns
SELECT 
    category_id,
    discontinued,
    COUNT(*) as product_count
FROM 
    products
GROUP BY 
    category_id, discontinued









