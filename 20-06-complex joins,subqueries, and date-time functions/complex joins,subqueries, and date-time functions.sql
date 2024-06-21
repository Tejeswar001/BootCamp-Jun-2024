-- Create database and use it
create database amazon;
use amazon;

-- Create products table
create table products (
    pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai', 'Delhi'))
);

-- Create customer table
create table customer (
    cid int(3) primary key,
    cname varchar(30) not null,
    age int(3),
    addr varchar(50)
);

-- Create orders table
create table orders (
    oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);

-- Create payment table with timestamp column
create table payment (
    pay_id int(3) primary key,
    oid int(3),
    amount int(10) not null,
    mode varchar(30) check(mode in ('upi', 'credit', 'debit')),
    status varchar(30),
    timestamp TIMESTAMP,
    foreign key(oid) references orders(oid)
);

-- Insert values into products table
insert into products values
(1, 'HP Laptop', 50000, 15, 'Mumbai'),
(2, 'Realme Mobile', 20000, 30, 'Delhi'),
(3, 'Boat earpods', 3000, 50, 'Delhi'),
(4, 'Levono Laptop', 40000, 15, 'Mumbai'),
(5, 'Charger', 1000, 0, 'Mumbai'),
(6, 'Mac Book', 78000, 6, 'Delhi'),
(7, 'JBL speaker', 6000, 2, 'Delhi'),
(8, 'Asus Laptop', 50000, 15, 'Delhi');

-- Insert values into customer table
insert into customer values
(101, 'Ravi', 30, 'fdslfjl'),
(102, 'Rahul', 25, 'fdslfjl'),
(103, 'Simran', 32, 'fdslfjl'),
(104, 'Purvesh', 28, 'fdslfjl'),
(105, 'Sanjana', 22, 'fdslfjl');

-- Insert values into orders table
insert into orders values
(10001, 102, 3, 2700),
(10002, 104, 2, 18000),
(10003, 105, 5, 900),
(10004, 101, 1, 46000);

-- Insert values into payment table and update timestamp
insert into payment values
(1, 10001, 2700, 'upi', 'completed'),
(2, 10002, 18000, 'credit', 'completed'),
(3, 10003, 900, 'debit', 'in process');

UPDATE payment SET timestamp = '2024-05-01 08:00:00' WHERE pay_id = 1;
UPDATE payment SET timestamp = '2024-05-01 08:10:00' WHERE pay_id = 2;
UPDATE payment SET timestamp = '2024-05-01 08:15:00' WHERE pay_id = 3;

-- SUBQUERIES

-- Single-row subquery: Find customer who placed the highest order amount
select cname 
from customer 
where cid = (select cid from orders order by amt desc limit 1);

-- Single-row subquery: Find product with the highest price
select pname 
from products 
where price = (select max(price) from products);

-- Multiple-row subquery: Find all customers who have placed an order
select cname 
from customer 
where cid in (select cid from orders);

-- Multiple-row subquery: Find all customers who ordered products from Mumbai
select cname 
from customer 
where cid in (select cid from orders where pid in (select pid from products where location = 'Mumbai'));

-- Correlated subquery: Products with price higher than location average
select pname, price 
from products p 
where price > (select avg(price) from products where location = p.location);

-- Correlated subquery: Customers with orders exceeding average order amount
select cname 
from customer c 
where exists (
    select 1 
    from orders o 
    where o.cid = c.cid 
    group by o.cid 
    having avg(o.amt) > (select avg(amt) from orders)
);

-- JOINS

-- Inner join with subquery: Products with orders where price > 1000
select p.pname, o.oid, o.amt 
from products p 
inner join (select * from orders) o on p.pid = o.pid 
where p.price > 1000;

-- Left join with aggregate function: Products and their total orders' amounts
select p.pname, sum(o.amt) as total_orders_amount 
from products p 
left join orders o on p.pid = o.pid 
group by p.pname;

-- Right join with date and time functions: Orders and their payment status
select o.oid, o.amt, p.status, p.timestamp 
from orders o 
right join payment p on o.oid = p.oid;

-- ANALYTICS FUNCTIONS / ADVANCED FUNCTIONS

-- RANK: Rank of products by price
select pid, pname, price, rank() over (order by price desc) as price_rank 
from products;

-- DENSE_RANK: Dense rank of products by price
select pid, pname, price, dense_rank() over (order by price desc) as price_rank 
from products;

-- ROW_NUMBER: Unique row number of customers by age
select row_number() over (order by age desc) as row_num, cid, cname, age, addr 
from customer;

-- CUME_DIST: Cumulative distribution of payment amounts
select oid, amount, cume_dist() over (order by amount) as cumulative_distribution 
from payment;

-- LAG: Previous price of products by location
select pname, price, location, lag(price) over (partition by location order by price) as lag_price 
from products;

-- LEAD: Next price of products by location
select pname, price, location, lead(price) over (partition by location order by price) as lead_price 
from products;
