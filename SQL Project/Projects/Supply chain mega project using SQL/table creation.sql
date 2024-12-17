--create database SupplyChainFinanceManagement
use SupplyChainFinanceManagement;
--drop database SupplyChainFinanceManagement
-- Table 1: dim_customer
CREATE TABLE dim_customer (
    customer_code INT PRIMARY KEY,
    customer VARCHAR(45),
    platform VARCHAR(45),
    channel VARCHAR(45),
    market VARCHAR(45),
    sub_zone VARCHAR(45),
    region VARCHAR(45)
);

-- Table 2: fact_post_invoice_deductions
CREATE TABLE fact_post_invoice_deductions (
    customer_code INT,
    product_code VARCHAR(45),
    date DATE,
    discounts_pct DECIMAL(5, 4),
    other_deductions_pct DECIMAL(5, 4),
    PRIMARY KEY (customer_code, product_code, date),  -- Primary Key
    UNIQUE (product_code, date)  -- Add a unique constraint on product_code and date
);

-- Table 3: fact_pre_invoice_deductions
CREATE TABLE fact_pre_invoice_deductions (
    customer_code INT,
    fiscal_year INT,
    pre_invoice_discount_pct DECIMAL(5, 4),
    PRIMARY KEY (customer_code, fiscal_year)  -- Unique key constraint
);

-- Table 4: dim_product
CREATE TABLE dim_product (
    product_code VARCHAR(45) PRIMARY KEY,
    division VARCHAR(45),
    segment VARCHAR(45),
    category VARCHAR(45),
    product VARCHAR(200),
    variant VARCHAR(45)
);

-- Table 5: fact_sales_monthly
CREATE TABLE fact_sales_monthly (
    date DATE,
    product_code VARCHAR(45),
    customer_code INT,
    sold_quantity INT,
    fiscal_year INT, 
    PRIMARY KEY (date, product_code, customer_code),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code),
    FOREIGN KEY (product_code, date) REFERENCES fact_post_invoice_deductions(product_code, date),
    FOREIGN KEY (customer_code, fiscal_year) REFERENCES fact_pre_invoice_deductions(customer_code, fiscal_year),
	FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);



-- Table 6: fact_forecast_monthly
CREATE TABLE fact_forecast_monthly (
    date DATE,
    fiscal_year INT,
    product_code VARCHAR(45),
    customer_code INT,
    forecast_quantity INT,
    PRIMARY KEY (date, product_code, customer_code), 
    FOREIGN KEY (date, product_code, customer_code) REFERENCES fact_sales_monthly(date, product_code, customer_code), 
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);



