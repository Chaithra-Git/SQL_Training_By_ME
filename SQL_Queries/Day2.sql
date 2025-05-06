CREATE TABLE categories (
  categoryID INT PRIMARY KEY,
  categoryName VARCHAR(50) NOT NULL,
  description text
);

CREATE TABLE customers (
  	customerID VARCHAR(5) PRIMARY KEY,
    companyName VARCHAR(40) NOT NULL,
    contactName VARCHAR(30),
    contactTitle VARCHAR(30),    
    city VARCHAR(15),   
    country VARCHAR(15)    
);



CREATE TABLE shippers (
    shipperID smallint PRIMARY KEY,
    companyName VARCHAR(40) NOT NULL    
);


CREATE TABLE products (
  productid INT PRIMARY KEY,
  productName VARCHAR (50) NOT NULL,
  quantityPerUnit VARCHAR (50),
  unitPrice NUMERIC,
  discontinued INT NOT NULL,
  categoryID INT,
  FOREIGN KEY(categoryID) REFERENCES categories(categoryID) 
);

CREATE TABLE employees (
    employeeID INT PRIMARY KEY,
    employeeName VARCHAR(20) NOT NULL,   
    title VARCHAR(30),   
    city VARCHAR(15),   
    country VARCHAR(15), 
	reportsTo INT,
    FOREIGN KEY(reportsTo) REFERENCES employees(employeeID)    
);

CREATE TABLE orders (
    order_id smallint primary key NOT NULL,
    customerid character varying(5),
    employeeid smallint,
    order_date date,
    required_date date,
    shipped_date date,
    shipperid smallint,
    freight real,    
	FOREIGN KEY(employeeid) references employees(employeeID),
	FOREIGN KEY(customerid) references customers(customerID),
	FOREIGN KEY(shipperid) references shippers(shipperID)
);


CREATE TABLE order_details (
    order_id smallint NOT NULL,
    productid smallint NOT NULL,
    unit_price real ,
    quantity smallint,
    discount real NOT NULL,
	PRIMARY KEY(order_id,productid),
	FOREIGN KEY(order_id) references orders(order_id),
	FOREIGN KEY(productid) references products(productid) ON DELETE CASCADE
);

select * from orders;

select * 
from customers
limit 5;



-- Querying the Data

select * from customers
limit 5;

select 
customerID,companyName,contactName 
from 
customers
limit 5;


SELECT
employeeID,
employeeName || ' - ' || title AS employee_profile
FROM
employees
limit 8;

-- ORDER BY

SELECT
employeeName, reportsTo
FROM
employees
ORDER BY
reportsTo  NULLS FIRST;

SELECT
employeeID, employeeName, reportsTo
FROM
employees
ORDER BY
employeeName DESC;

SELECT
employeeID, employeeName, title, reportsTo
FROM
employees
ORDER BY
employeeName,
title DESC;


SELECT
DISTINCT title
FROM
employees

SELECT
DISTINCT title,city
FROM
employees
ORDER BY title;

-- FILTERING

select productname,discontinued
from
products
where discontinued=0;

select productname,unitPrice
from
products
where unitPrice > 20;


-- AND

SELECT customerID, companyName, country, contactTitle
FROM customers
WHERE country = 'Germany'
AND contactTitle = 'Sales Representative';

SELECT productId, productName, unitPrice, discontinued
FROM products
WHERE discontinued = 1
AND unitPrice > 50;


-- OR

SELECT companyName, contactName, contactTitle
FROM customers
WHERE contactTitle = 'Sales Representative'
OR contactTitle = 'Sales Agent';


-- LIMIT

select *
from 
categories
limit 4
offset 2

-- FETCH

SELECT employeeId, employeeName
FROM employees
ORDER BY employeeId
FETCH FIRST 3 ROWS ONLY;


SELECT employeeId, employeeName
FROM employees
ORDER BY employeeId
OFFSET 5 ROWS
FETCH NEXT 3 ROWS ONLY;

-- IN

SELECT customerId, companyName, country
FROM customers
WHERE country IN ('Germany', 'France', 'Brazil');

SELECT productId, productName, categoryId
FROM products
WHERE categoryId IN (1, 4, 7);

SELECT * FROM employees
WHERE country NOT IN ('USA');

--BETWEEN

SELECT productId, productName, unitPrice
FROM products
WHERE unitPrice BETWEEN 20 AND 50;

-- ISNULL

SELECT employeeId, employeeName
FROM employees
WHERE reportsTo IS NULL;


SELECT customerId, companyName
FROM customers
WHERE companyName LIKE 'A%';


SELECT employeeId, employeeName, title
FROM employees
WHERE title LIKE '%Sales%';

SELECT employeeId, employeeName
FROM employees
WHERE employeeName LIKE 'A_n%';

SELECT customerId, companyName
FROM customers
WHERE companyName NOT LIKE 'A%';


-- MODIFYING THE DATA

-- Update
UPDATE customers
SET contactTitle = 'Marketing Manager'
WHERE customerId = 'ANATR';


select * from customers where customerId = 'ANATR';



-- UPSERT
select * from customers where customerId= 'NEW02';

INSERT INTO customers (customerId, companyName, contactName)
VALUES ('NEW02', 'NewCompany Ltd', 'Bob')
ON CONFLICT (customerId)
DO UPDATE
SET contactName = EXCLUDED.contactName,
    companyName = EXCLUDED.companyName;

INSERT INTO customers (customerId, companyName, contactName)
VALUES ('NEW02', 'NewCompany2 Ltd', 'Peter')
ON CONFLICT (customerId)
DO UPDATE
SET contactName = EXCLUDED.contactName,
    companyName = EXCLUDED.companyName;


-- Merge

MERGE INTO products p
USING (
    VALUES 
        (1, 'Updated Tea','10 boxes x 20 bags', 35.00,0,1),
        (100, 'New Black Tea','24 cans', 28.00,2,1)
) AS incoming(productId, productName, quantityPerUnit, unitPrice,discontinued, categoryId)
ON p.productId = incoming.productId
WHEN MATCHED THEN
    UPDATE SET 
        productName = incoming.productName,
        unitPrice = incoming.unitPrice
WHEN NOT MATCHED THEN
    INSERT (productId, productName, quantityPerUnit, unitPrice,discontinued, categoryId)
    VALUES (incoming.productId,incoming.productName, incoming.quantityPerUnit,incoming.unitPrice,incoming.discontinued,incoming.categoryId);



select * from
products 
where 
productId IN(1,100)


-- Delete category id on delete cascade

delete from
categories
where categoryid = 3;


select * from products
where categoryid = 3;

select * from order_details
where productid IN (16,19,20,21,25);

