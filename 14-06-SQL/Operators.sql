-- Introduction to SQL Operators in MySQL with detailed examples and comments

-- =========================================
-- Arithmetic Operators
-- =========================================

-- Arithmetic operators perform mathematical operations on numeric data.
-- The common arithmetic operators are: +, -, *, /, and % (modulus).

-- Example: Addition (+)
SELECT 5 + 3 AS AdditionResult;       -- This will return 8

-- Example: Subtraction (-)
SELECT 10 - 4 AS SubtractionResult;   -- This will return 6

-- Example: Multiplication (*)
SELECT 6 * 7 AS MultiplicationResult; -- This will return 42

-- Example: Division (/)
SELECT 20 / 4 AS DivisionResult;      -- This will return 5

-- Example: Modulus (%)
SELECT 17 % 5 AS ModulusResult;       -- This will return 2 (remainder of 17 divided by 5)

-- Using arithmetic operators with columns in a table
-- Recreate and populate the Employees table for examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Salary DECIMAL(12, 2),
    Bonus DECIMAL(12, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Bonus)
VALUES
(1, 'John', 'Doe', '1980-01-01', '2020-01-15', 60000.00, 5000.00),
(2, 'Jane', 'Smith', '1985-02-20', '2018-03-10', 75000.00, 6000.00),
(3, 'Sam', 'Brown', '1990-05-15', '2019-07-22', 55000.00, 4500.00);

-- Example: Calculating total compensation (salary + bonus)
SELECT FirstName, LastName, Salary, Bonus, (Salary + Bonus) AS TotalCompensation
FROM Employees;

-- Example: Calculating the difference between salary and bonus
SELECT FirstName, LastName, Salary, Bonus, (Salary - Bonus) AS SalaryAfterBonus
FROM Employees;

-- =========================================
-- Comparison Operators
-- =========================================

-- Comparison operators compare two values and return a boolean result.
-- The common comparison operators are: =, <>, >, <, >=, <=, and BETWEEN.

-- Example: Equal to (=)
SELECT * FROM Employees
WHERE Salary = 75000.00;              -- This will return the row where Salary is 75000.00

-- Example: Not equal to (<>)
SELECT * FROM Employees
WHERE Salary <> 75000.00;             -- This will return rows where Salary is not 75000.00

-- Example: Greater than (>)
SELECT * FROM Employees
WHERE Salary > 60000.00;              -- This will return rows where Salary is greater than 60000.00

-- Example: Less than (<)
SELECT * FROM Employees
WHERE Salary < 60000.00;              -- This will return rows where Salary is less than 60000.00

-- Example: Greater than or equal to (>=)
SELECT * FROM Employees
WHERE Salary >= 55000.00;             -- This will return rows where Salary is 55000.00 or more

-- Example: Less than or equal to (<=)
SELECT * FROM Employees
WHERE Salary <= 60000.00;             -- This will return rows where Salary is 60000.00 or less

-- Example: BETWEEN
SELECT * FROM Employees
WHERE Salary BETWEEN 55000.00 AND 75000.00; -- This will return rows where Salary is between 55000.00 and 75000.00

-- =========================================
-- Logical Operators
-- =========================================

-- Logical operators are used to combine multiple conditions in a WHERE clause.
-- The common logical operators are: AND, OR, and NOT.

-- Example: AND
SELECT * FROM Employees
WHERE Salary > 50000.00 AND Bonus > 4000.00; -- This will return rows where both conditions are true

-- Example: OR
SELECT * FROM Employees
WHERE Salary > 70000.00 OR Bonus > 5000.00;  -- This will return rows where either condition is true

-- Example: NOT
SELECT * FROM Employees
WHERE NOT Salary = 60000.00;                 -- This will return rows where Salary is not 60000.00

-- =========================================
-- Other Operators
-- =========================================

-- Other useful operators include IN, LIKE, IS NULL, and IS NOT NULL.

-- Example: IN
SELECT * FROM Employees
WHERE Salary IN (60000.00, 75000.00);        -- This will return rows where Salary is either 60000.00 or 75000.00

-- Example: LIKE
SELECT * FROM Employees
WHERE FirstName LIKE 'J%';                   -- This will return rows where FirstName starts with 'J'

-- Example: IS NULL
-- Let's add a new column to illustrate NULL values
ALTER TABLE Employees ADD Department VARCHAR(50);

-- Insert a new row with a NULL value for the Department column
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Bonus, Department)
VALUES (4, 'Alice', 'Johnson', '1988-03-14', '2021-06-01', 70000.00, 5000.00, NULL);

SELECT * FROM Employees
WHERE Department IS NULL;                    -- This will return rows where Department is NULL

