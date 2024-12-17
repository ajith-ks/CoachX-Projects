--create database Exploring_Customer_Behavior
use Exploring_Customer_Behavior
-- Table: users
CREATE TABLE users (
    userid INT PRIMARY KEY,
    signup_date DATE
);

-- Table: product
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

-- Table: goldusers_signup
CREATE TABLE goldusers_signup (
    userid INT PRIMARY KEY,
    gold_signup_date DATE,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Table: sales
CREATE TABLE sales (
    userid INT ,
    created_date DATE,
    product_id INT,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Table: user_name
CREATE TABLE user_name (
    userid INT PRIMARY KEY,
	Names varchar(50),
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- inser data - users
INSERT INTO users (userid, signup_date) VALUES
(1, '2014-09-02'),
(2, '2015-01-15'),
(3, '2014-04-11'),
(4, '2015-11-17'),
(10, '2016-01-02'),
(9, '2016-01-02'),
(7, '2013-04-02'),
(8, '2013-12-15'),
(5, '2015-09-08'),
(6, '2014-07-13');

-- insert for table - products
INSERT INTO Product (product_id, product_name, price) VALUES
(1, 'Dal Makani', 160),
(2, 'Shahi Paneer', 170),
(3, 'Butter Chicken', 340),
(4, 'Aloo Gobi', 150),
(5, 'Chole Bhature', 100),
(6, 'Fish Curry', 380),
(7, 'Chicken Tikka', 300),
(8, 'Mutton Biryani', 450),
(9, 'Veg Pulao', 200),
(10, 'Mango Lassi', 80),
(11, 'Gulab Jamun', 100);

--insert into goldusers_signup

INSERT INTO goldusers_signup (userid, gold_signup_date) VALUES
(1, '2017-09-02'),
(3, '2017-04-11'),
(10, '2016-09-02'),
(9, '2017-12-02'),
(7, '2015-12-02'),
(8, '2019-05-15'),
(5, '2016-09-08'),
(6, '2014-12-13');




--insert into sales
INSERT INTO sales (userid, created_date, product_id) VALUES
(1, '2017-04-19', 2),
(3, '2019-12-18', 1),
(2, '2020-07-20', 3),
(1, '2019-10-23', 2),
(1, '2018-03-19', 2),
(3, '2016-12-20', 3),
(1, '2016-11-09', 1),
(2, '2016-05-20', 3),
(2, '2017-09-24', 1),
(1, '2017-03-11', 2),
(1, '2016-03-11', 1),
(3, '2016-11-10', 1),
(3, '2017-12-07', 2),
(3, '2016-12-15', 2),
(2, '2017-11-08', 2),
(3, '2018-09-10', 3),
(4, '2019-05-01', 1),
(5, '2018-11-23', 3),
(6, '2017-06-30', 9),
(7, '2018-08-12', 8),
(8, '2019-03-19', 7),
(9, '2017-12-04', 6),
(10, '2018-09-22', 2),
(4, '2020-08-17', 1),
(5, '2017-05-12', 10),
(5, '2014-07-27', 11),
(7, '2014-04-02', 7),
(8, '2020-12-15', 8),
(9, '2017-09-08', 8);

--insert into user_name
INSERT INTO user_name (userid, Names) VALUES
(1, 'Anshul'),
(2, 'Rohan'),
(3, 'Shreya'),
(4, 'Priya'),
(5, 'Aryan'),
(6, 'Sara'),
(7, 'Sahil'),
(8, 'Tanvi'),
(9, 'Ritika'),
(10, 'Gaurav');


