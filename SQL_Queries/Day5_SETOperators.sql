-- UNION

-- Find cities in Germany where we have customers or suppliers
SELECT city, country
FROM customers
WHERE country = 'Germany'

UNION

SELECT city, country
FROM suppliers
WHERE country = 'Germany'
ORDER BY city;

-- Example 2: UNION ALL (keeps duplicates)
SELECT city, country
FROM customers
WHERE country = 'Germany'

UNION ALL

SELECT city, country
FROM suppliers
WHERE country = 'Germany'
ORDER BY city;



-- EXCEPT
-- Find cities where we have customers but no suppliers
SELECT city, country
FROM customers
WHERE country IN ('USA', 'UK')

EXCEPT

SELECT city, country
FROM suppliers
WHERE country IN ('USA', 'UK')
ORDER BY city;


-- Find cities that have both customers and suppliers
SELECT city, country
FROM customers
WHERE country IN ('USA', 'UK', 'Germany')

INTERSECT

SELECT city, country
FROM suppliers
WHERE country IN ('USA', 'UK', 'Germany')
ORDER BY city;