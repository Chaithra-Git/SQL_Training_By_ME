-- STABLE function - results won't change within a transaction
CREATE OR REPLACE FUNCTION get_product_revenue(
    p_product_id INT
)
RETURNS DECIMAL(10,2)
STABLE    -- Adding volatility declaration
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (
        SELECT COALESCE(SUM(od.quantity * od.unit_price), 0)
        FROM order_details od
        WHERE od.product_id = p_product_id
    );
END;
$$;

-- VOLATILE function - modifies database
CREATE OR REPLACE FUNCTION update_product_price(
    p_product_id INT,
    p_new_price DECIMAL(10,2)
)
RETURNS VOID
VOLATILE    -- Default, but good to be explicit
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE products 
    SET unit_price = p_new_price 
    WHERE product_id = p_product_id;
END;
$$;

-- IMMUTABLE function - always same result for same input
CREATE OR REPLACE FUNCTION calculate_discount(
    price DECIMAL,
    discount_percent INT
)
RETURNS DECIMAL
IMMUTABLE    -- Same inputs always give same output
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN price * (1 - discount_percent::DECIMAL / 100);
END;
$$;