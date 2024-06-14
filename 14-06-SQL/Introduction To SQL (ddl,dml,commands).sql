-- Introduction to SQL with detailed examples and comments

-- =========================================
-- Data Definition Language (DDL) Commands
-- =========================================

-- 1. CREATE
-- The CREATE command is used to create new database objects.
-- Example: Creating a new table called 'Employees'.

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,      -- Unique identifier for each employee
    FirstName VARCHAR(50),           -- First name of the employee
    LastName VARCHAR(50),            -- Last name of the employee
    BirthDate DATE,                  -- Birth date of the employee
    HireDate DATE,                   -- Hire date of the employee
    Salary DECIMAL(10, 2)            -- Salary of the employee with two decimal points
);

-- 2. ALTER
-- The ALTER command modifies the structure of an existing database object.
-- Example: Adding a new column called 'Email' to the 'Employees' table.

ALTER TABLE Employees
ADD Email VARCHAR(100);              -- Adding an Email column to store email addresses

-- Example: Modifying the 'Salary' column to increase its precision.

ALTER TABLE Employees
MODIFY COLUMN Salary DECIMAL(12, 2); -- Increasing the precision of the Salary column

-- 3. DROP
-- The DROP command deletes existing database objects.
-- Example: Dropping the 'Employees' table.

DROP TABLE Employees;                -- This will delete the Employees table and all its data

-- 4. TRUNCATE
-- The TRUNCATE command removes all rows from a table.
-- Example: Truncating the 'Employees' table.

-- Recreate the table for further examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Salary DECIMAL(12, 2),
    Email VARCHAR(100)
);

-- Inserting some data for the TRUNCATE example
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Email)
VALUES
(1, 'John', 'Doe', '1980-01-01', '2020-01-15', 60000.00, 'john.doe@example.com'),
(2, 'Jane', 'Smith', '1985-02-20', '2018-03-10', 75000.00, 'jane.smith@example.com');

-- Now, truncate the table
TRUNCATE TABLE Employees;            -- This removes all rows from the Employees table

-- =========================================
-- Data Manipulation Language (DML) Commands
-- =========================================

-- Recreate the table and insert some data again for DML examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Salary DECIMAL(12, 2),
    Email VARCHAR(100)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Email)
VALUES
(1, 'John', 'Doe', '1980-01-01', '2020-01-15', 60000.00, 'john.doe@example.com'),
(2, 'Jane', 'Smith', '1985-02-20', '2018-03-10', 75000.00, 'jane.smith@example.com'),
(3, 'Sam', 'Brown', '1990-05-15', '2019-07-22', 55000.00, 'sam.brown@example.com');

-- 1. SELECT
-- The SELECT command retrieves data from the database.
-- Example: Selecting all columns from the 'Employees' table.

SELECT * FROM Employees;             -- This will display all columns for all employees

-- Example: Selecting specific columns from the 'Employees' table.

SELECT FirstName, LastName, HireDate FROM Employees; -- Display only first name, last name, and hire date

-- Example: Using the WHERE clause to filter results.

SELECT FirstName, LastName FROM Employees
WHERE Salary > 60000;                -- Display only employees with a salary greater than 60000

-- Example: Using ORDER BY to sort results.

SELECT FirstName, LastName, Salary FROM Employees
ORDER BY Salary DESC;                -- Display employees sorted by salary in descending order

-- 2. INSERT
-- The INSERT command adds new rows to a table.
-- Example: Inserting a single row into the 'Employees' table.

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Email)
VALUES (4, 'Alice', 'Johnson', '1988-03-14', '2021-06-01', 70000.00, 'alice.johnson@example.com');

-- Example: Inserting multiple rows into the 'Employees' table.

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Email)
VALUES
(5, 'Bob', 'Williams', '1992-09-23', '2022-02-20', 50000.00, 'bob.williams@example.com'),
(6, 'Eve', 'Davis', '1995-12-10', '2021-08-15', 80000.00, 'eve.davis@example.com');

-- 3. UPDATE
-- The UPDATE command modifies existing data within a table.
-- Example: Updating a single row in the 'Employees' table.

UPDATE Employees
SET Salary = 65000.00
WHERE EmployeeID = 1;                -- Update the salary of the employee with EmployeeID 1

-- Example: Updating multiple rows in the 'Employees' table.

UPDATE Employees
SET Salary = Salary * 1.10
WHERE HireDate < '2021-01-01';       -- Increase the salary by 10% for employees hired before 2021

-- 4. DELETE
-- The DELETE command removes existing rows from a table.
-- Example: Deleting a specific row from the 'Employees' table.

DELETE FROM Employees
WHERE EmployeeID = 6;                -- Delete the employee with EmployeeID 6

-- Example: Deleting multiple rows from the 'Employees' table.

DELETE FROM Employees
WHERE Salary < 60000;                -- Delete employees with a salary less than 60000

-- Example: Deleting all rows from the 'Employees' table (similar to TRUNCATE but logged).

DELETE FROM Employees;               -- This removes all rows from the Employees table

-- =========================================
-- Data Control Language (DCL) Commands
-- =========================================

-- 1. GRANT
-- The GRANT command gives specific privileges to users.
-- Example: Granting SELECT and INSERT privileges on the 'Employees' table to a user.

GRANT SELECT, INSERT ON Employees TO 'username';

-- 2. REVOKE
-- The REVOKE command removes specific privileges from users.
-- Example: Revoking INSERT privileges on the 'Employees' table from a user.

REVOKE INSERT ON Employees FROM 'username';

-- =========================================
-- Transaction Control Language (TCL) Commands
-- =========================================

-- 1. COMMIT
-- The COMMIT command saves all changes made in the current transaction.
-- Example: Using COMMIT after an INSERT command.

BEGIN TRANSACTION;                    -- Start a new transaction

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Email)
VALUES (7, 'Chris', 'Miller', '1987-07-07', '2023-01-01', 90000.00, 'chris.miller@example.com');

COMMIT;                               -- Commit the transaction

-- 2. ROLLBACK
-- The ROLLBACK command undoes all changes made in the current transaction.
-- Example: Using ROLLBACK after an INSERT command.

BEGIN TRANSACTION;                    -- Start a new transaction

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Email)
VALUES (8, 'Dana', 'Taylor', '1993-11-11', '2023-02-15', 62000.00, 'dana.taylor@example.com');

ROLLBACK;                             -- Roll back the transaction, the insert will not be saved

-- 3. SAVEPOINT
-- The SAVEPOINT command sets a point within a transaction to which you can later roll back.
-- Example: Using SAVEPOINT in a transaction.

BEGIN TRANSACTION;                    -- Start a new transaction

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Email)
VALUES (9, 'Evan', 'Moore', '1984-05-25', '2022-05-05', 77000.00, 'evan.moore@example.com');

SAVEPOINT BeforeUpdate;               -- Set a savepoint before the update

UPDATE Employees
SET Salary = 80000.00
WHERE EmployeeID = 9;                -- Update the salary of the newly inserted employee

-- If needed, we can roll back to the savepoint
ROLLBACK TO BeforeUpdate;             -- Roll back to the savepoint, the update will be undone

COMMIT;                               -- Commit the transaction, the insert will be saved
