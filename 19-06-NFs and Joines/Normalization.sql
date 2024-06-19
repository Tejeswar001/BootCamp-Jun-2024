/*
-- Anomalies
Anomalies are undesirable conditions in a relational database that can lead to data inconsistency, affecting data manipulation.

-- Insertion Anomalies
Occur when you cannot insert valid data due to missing dependencies. For example, trying to insert an order for a customer not yet in the Customers table.

-- Deletion Anomalies
Occur when deleting a row affects unrelated data. For instance, deleting a product from Products that still has associated orders in the Orders table.

-- Update Anomalies
Occur when updating data leads to inconsistencies elsewhere. For example, updating the price of a product in Products without updating existing orders that reference the old price.

-- Candidate Keys
Candidate keys are attributes or combinations ensuring unique identification of each tuple in a table. For instance, pid (Product ID) in Products table.

-- Primary Key
A primary key uniquely identifies each record in a table, ensuring data integrity. It must be unique and not null.

-- Foreign Key
A foreign key establishes a link between tables by referencing the primary key of another table, ensuring referential integrity.

-- Normalization
Normalization reduces redundancy by organizing tables into specific forms (e.g., 1NF, 2NF, 3NF), addressing dependencies and anomalies.

-- BCNF
Boyce-Codd Normal Form (BCNF) is stricter than 3NF, eliminating certain redundancies and anomalies.

*/

-- Example of Update Anomaly
-- Updating the price of "HP Laptop" (ProductID: 1) from ₹50,000 to ₹52,000:
UPDATE Products
SET price = 52000
WHERE pid = 1;

-- Example of Delete Anomaly
-- Deleting the "Charger" record (ProductID: 5) from Products:
DELETE FROM Products
WHERE pid = 5;

-- Example of Insertion Anomaly
-- Attempting to insert an order for a customer (CustomerID: 106) who isn't yet in Customers:
INSERT INTO Orders (OrderID, CustomerID, ProductID, Quantity)
VALUES (10005, 106, 2, 1);  -- Assuming ProductID 2 is 'Realme Mobile'

-- Creating Products table with Primary Key
CREATE TABLE Products (
    pid INT PRIMARY KEY,
    pname VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    stock INT,
    location VARCHAR(30) CHECK (location IN ('Mumbai', 'Delhi'))
);

-- Adding Primary Key to an existing table
ALTER TABLE Products
ADD PRIMARY KEY (pid);

-- Creating Orders table with Foreign Keys
CREATE TABLE Orders (
    oid INT PRIMARY KEY,
    cid INT,
    pid INT,
    amt INT NOT NULL,
    FOREIGN KEY (cid) REFERENCES Customers(cid),
    FOREIGN KEY (pid) REFERENCES Products(pid)
);

-- Adding Foreign Key to an existing table
ALTER TABLE Orders
ADD FOREIGN KEY (pid) REFERENCES Products(pid);

-- Removing Foreign Key from a table
ALTER TABLE Products
DROP FOREIGN KEY products_ibfk_1;

-- Example of Normalization Violation and Fix (1NF)
-- Products table violating 1NF:
/*
ORDER_ID     CUSTOMER_NAME    ITEMS         PRICE
1001         JOHN SMITH       SHIRT,HAT     $50
*/

-- Fixed Products table following 1NF:
CREATE TABLE Products (
    pid INT PRIMARY KEY,
    pname VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    stock INT,
    location VARCHAR(30) CHECK (location IN ('Mumbai', 'Delhi'))
);

-- Example of Normalization Levels (2NF, 3NF)
-- Suppose we introduce product_color to Orders, violating 2NF:
/*
OrderID    CustomerID    ProductID    Amount    ProductColor
10001      102           3            2700      Blue
*/

-- Fix by creating Order_Items table for 2NF:
CREATE TABLE Order_Items (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    ProductColor VARCHAR(20),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Example of BCNF Violation and Fix
-- Orders table violating BCNF:
/*
OrderID    CustomerID    ProductID    Amount
10001      102           3            2700
*/

-- Decompose to satisfy BCNF:
CREATE TABLE Order_Info (
    OrderID INT PRIMARY KEY,
    Amount INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Order_Details (
    OrderID INT,
    CustomerID INT,
    ProductID INT,
    PRIMARY KEY (OrderID, CustomerID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

