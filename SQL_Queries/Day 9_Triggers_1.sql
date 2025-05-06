
-- Create the trigger function
CREATE OR REPLACE FUNCTION before_product_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Modify the NEW record before insert
    NEW.product_name = UPPER(NEW.product_name);
    -- Must return NEW for operation to continue
 

    -- You can also add validation
    IF NEW.unit_price < 0 THEN
        RAISE EXCEPTION 'Price cannot be negative';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;








-- Create the trigger
CREATE TRIGGER modify_product_name
BEFORE INSERT ON products
FOR EACH ROW 
EXECUTE FUNCTION before_product_insert();





-- Test the trigger
INSERT INTO products (product_id,product_name, unit_price, supplier_id, category_id,discontinued)
VALUES (86,'testiing product', 2.00, 1, 1,0);

-- Check result
SELECT * FROM products where product_id=86;