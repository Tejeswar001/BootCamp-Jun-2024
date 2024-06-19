CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT,
    location VARCHAR(50)
);

-- Insert some sample data into `products`
INSERT INTO products (product_id, product_name, price, stock, location)
VALUES
    (1, 'Laptop', 1200.50, 15, 'Warehouse A'),
    (2, 'Smartphone', 699.99, 25, 'Warehouse B'),
    (3, 'Tablet', 399.00, 20, 'Warehouse A');

-- String Functions
-- A) CHAR_LENGTH(str): Returns the length of the string `str` in characters.
SELECT CHAR_LENGTH('Hello, World!') AS string_length;

-- B) ASCII(str): Returns the ASCII code value of the leftmost character in the string `str`.
SELECT ASCII('A') AS ascii_value;

-- C) CONCAT(str1, str2, ...): Concatenates two or more string values together.
SELECT CONCAT('Hello', ' ', 'World') AS concatenated_string;

-- D) INSTR(str, substr): Returns the position of the first occurrence of `substr` in `str`.
SELECT INSTR('Hello, World!', 'o') AS position_of_o,
       INSTR('Hello, World!', 'x') AS position_of_x;

-- E) LCASE(str) or LOWER(str): Converts the string `str` to lowercase.
SELECT LCASE('HELLO') AS lowercase;

-- F) UCASE(str) or UPPER(str): Converts the string `str` to uppercase.
SELECT UCASE('hello') AS uppercase;

-- G) SUBSTR(str, start, length): Extracts a substring from `str` starting at `start` for `length` characters.
SELECT SUBSTR('Hello, World!', 8, 5) AS substring_example,
       SUBSTR('Hello, World!', 1, 5) AS substring_from_start;

-- H) LPAD(str, len, padstr): Pads the string `str` on the left side with `padstr` to make total length `len`.
SELECT LPAD('Hello', 10, '*') AS left_padded_string;

-- I) RPAD(str, len, padstr): Pads the string `str` on the right side with `padstr` to make total length `len`.
SELECT RPAD('Hello', 10, '*') AS right_padded_string;

-- J) TRIM(str), RTRIM(str), LTRIM(str): Remove leading/trailing/all spaces from `str`.
SELECT TRIM('   Hello, World!   ') AS trimmed_string,
       RTRIM('   Hello, World!   ') AS right_trimmed_string,
       LTRIM('   Hello, World!   ') AS left_trimmed_string;

-- Date and Time Functions
-- A) CURRENT_DATE(): Returns the current date in 'YYYY-MM-DD' format.
SELECT CURRENT_DATE() AS current_date;

-- B) DATEDIFF(date1, date2): Returns the number of days between `date1` and `date2`.
SELECT DATEDIFF('2023-05-10', '2023-05-01') AS days_difference;

-- C) DATE(expression): Extracts the date part from a date or datetime `expression`.
SELECT DATE('2023-05-01 12:34:56') AS date_from_datetime;

-- D) CURRENT_TIME(): Returns the current time in 'HH:MM:SS' format.
SELECT CURRENT_TIME() AS current_time;

-- E) LAST_DAY(date): Returns the last day of the month for a given `date`.
SELECT LAST_DAY('2023-05-01') AS last_day_of_month;

-- F) SYSDATE(): Returns the current date and time in 'YYYY-MM-DD HH:MM:SS' format.
SELECT SYSDATE() AS current_timestamp;

-- G) ADDDATE(date, interval): Adds `interval` to `date` and returns the new date.
SELECT ADDDATE('2023-05-01', INTERVAL 7 DAY) AS date_one_week_later;

-- Numeric Functions
-- A) AVG(expression): Returns the average value of non-null values in a group.
SELECT AVG(price) AS avg_price FROM products;

-- B) COUNT(expression): Returns the number of non-null values in a group.
SELECT COUNT(*) AS total_products FROM products;

-- C) POW(base, exponent): Returns `base` raised to the power of `exponent`.
SELECT POW(2, 3) AS power_example;

-- D) MIN(expression): Returns the minimum value in a group.
SELECT MIN(price) AS min_price FROM products;

-- E) MAX(expression): Returns the maximum value in a group.
SELECT MAX(stock) AS max_stock, location FROM products GROUP BY location;

-- F) ROUND(number, [decimals]): Rounds `number` to specified `decimals` places (default is 0).
SELECT ROUND(3.1416, 2) AS rounded_value;

-- G) SQRT(number): Returns the square root of `number`.
SELECT SQRT(25) AS square_root_example;

-- H) FLOOR(number): Returns the largest integer less than or equal to `number`.
SELECT FLOOR(3.8) AS floor_value;

-- Clean up: Drop the sample table `products`
DROP TABLE products;
