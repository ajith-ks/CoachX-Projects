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
    product_name TEXT,
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
    userid INT PRIMARY KEY,
    created_date DATE,
    product_id INT,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
	FOREIGN KEY (userid) REFERENCES goldusers_signup(userid)
);

-- Table: user_name
CREATE TABLE user_name (
    userid INT PRIMARY KEY,
    FOREIGN KEY (userid) REFERENCES sales(userid)
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

-- inssert for table - products
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

