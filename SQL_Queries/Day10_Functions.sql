CREATE OR REPLACE FUNCTION get_product_revenue(p_product_id INT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_revenue DECIMAL(10,2);
BEGIN
    -- Validate product exists
    IF NOT EXISTS (SELECT 1 FROM products WHERE product_id = p_product_id) THEN
        RAISE EXCEPTION 'Product ID % does not exist', p_product_id;
        RETURN 0;
    END IF;

    -- Calculate total revenue
    SELECT 
        COALESCE(ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount))::DECIMAL, 2), 0)
    INTO v_revenue
    FROM order_details od
    WHERE od.product_id = p_product_id;

    RETURN v_revenue;
END;
$$;



SELECT get_product_revenue(1);


SELECT 
    product_name,
    unit_price,
    get_product_revenue(product_id) as total_revenue
FROM products
WHERE discontinued = 0;







-- Usage Examples:
/*
-- Get revenue for a single product
SELECT get_product_revenue(1);

-- Use in a query
SELECT 
    product_name,
    unit_price,
    get_product_revenue(product_id) as total_revenue
FROM products
WHERE discontinued = 0;
*/