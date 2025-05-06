CREATE OR REPLACE FUNCTION calculate_customer_orders(p_customer_id VARCHAR(5)) 
RETURNS TABLE (
    total_orders BIGINT,
    total_value DECIMAL(10,2),
    avg_order_value DECIMAL(10,2)
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(DISTINCT o.order_id) as total_orders,
        ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount))::DECIMAL, 2) as total_value,
        ROUND(AVG(od.quantity * od.unit_price * (1 - od.discount))::DECIMAL, 2) as avg_order_value
    FROM 
        orders o
        JOIN order_details od ON o.order_id = od.order_id
    WHERE 
        o.customer_id = p_customer_id;
END;
$$;



SELECT * from calculate_customer_orders('ALFKI');















-- Usage Examples:
/*
-- Call function for a specific customer
SELECT * FROM calculate_customer_orders('ALFKI');

-- Use in a query
SELECT 
    c.company_name,
    co.total_orders,
    co.total_value
FROM 
    customers c
    CROSS JOIN calculate_customer_orders(c.customer_id) co
WHERE 
    c.country = 'Germany';
*/

