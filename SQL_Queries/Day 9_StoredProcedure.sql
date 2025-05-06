CREATE OR REPLACE PROCEDURE update_stock_by_category(p_category_id INT,p_new_stock INT)
LANGUAGE plpgsql
AS $$

BEGIN
    -- Validate category exists
    IF NOT EXISTS (SELECT 1 FROM categories WHERE category_id = p_category_id) THEN
        RAISE EXCEPTION 'Category ID % does not exist', p_category_id;
    END IF;

    -- Update stock levels
    UPDATE products
    SET units_in_stock = GREATEST(0, p_new_stock)
    WHERE category_id = p_category_id
    AND discontinued = 0;

  
    -- Raise notice with results
    RAISE NOTICE 'Updated stock for  products in category %', 
         p_category_id;

END;
$$;

-- Example usage:
CALL update_stock_by_category(7, 45);








-- Stored procedure with INOUT parametes.
CREATE OR REPLACE PROCEDURE calculate_category_value(
    IN p_category_id INT,                   -- Input parameter    
    INOUT p_total_value DECIMAL DEFAULT 0             -- Input/Output parameter
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validate category exists
    IF NOT EXISTS (SELECT 1 FROM categories WHERE category_id = p_category_id) THEN
        RAISE EXCEPTION 'Category ID % does not exist', p_category_id;
    END IF;

    -- Calculate total value with markup
    SELECT 
	ROUND(CAST(SUM(unit_price * units_in_stock)as decimal),2)
    INTO p_total_value
    FROM products
    WHERE category_id = p_category_id
    AND discontinued = 0;

    END;
$$;


CALL calculate_category_value(2)

select * from products where category_id=7;





