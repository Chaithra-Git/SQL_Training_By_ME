-- No of orders handled by employee in each year

SELECT 
  employee_id, 
  EXTRACT(YEAR FROM order_date) AS order_year, 
  COUNT(*) AS orders_handled
FROM orders
GROUP BY employee_id, order_year
ORDER BY employee_id, order_year;


-- Minimum and Maximum Product Prices per Category

SELECT 
    c.category_name,
    MIN(p.unit_price) AS min_price,
    MAX(p.unit_price) AS max_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;



-- Group products by category_id, calculate the no.of products in each category and avg unit price in each category

SELECT 
c.category_id, 
c.category_name,
COUNT(product_id) AS num_products, 
ROUND(AVG(unit_price):: numeric,2) AS avg_price
FROM categories c
INNER JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_id
ORDER BY c.category_id;

