-- This trigger:
-- Creates an audit log table to track changes
-- Fires after each new product insertion
-- Records:
-- Product details
-- Action type
-- Timestamp
-- User who made the change
-- Price information
-- Helps maintain a history of product additions



-- First create the history table
CREATE TABLE product_audit_log (
    log_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    action_type VARCHAR(20),
    action_date TIMESTAMP,
    user_name VARCHAR(50),
    new_price DECIMAL(10,2)
);


-- 1. Define the trigger function
CREATE OR REPLACE FUNCTION log_new_product()
RETURNS TRIGGER AS $$
BEGIN

    -- 2. Insert into audit log table
    INSERT INTO product_audit_log (
        product_id,        -- Product identifier
        product_name,      -- Name of the product
        action_type,       -- What operation occurred (INSERT)
        action_date,       -- When it happened
        user_name,         -- Who did it
        new_price         -- New price value
    )
    VALUES (
        NEW.product_id,    -- NEW refers to the newly inserted row
        NEW.product_name,  -- Get product name from new row
        'INSERT',          -- Static value indicating insert operation
        CURRENT_TIMESTAMP, -- Current date and time
        CURRENT_USER,      -- Username of current database user
        NEW.unit_price    -- Price from new row
    );

    -- 3. Return the NEW row
    RETURN NEW;           -- Required for AFTER triggers
END;
$$ LANGUAGE plpgsql;      -- Specify PL/pgSQL language







-- Create the trigger
CREATE TRIGGER after_product_insert
AFTER INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION log_new_product();



-- Test the trigger with:
INSERT INTO products (product_id,product_name, supplier_id, category_id, unit_price,discontinued)
VALUES (85,'Test Product_85', 1, 1, 25.00,0);




select * from product_audit_log;



