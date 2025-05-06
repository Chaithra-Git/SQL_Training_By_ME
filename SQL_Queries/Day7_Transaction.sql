-- Start a transaction to update product prices
BEGIN;

-- Update prices for beverages (category_id = 1)
UPDATE products 
SET unit_price = unit_price * 1.10
WHERE category_id = 1;

-- Check if any product price exceeds $50
-- If yes, rollback; if no, commit
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM products 
        WHERE category_id = 1 AND unit_price > 50
    ) THEN
        RAISE EXCEPTION 'Some prices exceed $50';
        
    ELSE
        RAISE NOTICE 'Price update successful.';
        
    END IF;
END $$;
-- Commit the transaction (only if not already rolled back)
COMMIT;

ROLLBACK;



select* from products where category_id = 1 and unit_price>40;