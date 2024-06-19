/*
-- JOINS
- As the word suggests, Joins are used to combine two or more tables to get specific data/information.
- Join is mainly of 6 types:
1. Inner Join
2. Left Outer Join
3. Right Outer Join
4. Full Outer Join
5. Self Join
6. Cross Join
*/

-- Creating database
CREATE DATABASE IF NOT EXISTS amazon;

-- Using database
USE amazon;

-- Creating table Products - pid, pname, price, stock, location (Mumbai or Delhi)
CREATE TABLE IF NOT EXISTS products (
    pid INT(3) PRIMARY KEY,
    pname VARCHAR(50) NOT NULL,
    price INT(10) NOT NULL,
    stock INT(5),
    location VARCHAR(30) CHECK (location IN ('Mumbai', 'Delhi'))
);

-- Creating table Customer - cid, cname, age, addr
CREATE TABLE IF NOT EXISTS customer (
    cid INT(3) PRIMARY KEY,
    cname VARCHAR(30) NOT NULL,
    age INT(3),
    addr VARCHAR(50)
);

-- Creating table Orders - oid, cid, pid, amt
CREATE TABLE IF NOT EXISTS orders (
    oid INT(3) PRIMARY KEY,
    cid INT(3),
    pid INT(3),
    amt INT(10) NOT NULL,
    FOREIGN KEY (cid) REFERENCES customer(cid),
    FOREIGN KEY (pid) REFERENCES products(pid)
);

-- Creating table Payment - pay_id, oid, amount, mode(upi, credit, debit), status
CREATE TABLE IF NOT EXISTS payment (
    pay_id INT(3) PRIMARY KEY,
    oid INT(3),
    amount INT(10) NOT NULL,
    mode VARCHAR(30) CHECK (mode IN ('upi', 'credit', 'debit')),
    status VARCHAR(30),
    FOREIGN KEY (oid) REFERENCES orders(oid)
);

-- Creating table Employee - eid, ename, phone_no., department, manager_id
CREATE TABLE IF NOT EXISTS employee (
    eid INT(4) PRIMARY KEY,
    ename VARCHAR(40) NOT NULL,
    phone_no INT(10) NOT NULL,
    department VARCHAR(40) NOT NULL,
    manager_id INT(4)
);

-- Inserting values into products table
INSERT INTO products VALUES
    (1, 'HP Laptop', 50000, 15, 'Mumbai'),
    (2, 'Realme Mobile', 20000, 30, 'Delhi'),
    (3, 'Boat earpods', 3000, 50, 'Delhi'),
    (4, 'Levono Laptop', 40000, 15, 'Mumbai'),
    (5, 'Charger', 1000, 0, 'Mumbai'),
    (6, 'Mac Book', 78000, 6, 'Delhi'),
    (7, 'JBL speaker', 6000, 2, 'Delhi');

-- Inserting values into customer table
INSERT INTO customer VALUES
    (101, 'Ravi', 30, 'fdslfjl'),
    (102, 'Rahul', 25, 'fdslfjl'),
    (103, 'Simran', 32, 'fdslfjl'),
    (104, 'Purvesh', 28, 'fdslfjl'),
    (105, 'Sanjana', 22, 'fdslfjl');

-- Inserting values into orders table
INSERT INTO orders VALUES
    (10001, 102, 3, 2700),
    (10002, 104, 2, 18000),
    (10003, 105, 5, 900),
    (10004, 101, 1, 46000);

-- Inserting values into payment table
INSERT INTO payment VALUES
    (1, 10001, 2700, 'upi', 'completed'),
    (2, 10002, 18000, 'credit', 'completed'),
    (3, 10003, 900, 'debit', 'in process');

-- Inserting values into employee table
INSERT INTO employee VALUES
    (401, 'Rohan', 364832549, 'Analysis', 404),
    (402, 'Rahul', 782654123, 'Delivery', 406),
    (403, 'Shyam', 856471235, 'Delivery', 402),
    (404, 'Neha', 724863287, 'Sales', 402),
    (405, 'Sanjana', 125478954, 'HR', 404),
    (406, 'Sanjay', 956478535, 'Tech', NULL);

-- Displaying details of products table
SELECT * FROM products;

-- Displaying details of customer table
SELECT * FROM customer;

-- Displaying details of orders table
SELECT * FROM orders;

-- Displaying details of payment table
SELECT * FROM payment;

-- Displaying details of employee table
SELECT * FROM employee;

-- 1. Inner Join -> Matching values from both tables should be present
-- Example: For getting the name of customers who placed the order, we need to inner join customer and orders table
SELECT customer.cid, cname, orders.oid FROM orders 
INNER JOIN customer ON orders.cid = customer.cid;

-- Example 2: Getting the name of the customers and products that were ordered, we need to inner join orders, products, and customer table
SELECT customer.cid, cname, products.pid, pname, orders.oid FROM orders
INNER JOIN products ON orders.pid = products.pid
INNER JOIN customer ON orders.cid = customer.cid;

-- 2. Left Outer Join -> All the rows from the left table should be present and matching rows from the right table are present
-- Example: Getting the product id, product name, amount to be paid in an order, we need to left join products and orders table
SELECT products.pid, pname, amt, orders.oid FROM products
LEFT JOIN orders ON orders.pid = products.pid;

-- 3. Right Outer Join -> All the rows from the right table should be present and only matching rows from the left table are present
-- Example: Displaying order details in payments table, we need to right join payment and orders table
SELECT * FROM payment 
RIGHT JOIN orders ON orders.oid = payment.oid;

-- 4. Full Outer Join -> All the rows from both tables should be present
-- Note: MySQL does not support full join directly; we need to perform "UNION" operation between the results obtained from left and right join
-- Example: Displaying the details of all the orders and products, we need to full join orders and products tables
SELECT orders.oid, products.pid, pname, amt, price, stock, location FROM orders
LEFT JOIN products ON orders.pid = products.pid
UNION
SELECT orders.oid, products.pid, pname, amt, price, stock, location FROM orders
RIGHT JOIN products ON orders.pid = products.pid;

-- 5. Self Join -> It is a regular join, but the table is joined by itself
-- Example: Displaying the employees with managers, we need to self join the employee table
SELECT e1.ename AS Employee, e2.ename AS Manager FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.eid;

-- 6. Cross Join -> It is used to view all the possible combinations of the rows of one table and with all the rows from the second table
-- Example: Displaying all the details of customer and orders where the amount is less than 3000, we need to cross join customer and orders table
SELECT customer.cid, cname, orders.oid, amt FROM customer
CROSS JOIN orders ON customer.cid = orders.cid
WHERE amt > 3000;
