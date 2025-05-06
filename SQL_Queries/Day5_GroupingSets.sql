-- UNION ALL

-- Group by category & dicsontinued
SELECT 
    category_id,
     discontinued,
    COUNT(*) as product_count
FROM 
    products
GROUP BY 
    category_id,
	discontinued
UNION ALL
-- Group by category only
SELECT 
    category_id,
    NULL as discontinued,
    COUNT(*) as product_count
FROM 
    products
GROUP BY 
    category_id	

UNION ALL
-- Grand total
SELECT 
    NULL as category_id,
    NULL as discontinued,
    COUNT(*) as product_count
FROM 
    products
ORDER BY 
    category_id ,
    discontinued ;


-- GROUPING SETS (Equivalent to UNION ALL)
SELECT 
    category_id,
    discontinued,
    COUNT(*) as product_count
FROM 
    products
GROUP BY GROUPING SETS (
    (category_id, discontinued),  -- Group by both columns
    (category_id),               -- Group by category only
    ()                          -- Grand total
)
ORDER BY 
    category_id ,
    discontinued ;




-- ROLL UP (Equivalent to UNION ALL)
SELECT 
    category_id,
    discontinued,
    COUNT(*) as product_count
FROM 
    products
GROUP BY ROLLUP(category_id, discontinued)   -- Group by both columns,Group by category only,  Grand total    
ORDER BY 
    category_id ,
    discontinued ;



-- CUBE

SELECT 
    category_id,
    supplier_id,
    product_id,
    COUNT(*) as product_count   
FROM 
    products
GROUP BY CUBE (
    category_id,
    supplier_id,
    product_id
)
ORDER BY 
    category_id,
    supplier_id,
    product_id;