-- Table 7: fact_manufacturing_cost
CREATE TABLE fact_manufacturing_cost (
    product_code VARCHAR(45),
    cost_year INT,
    manufacturing_cost DECIMAL(15, 4),
    PRIMARY KEY (product_code, cost_year),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

-- Table 8: fact_freight_cost
CREATE TABLE fact_freight_cost (
    Market VARCHAR(45),
    fiscal_year INT,
    freight_pct DECIMAL(5, 4),
    other_cost_pct DECIMAL(5, 4),
    PRIMARY KEY (Market, fiscal_year)
);

-- Table 9: fact_gross_price
CREATE TABLE fact_gross_price (
    product_code VARCHAR(45),
    fiscal_year INT,
    gross_price DECIMAL(15, 4),
    PRIMARY KEY (product_code, fiscal_year),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

INSERT INTO dim_customer (customer_code, customer, platform, channel, market, sub_zone, region)
VALUES
(7002101, 'Customer 1', 'E-Commerce', 'Direct', 'USA', 'NE', 'NA'),
(7002102, 'Customer 2', 'E-Commerce', 'Direct', 'USA', 'NE', 'NA'),
(7002103, 'Customer 3', 'E-Commerce', 'Direct', 'Canada', 'NA', 'NA'),
(7002104, 'Customer 4', 'E-Commerce', 'Direct', 'Canada', 'NA', 'NA'),
(7002105, 'Customer 5', 'E-Commerce', 'Direct', 'Mexico', 'LATAM', 'LATAM'),
(7002106, 'Customer 6', 'E-Commerce', 'Direct', 'Brazil', 'LATAM', 'LATAM'),
(7002107, 'Customer 7', 'E-Commerce', 'Direct', 'Germany', 'EU', 'EU'),
(7002108, 'Customer 8', 'E-Commerce', 'Direct', 'France', 'EU', 'EU'),
(7002109, 'Customer 9', 'Brick & Mortar', 'Direct', 'UK', 'EU', 'EU'),
(7002110, 'Customer 10', 'Brick & Mortar', 'Direct', 'Australia', 'APAC', 'APAC');

INSERT INTO dim_product (product_code, division, segment, category, product, variant)
VALUES
('P001', 'Electronics', 'Mobile', 'Smartphones', 'iPhone 13', 'Pro Max'),
('P002', 'Electronics', 'Mobile', 'Smartphones', 'Samsung Galaxy S21', 'Ultra'),
('P003', 'Electronics', 'Mobile', 'Smartphones', 'Google Pixel 6', 'Pro'),
('P004', 'Electronics', 'Mobile', 'Smartphones', 'OnePlus 9 Pro', '5G'),
('P005', 'Electronics', 'Mobile', 'Smartphones', 'Xiaomi Mi 11', 'Pro'),
('P006', 'Electronics', 'Mobile', 'Smartphones', 'Sony Xperia 1 III', '5G'),
('P007', 'Electronics', 'Mobile', 'Smartphones', 'Motorola Edge+', '5G'),
('P008', 'Electronics', 'Mobile', 'Smartphones', 'Oppo Find X3 Pro', '5G'),
('P009', 'Electronics', 'Mobile', 'Smartphones', 'Vivo V21 5G', 'Pro'),
('P010', 'Electronics', 'Mobile', 'Smartphones', 'Realme GT', 'Master Edition');

INSERT INTO fact_post_invoice_deductions (customer_code, product_code, date, discounts_pct, other_deductions_pct)
VALUES
(7002101, 'P001', '2022-01-01', 0.05, 0.02),
(7002102, 'P002', '2022-01-02', 0.07, 0.03),
(7002103, 'P003', '2022-01-03', 0.04, 0.01),
(7002104, 'P004', '2022-01-04', 0.06, 0.02),
(7002105, 'P005', '2022-01-05', 0.08, 0.03),
(7002106, 'P006', '2022-01-06', 0.03, 0.01),
(7002107, 'P007', '2022-01-07', 0.09, 0.04),
(7002108, 'P008', '2022-01-08', 0.05, 0.02),
(7002109, 'P009', '2022-01-09', 0.06, 0.03),
(7002110, 'P010', '2022-01-10', 0.07, 0.02),
(7002101, 'P001', '2022-02-01', 0.05, 0.02),
(7002102, 'P002', '2022-02-02', 0.07, 0.03),
(7002103, 'P003', '2022-02-03', 0.04, 0.01),
(7002104, 'P004', '2022-02-04', 0.06, 0.02),
(7002105, 'P005', '2022-02-05', 0.08, 0.03),
(7002106, 'P006', '2022-02-06', 0.03, 0.01),
(7002107, 'P007', '2022-02-07', 0.09, 0.04),
(7002108, 'P008', '2022-02-08', 0.05, 0.02),
(7002109, 'P009', '2022-02-09', 0.06, 0.03),
(7002110, 'P010', '2022-02-10', 0.07, 0.02),
(7002101, 'P001', '2022-03-01', 0.05, 0.02),
(7002102, 'P002', '2022-03-02', 0.07, 0.03),
(7002103, 'P003', '2022-03-03', 0.04, 0.01),
(7002104, 'P004', '2022-03-04', 0.06, 0.02),
(7002105, 'P005', '2022-03-05', 0.08, 0.03),
(7002106, 'P006', '2022-03-06', 0.03, 0.01),
(7002107, 'P007', '2022-03-07', 0.09, 0.04),
(7002108, 'P008', '2022-03-08', 0.05, 0.02);


--  insert into fact_pre_invoice_deductions 
INSERT INTO fact_pre_invoice_deductions (customer_code, fiscal_year, pre_invoice_discount_pct)
VALUES
(7002101, 2022, 0.05),
(7002102, 2022, 0.07),
(7002103, 2022, 0.04),
(7002104, 2022, 0.06),
(7002105, 2022, 0.08),
(7002106, 2022, 0.03),
(7002107, 2022, 0.09),
(7002108, 2022, 0.05),
(7002109, 2022, 0.06),
(7002110, 2022, 0.07),

(7002101, 2023, 0.06),
(7002102, 2023, 0.08),
(7002103, 2023, 0.05),
(7002104, 2023, 0.07),
(7002105, 2023, 0.09),
(7002106, 2023, 0.04),
(7002107, 2023, 0.10),
(7002108, 2023, 0.06),
(7002109, 2023, 0.07),
(7002110, 2023, 0.08),

(7002101, 2024, 0.07),
(7002102, 2024, 0.09),
(7002103, 2024, 0.06),
(7002104, 2024, 0.08),
(7002105, 2024, 0.10),
(7002106, 2024, 0.05),
(7002107, 2024, 0.11),
(7002108, 2024, 0.07),
(7002109, 2024, 0.08),
(7002110, 2024, 0.09);

INSERT INTO fact_sales_monthly (date, product_code, customer_code, sold_quantity, fiscal_year)
VALUES
('2022-01-01', 'P001', 7002101, 100, 2022),
('2022-01-02', 'P002', 7002102, 150, 2022),
('2022-01-03', 'P003', 7002103, 200, 2022),
('2022-01-04', 'P004', 7002104, 120, 2022),
('2022-01-05', 'P005', 7002105, 130, 2022),
('2022-01-06', 'P006', 7002106, 110, 2022),
('2022-01-07', 'P007', 7002107, 140, 2022),
('2022-01-08', 'P008', 7002108, 160, 2022),
('2022-01-09', 'P009', 7002109, 170, 2022),
('2022-01-10', 'P010', 7002110, 180, 2022),
('2022-02-01', 'P001', 7002101, 110, 2022),
('2022-02-02', 'P002', 7002102, 155, 2022),
('2022-02-03', 'P003', 7002103, 205, 2022),
('2022-02-04', 'P004', 7002104, 125, 2022),
('2022-02-05', 'P005', 7002105, 135, 2022),
('2022-02-06', 'P006', 7002106, 115, 2022),
('2022-02-07', 'P007', 7002107, 145, 2022),
('2022-02-08', 'P008', 7002108, 165, 2022),
('2022-02-09', 'P009', 7002109, 175, 2022),
('2022-02-10', 'P010', 7002110, 185, 2022),
('2022-03-01', 'P001', 7002101, 120, 2022),
('2022-03-02', 'P002', 7002102, 160, 2022),
('2022-03-03', 'P003', 7002103, 210, 2022),
('2022-03-04', 'P004', 7002104, 130, 2022),
('2022-03-05', 'P005', 7002105, 140, 2022),
('2022-03-06', 'P006', 7002106, 120, 2022),
('2022-03-07', 'P007', 7002107, 150, 2022),
('2022-03-08', 'P008', 7002108, 170, 2022);

INSERT INTO fact_forecast_monthly (date, fiscal_year, product_code, customer_code, forecast_quantity)
VALUES
('2022-01-01', 2022, 'P001', 7002101, 120),
('2022-01-02', 2022, 'P002', 7002102, 160),
('2022-01-03', 2022, 'P003', 7002103, 210),
('2022-01-04', 2022, 'P004', 7002104, 130),
('2022-01-05', 2022, 'P005', 7002105, 140),
('2022-01-06', 2022, 'P006', 7002106, 125),
('2022-01-07', 2022, 'P007', 7002107, 145),
('2022-01-08', 2022, 'P008', 7002108, 160),
('2022-01-09', 2022, 'P009', 7002109, 170),
('2022-01-10', 2022, 'P010', 7002110, 180),
('2022-02-01', 2022, 'P001', 7002101, 125),
('2022-02-02', 2022, 'P002', 7002102, 165),
('2022-02-03', 2022, 'P003', 7002103, 215),
('2022-02-04', 2022, 'P004', 7002104, 135),
('2022-02-05', 2022, 'P005', 7002105, 145),
('2022-02-06', 2022, 'P006', 7002106, 130),
('2022-02-07', 2022, 'P007', 7002107, 150),
('2022-02-08', 2022, 'P008', 7002108, 165),
('2022-02-09', 2022, 'P009', 7002109, 175),
('2022-02-10', 2022, 'P010', 7002110, 185),
('2022-03-01', 2022, 'P001', 7002101, 130),
('2022-03-02', 2022, 'P002', 7002102, 170),
('2022-03-03', 2022, 'P003', 7002103, 220),
('2022-03-04', 2022, 'P004', 7002104, 140),
('2022-03-05', 2022, 'P005', 7002105, 150),
('2022-03-06', 2022, 'P006', 7002106, 135),
('2022-03-07', 2022, 'P007', 7002107, 155),
('2022-03-08', 2022, 'P008', 7002108, 170);

INSERT INTO fact_manufacturing_cost (product_code, cost_year, manufacturing_cost)
VALUES
('P001', 2022, 100.00),
('P002', 2022, 110.00),
('P003', 2022, 105.00),
('P004', 2022, 98.00),
('P005', 2022, 112.00),
('P006', 2022, 120.00),
('P007', 2022, 95.00),
('P008', 2022, 115.00),
('P009', 2022, 108.00),
('P010', 2022, 99.00),
('P001', 2023, 102.00),
('P002', 2023, 112.00),
('P003', 2023, 107.00),
('P004', 2023, 100.00),
('P005', 2023, 114.00),
('P006', 2023, 125.00),
('P007', 2023, 98.00),
('P008', 2023, 118.00),
('P009', 2023, 110.00),
('P010', 2023, 100.00),
('P001', 2024, 105.00),
('P002', 2024, 115.00),
('P003', 2024, 110.00),
('P004', 2024, 103.00),
('P005', 2024, 117.00),
('P006', 2024, 130.00),
('P007', 2024, 100.00),
('P008', 2024, 120.00),
('P009', 2024, 113.00),
('P010', 2024, 104.00);

INSERT INTO fact_freight_cost (Market, fiscal_year, freight_pct, other_cost_pct)
VALUES
('USA', 2022, 0.05, 0.02),
('Canada', 2022, 0.06, 0.03),
('Mexico', 2022, 0.07, 0.02),
('Brazil', 2022, 0.04, 0.01),
('Germany', 2022, 0.05, 0.02),
('France', 2022, 0.06, 0.03),
('UK', 2022, 0.05, 0.02),
('Australia', 2022, 0.04, 0.01),
('USA', 2023, 0.06, 0.03),
('Canada', 2023, 0.07, 0.04),
('Mexico', 2023, 0.08, 0.03),
('Brazil', 2023, 0.05, 0.02),
('Germany', 2023, 0.06, 0.03),
('France', 2023, 0.07, 0.04),
('UK', 2023, 0.06, 0.03),
('Australia', 2023, 0.05, 0.02),
('USA', 2024, 0.07, 0.04),
('Canada', 2024, 0.08, 0.05),
('Mexico', 2024, 0.09, 0.04),
('Brazil', 2024, 0.06, 0.03),
('Germany', 2024, 0.07, 0.04),
('France', 2024, 0.08, 0.05),
('UK', 2024, 0.07, 0.04),
('Australia', 2024, 0.06, 0.03);

INSERT INTO fact_gross_price (product_code, fiscal_year, gross_price)
VALUES
('P001', 2022, 999.99),
('P002', 2022, 1099.99),
('P003', 2022, 899.99),
('P004', 2022, 999.99),
('P005', 2022, 899.99),
('P006', 2022, 1099.99),
('P007', 2022, 899.99),
('P008', 2022, 999.99),
('P009', 2022, 949.99),
('P010', 2022, 999.99),
('P001', 2023, 1050.00),
('P002', 2023, 1150.00),
('P003', 2023, 950.00),
('P004', 2023, 1050.00),
('P005', 2023, 950.00),
('P006', 2023, 1150.00),
('P007', 2023, 950.00),
('P008', 2023, 1050.00),
('P009', 2023, 1000.00),
('P010', 2023, 1050.00),
('P001', 2024, 1100.00),
('P002', 2024, 1200.00),
('P003', 2024, 1000.00),
('P004', 2024, 1100.00),
('P005', 2024, 1000.00),
('P006', 2024, 1200.00),
('P007', 2024, 1000.00),
('P008', 2024, 1100.00),
('P009', 2024, 1050.00),
('P010', 2024, 1100.00);
