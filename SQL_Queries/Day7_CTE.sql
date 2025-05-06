WITH cte_product_rank AS 
(SELECT 
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
    price_rank)

SELECT
	category_id,
    product_name,
	price_rank
FROM cte_product_rank
where price_rank <=2;



--  Analyze high-value orders and their customers:
WITH cte_highvalueorders AS (
    SELECT 
        customer_id,
        COUNT(*) as order_count,
        SUM(freight) as total_freight
    FROM 
        orders
    WHERE 
        freight > 100
    GROUP BY 
        customer_id
)
SELECT 
    c.company_name,
    c.contact_name,
    h.order_count as expensive_shipments,
    ROUND(h.total_freight::numeric, 2) as total_shipping_cost
FROM 
    customers c
    JOIN cte_highvalueorders h ON c.customer_id = h.customer_id
WHERE 
    h.order_count > 3
ORDER BY 
    h.total_freight DESC;



-- Recursive
WITH RECURSIVE cte_employeehierarchy AS (
    -- Base case: employee with no manager (top level)
SELECT 
	employee_id,
	first_name,
	last_name,
	reports_to,
	0 as level
FROM 
	employees e
WHERE 
	reports_to IS NULL

UNION ALL
-- Recursive case: employees reporting to managers
SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	e.reports_to,
	eh.level+1 
FROM
employees e
JOIN
cte_employeehierarchy eh
ON 
eh.employee_id = e.reports_to
)

SELECT 
level,
employee_id,
first_name || ' ' || last_name as employee_name
FROM
cte_employeehierarchy
ORDER BY
level,employee_id;

select employee_id, first_name,reports_to from employees;

