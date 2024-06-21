-- Using Amazon database
USE amazon;

-- DELIMITER COMMAND:
-- 1. Purpose: The DELIMITER command is used to change the standard delimiter (like a semicolon (;)), to a different character.
-- 2. Usage: When defining stored procedures, functions, or other multi-statement constructs that contain semicolons within their body.
-- 3. Syntax: DELIMITER new_delimiter;
-- 4. Example:
--    DELIMITER //
--    CREATE PROCEDURE procedure_name()
--    BEGIN
--        SQL statements
--    END //
--    DELIMITER ;

-- DETERMINISTIC:
-- DETERMINISTIC indicates that the function will always return the same result for the same input values.
-- If the function contains any non-deterministic elements (e.g., calls to functions that return different values each time they are called), you should omit this keyword.

-- PROCEDURES:
-- A procedure is a set of SQL statements that can be saved and reused.
-- Procedures can have input parameters (IN) and output parameters (OUT).
-- Procedures do not return a value.
-- A procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
-- So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.

-- CREATE PROCEDURE:
-- Procedures in SQL allow you to encapsulate a series of SQL statements into a reusable unit.
-- Syntax:
--    DELIMITER //
--    CREATE PROCEDURE procedure_name(parameter1 datatype, parameter2 datatype, ...)
--    BEGIN
--        Procedure logic goes here
--    END //
--    DELIMITER ;

-- EXAMPLE:
-- Procedure to select all products
DELIMITER //
CREATE PROCEDURE select_all_products()
BEGIN
    SELECT * FROM products;
END //
DELIMITER ;

-- EXECUTING PROCEDURES:
-- Once a procedure is created, you can execute it using the CALL statement followed by the procedure name and any required parameters.
-- Syntax: CALL procedure_name(parameter1, parameter2, ...);

-- EXAMPLE:
-- Calling the select_all_products procedure
CALL select_all_products();

-- DROPPING PROCEDURES:
-- If a procedure is no longer needed, it can be dropped using the DROP PROCEDURE statement.
-- Syntax: DROP PROCEDURE procedure_name;

-- EXAMPLE:
-- Dropping select_all_products
DROP PROCEDURE select_all_products;

-- FUNCTIONS:
-- A function is a reusable block of code that performs a specific task and can return a value.
-- Functions are similar to procedures, but procedures do not return values.
-- Functions can have input parameters (IN) but cannot have output parameters.
-- Input parameters allow you to pass data into the function, and the function can use that data to perform its task.

-- FUNCTION CREATION:
-- To create a function, you need to define its name, input parameters (if any), and the data type of the value it returns.
-- The function logic (the code that performs the task) goes inside the BEGIN and END blocks.
-- Syntax:
-- CREATE FUNCTION function_name(parameter1 data_type, parameter2 data_type, ...)
-- RETURNS return_data_type
-- AS
-- BEGIN
--     -- Function logic here
-- END;

-- EXAMPLE:
-- Function to calculate total revenue for a product
DELIMITER $$
CREATE FUNCTION get_total_revenue()
RETURNS DECIMAL(10,2)
DETERMINISTIC 
BEGIN
    DECLARE total_revenue DECIMAL(10,2);
    -- Calculate the total revenue by summing the 'amount' column from the 'payment' table
    -- for all completed orders
    SELECT SUM(p.amount) INTO total_revenue
    FROM payment p
    INNER JOIN orders o ON p.order_id = o.order_id
    WHERE o.status = 'Completed';
    RETURN total_revenue; -- Returns the calculated total revenue
END$$
DELIMITER ;

-- FUNCTION EXECUTION:
-- To execute (call) a function, you use the SELECT statement along with the function name and any required input parameters.
-- Syntax: SELECT function_name(parameter1, parameter2, ...);

-- EXAMPLE:
-- Calling the function
SELECT get_total_revenue(); -- This will execute the function and return the total revenue

-- DROPPING FUNCTION:
-- If you no longer need a function, you can drop (delete) it using the DROP FUNCTION statement.
-- Syntax: DROP FUNCTION [IF EXISTS] function_name;
-- The IF EXISTS clause is optional and allows you to avoid an error if the function doesn't exist.

-- EXAMPLE:
-- Dropping the function
DROP FUNCTION IF EXISTS get_total_revenue;
-- This will remove the 'get_total_revenue' function from the database

-- IN:
-- This IN is a part of procedures
-- IN parameters in MySQL stored procedures allow you to pass values into the procedure.
-- These values are read-only within the procedure and cannot be modified.

