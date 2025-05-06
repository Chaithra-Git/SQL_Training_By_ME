-- Simple Cursor Example:
-- This cursor will iterate through products and adjust prices based on units in stock.


CREATE OR REPLACE PROCEDURE update_prices_with_cursor()
LANGUAGE plpgsql
AS $$
DECLARE
    product_cursor CURSOR FOR 
        SELECT product_id, product_name, unit_price, units_in_stock 
        FROM products 
        WHERE discontinued = 0;
    
    product_record RECORD;
    v_new_price DECIMAL(10,2);
BEGIN
    -- Open the cursor
    OPEN product_cursor;
    
    LOOP
        -- Fetch the next row
        FETCH product_cursor INTO product_record;
        
        -- Exit when no more rows to fetch
        EXIT WHEN NOT FOUND;
        
        -- Calculate new price
        IF product_record.units_in_stock < 10 THEN
            v_new_price := product_record.unit_price * 1.1; -- 10% increase
        ELSE
            v_new_price := product_record.unit_price * 0.95; -- 5% decrease
        END IF;
        
        -- Update the product
        UPDATE products 
        SET unit_price = ROUND(v_new_price, 2)
        WHERE product_id = product_record.product_id;
        
        -- Log the change
        RAISE NOTICE 'Updated % price from % to %', 
            product_record.product_name, 
            product_record.unit_price, 
            v_new_price;
    END LOOP;
    
    -- Close the cursor
    CLOSE product_cursor;
END;
$$;

-- To execute:
CALL update_prices_with_cursor();