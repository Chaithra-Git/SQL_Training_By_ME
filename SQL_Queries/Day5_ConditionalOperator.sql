-- CASE

SELECT 
    product_name,
    unit_price,   
CASE 
	WHEN unit_price < 20 THEN 'Budget'
	WHEN unit_price < 50 THEN 'Mid-Range'
ELSE 
	'PREMIUM'
END AS price_category
FROM products;



SELECT
	E1.FIRST_NAME || ' ' || E1.LAST_NAME AS EMPLOYEE_NAME,	
CASE
	WHEN E2.FIRST_NAME || ' ' || E2.LAST_NAME ISNULL THEN 'No Manager'
	
ELSE E2.FIRST_NAME || ' ' || E2.LAST_NAME
	
END as MANAGER_NAME
FROM
	EMPLOYEES E1
	LEFT JOIN EMPLOYEES E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID;

-- Simple CASE form example
SELECT 
    product_name,
    discontinued,
CASE discontinued
   	WHEN 0 THEN 'Active'
	WHEN 1 THEN 'Discontinued'
    END as product_status   
 FROM 
    products
ORDER BY 
    unit_price;


-- COALESCE
SELECT
	E1.FIRST_NAME || ' ' || E1.LAST_NAME AS EMPLOYEE_NAME,	
	COALESCE(E2.FIRST_NAME || ' ' || E2.LAST_NAME, 'No Manager') as manager_name
	
FROM
	EMPLOYEES E1
	LEFT JOIN EMPLOYEES E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID;

	

-- NULLIF()

SELECT 
    order_id,
    quantity,
    discount,
    -- Returns NULL if quantity equals standard pack size of 10
    NULLIF(quantity, 10) as non_standard_quantity,
    -- Returns NULL if no discount (0)
    NULLIF(discount, 0) as actual_discount
FROM 
    order_details
WHERE 
    product_id < 10
ORDER BY 
    order_id;

-- CAST
SELECT 
    first_name,
    last_name,
    -- Convert reports_to to text before COALESCE
    COALESCE(CAST(NULLIF(reports_to, 2) AS VARCHAR), 'CEO') as reports_to
FROM 
    employees
ORDER BY 
    last_name;

