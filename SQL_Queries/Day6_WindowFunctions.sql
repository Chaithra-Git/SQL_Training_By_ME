-- OVER()

SELECT 
first_name,
title, 
COUNT(employee_id) over(partition by title order by title)  AS total_employees
FROM
employees;





-- RANK & DENSE RANK
-- Rank products by price within each category
SELECT 
    category_id,
    product_name,
    unit_price,
    RANK() OVER (
        PARTITION BY category_id 
        ORDER BY unit_price DESC,product_name DESC
    ) as price_rank
FROM 
    products
WHERE 
    discontinued = 0
ORDER BY 
    category_id,
    price_rank;


SELECT 
    category_id,
    product_name,
    unit_price,
   DENSE_RANK() OVER (partition by category_id order by unit_price DESC) as price_rank
FROM
	products
WHERE 
    discontinued = 0
ORDER BY 
    category_id,
    price_rank;

-- ROW NUMBER

SELECT 
    category_id,
    product_name,
    unit_price,
   ROW_NUMBER() OVER (partition by category_id order by unit_price DESC) as price_rank
FROM
	products
WHERE 
    discontinued = 0
ORDER BY 
    category_id,
    price_rank;





  