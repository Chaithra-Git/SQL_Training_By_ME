CREATE VIEW vw_product_details AS
SELECT 
    p.product_id,
    p.product_name,
    p.unit_price,
    c.category_name
FROM 
    products p
    JOIN categories c ON p.category_id = c.category_id;




CREATE OR REPLACE FUNCTION handle_product_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Custom logic instead of direct update
    IF NEW.unit_price < 0 THEN
        RAISE EXCEPTION 'Price cannot be negative';
    END IF;

    -- Perform the actual update on the base table
    UPDATE products
    SET 
       
        unit_price = NEW.unit_price
    WHERE 
        product_id = OLD.product_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




-- Create the INSTEAD OF trigger
CREATE TRIGGER instead_of_product_update
INSTEAD OF UPDATE ON vw_product_details
FOR EACH ROW
EXECUTE FUNCTION handle_product_update();





-- Try updating through the view
UPDATE vw_product_details 
SET unit_price = 50.00 
WHERE product_id = 1;

-- Try with invalid price (will fail)
UPDATE vw_product_details 
SET unit_price = -5.00 
WHERE product_id = 1;


select * from products WHERE product_id = 1;




