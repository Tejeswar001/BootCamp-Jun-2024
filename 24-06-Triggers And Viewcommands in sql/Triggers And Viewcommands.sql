-- Create database
create database amazon;

use amazon;

-- Products - pid, pname, price, stock, location (Mumbai or Delhi)
create table products
(
    pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);

-- Customer - cid, cname, age, addr
create table customer
(
    cid int(3) primary key,
    cname varchar(30) not null,
    age int(3),
    addr varchar(50)
);

-- Orders - oid, cid, pid, amt
create table orders
(
    oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);

-- Payment - pay_id, oid, amount, mode(upi, credit, debit), status
create table payment
(
    pay_id int(3) primary key,
    oid int(3),
    amount int(10) not null,
    mode varchar(30) check(mode in('upi','credit','debit')),
    status varchar(30),
    foreign key(oid) references orders(oid)
);

-- Inserting values into products table
insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');

-- Inserting values into customer table
insert into customer values(101,'Ravi',30,'fdslfjl');
insert into customer values(102,'Rahul',25,'fdslfjl');
insert into customer values(103,'Simran',32,'fdslfjl');
insert into customer values(104,'Purvesh',28,'fdslfjl');
insert into customer values(105,'Sanjana',22,'fdslfjl');

-- Inserting values into orders table
insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);

-- Inserting values into payments table
insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');

-- Commit
commit;

-- Rollback
rollback;

-- Savepoint
savepoint a;

-- Rollback to savepoint
rollback to a;

-- After insert trigger for logging product insertions
DELIMITER //
CREATE TRIGGER products_after_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO product_log (pid, pname, price, stock, location, inserted_at)
  VALUES (NEW.pid, NEW.pname, NEW.price, NEW.stock, NEW.location, NOW());
END //
DELIMITER ;

-- After insert trigger for updating product stock levels after new order
DELIMITER //
CREATE TRIGGER orders_after_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE products
  SET stock = stock - 1
  WHERE pid = NEW.pid;
END //
DELIMITER ;

-- After update trigger for logging product information changes
DELIMITER //
CREATE TRIGGER products_after_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  IF OLD.pid <> NEW.pid OR OLD.pname <> NEW.pname OR OLD.price <> NEW.price OR OLD.stock <> NEW.stock OR OLD.location <> NEW.location THEN
    INSERT INTO product_log (pid, pname, price, stock, location, updated_at)
    VALUES (OLD.pid, OLD.pname, OLD.price, OLD.stock, OLD.location, NOW());
  END IF;
END //
DELIMITER ;

-- After delete trigger to prevent deletion of product with existing orders
DELIMITER //
CREATE TRIGGER products_after_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
  DECLARE has_orders INT DEFAULT (0);
  SELECT COUNT(*) INTO has_orders FROM orders WHERE pid = OLD.pid;
  IF has_orders > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product with existing orders. Update or delete orders first.';
  END IF;
END //
DELIMITER ;

-- Before insert trigger for automatic payment status
DELIMITER //
CREATE TRIGGER set_default_payment_status
BEFORE INSERT ON payment
FOR EACH ROW
BEGIN
  IF NEW.status IS NULL THEN
    SET NEW.status = 'Pending';
  END IF;
END //
DELIMITER ;

-- Trigger to update status in payment table after an order is completed
DELIMITER //
CREATE TRIGGER update_payment_status
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' THEN
        UPDATE payment
        SET status = 'completed'
        WHERE oid = NEW.oid;
    END IF;
END //
DELIMITER ;

-- Trigger to check stock availability before inserting an order
DELIMITER //
CREATE TRIGGER check_stock_before_order
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    SELECT stock INTO available_stock FROM products WHERE pid = NEW.pid;
    IF available_stock < NEW.amt THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this product';
    END IF;
END //
DELIMITER ;

-- Trigger to update stock after an order is placed
DELIMITER //
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.amt
    WHERE pid = NEW.pid;
END //
DELIMITER ;

-- TCL commands
-- Saving the command permanently after running successfully
start transaction;
INSERT INTO products (pid, pname, price, stock, location) VALUES (8, 'iPhone 12', 79900, 10, 'Delhi');
INSERT INTO customer (cid, cname, age, addr) VALUES (106, 'John Doe', 35, '123 Main Street');
INSERT INTO orders (oid, cid, pid, amt) VALUES (1005, 106, 8, 79900);
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES (1, 1005, 79900, 'credit', 'completed');
commit;

-- Going to previous command
start transaction;
INSERT INTO products (pid, pname, price, stock, location) VALUES (8, 'iPhone 12', 79900, 10, 'Delhi');
INSERT INTO customer (cid, cname, age, addr) VALUES (106, 'John Doe', 35, '123 Main Street');
INSERT INTO orders (oid, cid, pid, amt) VALUES (1005, 106, 8, 79900);
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES (1, 1005, 79900, 'credit', 'completed');
rollback;

-- Going to a checkpoint where you want to go after saving the checkpoint
start transaction;
INSERT INTO products (pid, pname, price, stock, location) VALUES (8, 'iPhone 12', 79900, 10, 'Delhi');
INSERT INTO customer (cid, cname, age, addr) VALUES (106, 'John Doe', 35, '123 Main Street');
INSERT INTO orders (oid, cid, pid, amt) VALUES (1005, 106, 8, 79900);
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES (1, 1005, 79900, 'credit', 'completed');
SAVEPOINT A;
rollback TO A;

-- Views
-- Create a view that displays the customers with their corresponding orders
create view CustomerOrders as
select c.cid, c.cname, o.oid, o.amt, p.pname
from customer c
join orders o on c.cid = o.cid
join products p on o.pid = p.pid;

-- Create or Replace View to show payment details with order and customer information
CREATE OR REPLACE VIEW payment_order_customer_details AS
SELECT p.pay_id, p.oid, o.cid, c.cname, c.age, c.addr, p.amount, p.mode, p.status
FROM payment p
JOIN orders o ON p.oid = o.oid
JOIN customer c ON o.cid = c.cid;

-- Drop View if it exists
DROP VIEW IF EXISTS payment_order_customer_details;
