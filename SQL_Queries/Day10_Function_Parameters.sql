CREATE OR REPLACE FUNCTION calculate_product_metrics(
    IN p_category_id INT,                        -- Input parameter
    INOUT p_total_products INT DEFAULT 0,        -- Input/Output parameter
    OUT p_avg_price DECIMAL(10,2),              -- Output parameter
    OUT p_total_value DECIMAL(10,2)             -- Output parameter
)
-- RETURNS record
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validate category exists
    IF NOT EXISTS (SELECT 1 FROM categories WHERE category_id = p_category_id) THEN
        RAISE EXCEPTION 'Category ID % does not exist', p_category_id;
    END IF;

    -- Get total products (updates INOUT parameter)
    SELECT COUNT(*)
    INTO p_total_products
    FROM products
    WHERE category_id = p_category_id;

    -- Calculate average price (sets OUT parameter)
    SELECT ROUND(AVG(unit_price)::DECIMAL, 2)
    INTO p_avg_price
    FROM products
    WHERE category_id = p_category_id;

    -- Calculate total value (sets OUT parameter)
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO p_total_value
    FROM products
    WHERE category_id = p_category_id;

    -- Display results
    RAISE NOTICE 'Category: %, Products: %, Avg Price: $%, Total Value: $%', 
        p_category_id, p_total_products, p_avg_price, p_total_value;
END;
$$;




 SELECT * from  calculate_product_metrics(2)









 

-- Usage Example:
/*
DO $$
DECLARE
    v_total_products INT := 0;
    v_avg_price DECIMAL;
    v_total_value DECIMAL;
BEGIN
    SELECT * FROM calculate_product_metrics(1, v_total_products, v_avg_price, v_total_value);
    RAISE NOTICE 'Results: Total=%, Avg=%, Value=%', 
        v_total_products, v_avg_price, v_total_value;
END;
$$;
*/


