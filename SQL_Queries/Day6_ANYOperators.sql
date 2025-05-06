-- ANY Operator
-- Find Products More Expensive Than Any Product in Category 1
SELECT 
    product_name,
    category_id,
    unit_price
FROM 
    products 
WHERE 
    category_id != 1
    AND unit_price > ANY (
        SELECT unit_price
        FROM products 
        WHERE category_id = 1
    )
ORDER BY 
    unit_price;


-- ALL Operator
SELECT 
    product_name,
    category_id,
    unit_price
FROM 
    products 
WHERE unit_price < ALL (
        SELECT unit_price
        FROM products 
		WHERE category_id = 1       
    )
ORDER BY 
    unit_price;

-- EXISTS

-- Example: Find customers who have placed orders 
SELECT 
    company_name,
    contact_name,
    country
FROM 
    customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY 
    company_name;

-- Find inactive customers (customers with no orders)
SELECT 
    company_name,
    contact_name,
    country
FROM 
    customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY 
    company_name;

-- EXISts & NULL

SELECT 
    company_name,
    contact_name,
    country
FROM 
    customers c
WHERE  EXISTS (
    Select NULL
)
ORDER BY 
    company_name;