-- Example: IS NOT NULL
SELECT * FROM Employees
WHERE Department IS NOT NULL;                -- This will return rows where Department is not NULL

-- =========================================
-- String Operators
-- =========================================

-- String operators are used to manipulate string data.
-- Common string operators/functions include CONCAT, LENGTH, SUBSTRING, and REPLACE.

-- Example: CONCAT
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;                               -- This will concatenate FirstName and LastName

-- Example: LENGTH
SELECT FirstName, LENGTH(FirstName) AS FirstNameLength
FROM Employees;                               -- This will return the length of the FirstName

-- Example: SUBSTRING
SELECT FirstName, SUBSTRING(FirstName, 1, 2) AS FirstTwoLetters
FROM Employees;                               -- This will return the first two letters of the FirstName

-- Example: REPLACE
SELECT FirstName, REPLACE(FirstName, 'a', 'A') AS ReplacedName
FROM Employees;                               -- This will replace 'a' with 'A' in the FirstName

-- =========================================
-- Aggregate Functions
-- =========================================

-- Aggregate functions perform a calculation on a set of values and return a single value.
-- Common aggregate functions include COUNT, SUM, AVG, MIN, and MAX.

-- Example: COUNT
SELECT COUNT(*) AS EmployeeCount
FROM Employees;                               -- This will return the total number of employees

-- Example: SUM
SELECT SUM(Salary) AS TotalSalary
FROM Employees;                               -- This will return the sum of all salaries

-- Example: AVG
SELECT AVG(Salary) AS AverageSalary
FROM Employees;                               -- This will return the average salary

-- Example: MIN
SELECT MIN(Salary) AS MinimumSalary
FROM Employees;                               -- This will return the minimum salary

-- Example: MAX
SELECT MAX(Salary) AS MaximumSalary
FROM Employees;                               -- This will return the maximum salary

-- Example: Using aggregate functions with GROUP BY
-- Adding another column to group data
ALTER TABLE Employees ADD JobTitle VARCHAR(50);

-- Updating the new column with values
UPDATE Employees SET JobTitle = 'Developer' WHERE EmployeeID IN (1, 4);
UPDATE Employees SET JobTitle = 'Manager' WHERE EmployeeID = 2;
UPDATE Employees SET JobTitle = 'Analyst' WHERE EmployeeID = 3;

-- Grouping by JobTitle and calculating aggregate values
SELECT JobTitle, COUNT(*) AS NumberOfEmployees, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY JobTitle;                             -- This will group employees by JobTitle and calculate the count and average salary for each group

-- =========================================
-- Conditional Operators
-- =========================================

-- Conditional operators return a value based on the evaluation of a condition.
-- Common conditional functions include IF, IFNULL, and CASE.

-- Example: IF
SELECT FirstName, LastName,
       IF(Salary > 60000, 'High', 'Low') AS SalaryCategory
FROM Employees;                               -- This will return 'High' if Salary is greater than 60000, otherwise 'Low'

-- Example: IFNULL
SELECT FirstName, Department,
       IFNULL(Department, 'Not Assigned') AS DepartmentStatus
FROM Employees;                               -- This will replace NULL Department values with 'Not Assigned'

-- Example: CASE
SELECT FirstName, LastName, Salary,
       CASE
           WHEN Salary > 70000 THEN 'A'
           WHEN Salary BETWEEN 60000 AND 70000 THEN 'B'
           ELSE 'C'
       END AS SalaryGrade
FROM Employees;                               -- This will return a grade based on the salary range

-- =========================================
-- Bitwise Operators
-- =========================================

-- Bitwise operators perform bit-level operations on numeric data.
-- The common bitwise operators are: &, |, ^, ~, <<, and >>.

-- Example: AND (&)
SELECT 5 & 3 AS BitwiseAndResult;             -- This will return 1 (binary: 0101 & 0011 = 0001)

-- Example: OR (|)
SELECT 5 | 3 AS BitwiseOrResult;              -- This will return 7 (binary: 0101 | 0011 = 0111)

-- Example: XOR (^)
SELECT 5 ^ 3 AS BitwiseXorResult;             -- This will return 6 (binary: 0101 ^ 0011 = 0110)

-- Example: NOT (~)
SELECT ~5 AS BitwiseNotResult;                -- This will return -6 (binary: ~0101 = 1010 in two's complement form)

-- Example: Shift Left (<<)
SELECT 5 << 1 AS ShiftLeftResult;             -- This will return 10 (binary: 0101 << 1 = 1010)

-- Example: Shift Right (>>)
SELECT 5 >> 1 AS ShiftRightResult;            -- This will return 2 (binary: 0101 >> 1 = 0010)
