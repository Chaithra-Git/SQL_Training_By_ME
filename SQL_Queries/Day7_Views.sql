-- CREATE VIEWS

CREATE VIEW vw_product_sales_summary AS
SELECT 
    p.product_name,
    c.category_name,
    SUM(od.quantity) as total_units_sold,
    SUM(od.quantity * od.unit_price) as total_revenue
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name;

select * from vw_product_sales_summary;


-- UPDATABLE VIEWS

CREATE VIEW vw_updatable_products AS
SELECT 
    product_id,
    product_name,
    unit_price,
    units_in_stock,
	discontinued
FROM products
WHERE discontinued = 0
WITH CHECK OPTION;




-- Insert into products table via vw_updatable_products View
INSERT INTO 
vw_updatable_products
(product_id,product_name,unit_price,units_in_stock,discontinued)
VALUES
(79,'UpdatedSampleTrainingProduct',60,100,0);



select * from products where  product_id=79;


-- Materialized views

CREATE MATERIALIZED VIEW customer_order_stats AS
SELECT 
    c.customer_id,
    c.company_name,
    COUNT(o.order_id) as total_orders,
    SUM(od.quantity * od.unit_price) as total_spent,
    MAX(o.order_date) as last_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.company_name
WITH DATA;

-- To refresh the materialized view:
-- REFRESH MATERIALIZED VIEW customer_order_stats;



-- RECURSIVE VIEW
CREATE VIEW vw_employeehierarchy AS
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

select * from vw_employeehierarchy;

