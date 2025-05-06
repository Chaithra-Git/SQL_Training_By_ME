-- Function 1: Get revenue by product ID
CREATE OR REPLACE FUNCTION get_product_revenue(
    p_product_id INT
)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (
        SELECT COALESCE(ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount))::DECIMAL, 2), 0)
        FROM order_details od
        WHERE od.product_id = p_product_id
    );
END;
$$;


select get_product_revenue(1)



-- Function 2: Get revenue by product ID and date range
CREATE OR REPLACE FUNCTION get_product_revenue(
    p_product_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (
        SELECT COALESCE(ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount))::DECIMAL, 2), 0)
        FROM order_details od
        JOIN orders o ON od.order_id = o.order_id
        WHERE od.product_id = p_product_id
        AND o.order_date BETWEEN p_start_date AND p_end_date
    );
END;
$$;


select get_product_revenue(1,'1996-07-04','1997-07-04')


-- Function 3: Get revenue by category ID
CREATE OR REPLACE FUNCTION get_product_revenue(
    p_category_id INT,
    p_discontinued INT
)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (
        SELECT COALESCE(ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount))::DECIMAL, 2), 0)
        FROM order_details od
        JOIN products p ON od.product_id = p.product_id
        WHERE p.category_id = p_category_id
        AND (p.discontinued=p_discontinued )
    );
END;
$$;

select * from orders;
select get_product_revenue(1,'1996-07-04','1997-07-04')

select get_product_revenue(1,0)