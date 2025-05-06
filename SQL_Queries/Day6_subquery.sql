-- Find Orders from Most Recent Employee
SELECT 
    order_id,
    order_date
FROM 
    orders
WHERE 
    employee_id = (
        SELECT employee_id 
        FROM employees 
        ORDER BY hire_date DESC 
        LIMIT 1
    )
ORDER BY 
    order_date;




-- Find Products in Most Expensive Category
SELECT 
    product_name,
    unit_price
FROM 
    products
WHERE 
    category_id = (
        SELECT 
            category_id
        FROM 
            products
        GROUP BY 
            category_id
        ORDER BY 
            AVG(unit_price) DESC
        LIMIT 1
    )
ORDER BY 
    product_name;




-- Find customers who placed orders in 1997
SELECT 
    company_name,
    contact_name
FROM 
    customers
WHERE 
    customer_id IN (
        SELECT DISTINCT customer_id
        FROM orders
        WHERE EXTRACT(YEAR FROM order_date) = 1997
    )
ORDER BY 
    company_name;

	

-- Correlated Subquery
-- Find products more expensive than average price
-- The correlated subquery calculates the average unit price for category with the same category id as the current row in the outer query:
SELECT
	category_id,
    product_name,
    unit_price
FROM 
    products p
WHERE 
    unit_price > (
        SELECT AVG(unit_price)
        FROM products
		where category_id = p.category_id 
    )
ORDER BY 
    unit_price;