-- Syntax for IN:
-- CREATE PROCEDURE procedure_name(IN parameter_name data_type)
-- BEGIN
--    -- Procedure logic using parameter_name
-- END;

-- Creating procedure with IN:
DELIMITER //
CREATE PROCEDURE get_product_details(IN product_id INT)
BEGIN
    SELECT * FROM products WHERE pid = product_id;
END //
DELIMITER ;

-- Calling Procedure
CALL get_product_details(1);
-- This will retrieve details for the product with ID 1.

-- EXPLANATION:
-- CREATE PROCEDURE get_product_details(IN product_id INT): This statement defines a procedure named get_product_details
-- with an IN parameter product_id of type INT.
-- BEGIN and END: These keywords mark the beginning and end of the procedure's body, respectively.
-- SELECT * FROM products WHERE pid = product_id;: This is the SQL query inside the procedure that selects product details
-- based on the product_id parameter.
-- CALL get_product_details(3); This statement calls the procedure get_product_details with the argument 3, 
-- which is the product ID to retrieve details for.

-- OUT:
-- This OUT is a part of procedures
-- OUT parameters in MySQL stored procedures allow you to return values from a procedure. 
-- These values can be accessed by the calling program after the procedure execution.

-- Syntax:
-- CREATE PROCEDURE procedure_name(OUT parameter_name data_type)
-- BEGIN
--    -- Procedure logic using parameter_name
-- END;

-- Create the procedure to get product count using OUT:
DELIMITER //
CREATE PROCEDURE get_product_count(OUT product_count INT)
BEGIN
    SELECT COUNT(*) INTO product_count FROM products;
END //
DELIMITER ;

-- Calling the OUT Procedure
CALL get_product_count(@product_count);
SELECT @product_count as product_count;
-- call -> Using @product_count to store the result
-- select -> Accessing the variable using @product_count

-- CURSOR:
-- 1. Purpose:
--    - Cursors in SQL are used to retrieve and process rows one by one from the result set of a query.
-- 2. Declaration:
--    - Cursors are declared using the DECLARE CURSOR statement, specifying the SELECT query whose result set will be processed.
-- 3. Opening:
--    - A cursor must be opened using the OPEN statement before fetching rows.
--    - Opening a cursor positions the cursor before the first row.
-- 4. Fetching:
--    - Rows from the result set are fetched one by one using the FETCH statement.
--    - Each fetch operation advances the cursor to the next row in the result set.
-- 5. Closing:
--    - After processing all rows, the cursor should be closed using the CLOSE statement.
--    - Closing a cursor releases the resources associated with the result set and frees memory.

-- Syntax:
-- DECLARE cursor_name CURSOR FOR
-- SELECT column1, column2, ... 
-- FROM table_name 
-- WHERE condition;
-- OPEN cursor_name;
-- FETCH cursor_name INTO variable1, variable2, ...;
-- WHILE (condition) DO
--    -- Process fetched row here
--    -- Use fetched values stored in variables
--    FETCH cursor_name INTO variable1, variable2, ...;
-- END WHILE;
-- CLOSE cursor_name;

-- User-Defined Cursors:
-- 1. Purpose:
--    - User-defined cursors are declared by the user to process rows retrieved from a query result set.
--    - They are particularly useful when you need to perform custom operations on individual rows.
-- 2. Declaration:
--    - User-defined cursors are declared using the DECLARE CURSOR statement, specifying the SELECT query whose result set will be processed.
--    - This allows the user to define custom logic for fetching and processing rows.
-- 3. Opening, Fetching, and Closing:
--    - User-defined cursors follow a similar process of opening, fetching, and closing as predefined cursors.
--    - After declaring and opening the cursor, the user fetches rows one by one and processes them as needed.
--    - Finally, the cursor is closed to release resources.

-- EXAMPLE:
-- To calculate the number of customers
DELIMITER //
DECLARE @customer_count INT;
SELECT @customer_count = COUNT(*)
FROM customer;
PRINT 'Number of customers: ' + CAST(@customer_count AS VARCHAR(10));
DELIMITER ;

-- Pre-defined Cursors:
-- 1. Purpose:
--    - Predefined cursors are system-defined cursors provided by the DBMS.
--    - They are often associated with built-in functions or stored procedures that return result sets.
-- 2. Usage:
--    - Predefined cursors are commonly used with predefined functions or procedures to process result sets returned by these functions.
--    - Examples of predefined cursors include cursors used with aggregate functions like COUNT(), SUM(), etc.
-- 3. Fetching:
--    - The process of fetching rows from predefined cursors is similar to user-defined cursors.
--    - The cursor is opened, rows are fetched and processed, and the cursor is closed to release resources.

