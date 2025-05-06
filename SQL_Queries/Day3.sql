-- UPDATE

UPDATE employees
SET city = 'Manchester', country = 'UK'
WHERE employeeName = 'Nancy Davolio';

Update products
Set unitprice = unit_price =unit_price * 1.10
Where categoryid = 2;

UPDATE customers
SET contactTitle = 'Marketing Manager'
WHERE customerId = 'ANATR';


select * from customers where customerId = 'ANATR';


-- Delete

DELETE FROM shippers
WHERE shipperid = 2;


-- Update cascade

ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_products_categories;

\d products

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID)
ON UPDATE CASCADE
ON DELETE CASCADE;

INSERT INTO categories (categoryid, categoryname)
VALUES (101, 'Test Category');

INSERT INTO products (productid, productname, categoryid)
VALUES 
(201, 'Test Product A', 101),
(202, 'Test Product B', 101);


UPDATE categories
SET categoryID = 102
WHERE categoryID = 101;



DELETE FROM categories
WHERE categoryID = 102;


-- UPSERT
select * from customers where customerId= 'NEW03';

INSERT INTO customers (customerId, companyName, contactName)
VALUES ('NEW02', 'NewCompany Ltd', 'Bob')
ON CONFLICT (customerId)
DO UPDATE
SET contactName = EXCLUDED.contactName,
    companyName = EXCLUDED.companyName;
	


-- Merge


MERGE INTO products p
USING (
    VALUES 
        (1, 'Updated Tea','10 boxes x 20 bags', 35.00,0,1),
        (100, 'New Black Tea','24 cans', 28.00,0,1)
		(101, 'Golden Herb Mustard','25 cans', 28.00,1,2)
) AS incoming(productId, productName, quantityPerUnit, unitPrice,discontinued, categoryId)
ON p.productId = incoming.productId
WHEN MATCHED AND incoming.discontinued = 1 THEN
    DELETE
WHEN MATCHED AND incoming.discontinued = 0 THEN
    UPDATE SET 
        productName = incoming.productName,
        unitPrice = incoming.unitPrice
WHEN NOT MATCHED incoming.discontinued = 0 THEN
    INSERT (productId, productName, quantityPerUnit, unitPrice,discontinued, categoryId)
    VALUES (incoming.productId,incoming.productName, incoming.quantityPerUnit,incoming.unitPrice,incoming.discontinued,incoming.categoryId);



select * from
products 
where 
productId IN(1,100)