-- EXAMPLE:
-- Using predefined SUM() cursor to calculate the total price of all products in the 'Electronics' category
DELIMITER //
CREATE PROCEDURE calc_total_electronics_price(OUT total_price DECIMAL(10,2))
BEGIN
    SELECT SUM(price) INTO total_price
    FROM products
    WHERE category = 'Electronics';
END //
DELIMITER ;

-- Calling the procedure and storing the result in a variable
CALL calc_total_electronics_price(@total);
SELECT @total AS total_electronics_price;

-- Cursor Iteration:
-- Looping through cursor rows involves fetching each row from the result set and processing it.
-- This is typically done using a loop that continues until all rows have been processed.
-- Syntax:
-- DECLARE cursor_name CURSOR FOR
-- SELECT column1, column2, ... 
-- FROM table_name 
-- WHERE condition;
-- OPEN cursor_name;
-- FETCH cursor_name INTO variable1, variable2, ...;
-- WHILE (condition) DO
--    -- Process fetched row here
--    -- Use fetched values stored in variables
--    FETCH cursor_name INTO variable1, variable2, ...;
-- END WHILE;
-- CLOSE cursor_name;

-- Procedure to declare and use a cursor to iterate through the 'products' table
-- and print the product name for each product
DELIMITER //
CREATE PROCEDURE print_product_names()
BEGIN
    DECLARE product_name VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;
    DECLARE product_cursor CURSOR FOR SELECT name FROM products;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN product_cursor;

    get_names: LOOP
        FETCH product_cursor INTO product_name;
        IF done THEN
            LEAVE get_names;
        END IF;
        SELECT product_name;
    END LOOP get_names;

    CLOSE product_cursor;
END //
DELIMITER ;

-- Practice Questions:

-- Q1. Write a query to create a function that calculates the total revenue from the 'orders' and 'payment' tables
-- for completed orders, and call the function to get the total revenue.
-- Answer 1:
DELIMITER $$
CREATE FUNCTION get_total_revenue()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10,2);
    SELECT SUM(p.amount) INTO total_revenue
    FROM payment p
    INNER JOIN orders o ON p.order_id = o.order_id
    WHERE o.status = 'Completed';
    RETURN total_revenue;
END$$
DELIMITER ;

-- Calling the function
SELECT get_total_revenue();

-- Q2. Write a query to create a procedure with an IN parameter to retrieve details of a specific product based on the product ID passed as a parameter. Call the procedure for product ID 5.
-- Answer 2:
DELIMITER $$
CREATE PROCEDURE get_product_details(IN product_id INT)
BEGIN
    SELECT * FROM products WHERE pid = product_id;
END$$
DELIMITER ;

-- Calling the procedure with product ID 5
CALL get_product_details(5);

-- Q3. Write a query to create a procedure with an OUT parameter to get the count of products in the 'products' table, store it in a variable, and select the variable to display the count.
-- Answer 3:
DELIMITER $$
CREATE PROCEDURE get_product_count(OUT total_count INT)
BEGIN
    SELECT COUNT(*) INTO total_count FROM products;
END$$
DELIMITER ;

-- Calling the procedure and storing the result in a variable
CALL get_product_count(@count);
SELECT @count AS total_products;

-- Q4. Write a query to use the predefined SUM() cursor to calculate the total price of all products in the 'products' table where the product category is 'Electronics'.
-- Answer 4:
DELIMITER $$
CREATE PROCEDURE calc_total_electronics_price(OUT total_price DECIMAL(10,2))
BEGIN
    SELECT SUM(price) INTO total_price
    FROM products
    WHERE category = 'Electronics';
END$$
DELIMITER ;

-- Calling the procedure and storing the result in a variable
CALL calc_total_electronics_price(@total);
SELECT @total AS total_electronics_price;

-- Q5. Write a query to declare and use a cursor to iterate through the 'products' table and print the product name for each product.
-- Answer 5:
DELIMITER //
CREATE PROCEDURE print_product_names()
BEGIN
    DECLARE product_name VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;
    DECLARE product_cursor CURSOR FOR SELECT name FROM products;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN product_cursor;

    get_names: LOOP
        FETCH product_cursor INTO product_name;
        IF done THEN
            LEAVE get_names;
        END IF;
        SELECT product_name;
    END LOOP get_names;

    CLOSE product_cursor;
END //
DELIMITER ;
