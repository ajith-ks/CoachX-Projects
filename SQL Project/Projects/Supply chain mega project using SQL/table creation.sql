--create database SupplyChainFinanceManagement
use SupplyChainFinanceManagement;

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

-- Table 4: fact_sales_monthly
CREATE TABLE fact_sales_monthly (
    date DATE,
    product_code VARCHAR(45),
    customer_code INT,
    sold_quantity INT,
    fiscal_year INT,  -- Add fiscal_year to link with fact_pre_invoice_deductions
    PRIMARY KEY (date, product_code, customer_code),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code),
    FOREIGN KEY (product_code, date) REFERENCES fact_post_invoice_deductions(product_code, date),
    FOREIGN KEY (customer_code, fiscal_year) REFERENCES fact_pre_invoice_deductions(customer_code, fiscal_year) 
);

-- Table 5: dim_product
CREATE TABLE dim_product (
    product_code VARCHAR(45) PRIMARY KEY,
    division VARCHAR(45),
    segment VARCHAR(45),
    category VARCHAR(45),
    product VARCHAR(200),
    variant VARCHAR(45)
);

-- Table 6: fact_forecast_monthly
CREATE TABLE fact_forecast_monthly (
    date DATE,
    fiscal_year INT,
    product_code VARCHAR(45),
    customer_code INT,
    forecast_quantity INT,
    PRIMARY KEY (date, product_code, customer_code), -- Optional, for uniqueness within this table
    FOREIGN KEY (date, product_code, customer_code) REFERENCES fact_sales_monthly(date, product_code, customer_code), -- Reference composite key
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

-- dim_customer table
INSERT INTO dim_customer (customer_code, customer, platform, channel, market, sub_zone, region)
VALUES
(7002104, 'Atliq e Store', 'E-Commerce', 'Direct', 'Austria', 'NE', 'EU'),
(7002106, 'Atliq e Store', 'E-Commerce', 'Direct', 'United Kingdom', 'NE', 'EU'),
(7002204, 'Atliq Exclusive', 'Brick & Mortar', 'Direct', 'USA', 'NA', 'NA'),
(7002208, 'Atliq e Store', 'E-Commerce', 'Direct', 'USA', 'NA', 'NA'),
(7002205, 'Atliq e Store', 'E-Commerce', 'Direct', 'Canada', 'NA', 'NA'),
(7002301, 'Atliq Exclusive', 'Brick & Mortar', 'Direct', 'Canada', 'NA', 'NA'),
(7002302, 'Atliq e Store', 'E-Commerce', 'Direct', 'Canada', 'NA', 'NA'),
(7002260, 'Atliq e Store', 'E-Commerce', 'Direct', 'Mexico', 'LATAM', 'LATAM'),
(7002270, 'Atliq e Store', 'E-Commerce', 'Direct', 'Brazil', 'LATAM', 'LATAM'),
(8000109, 'Neptune', 'Brick & Mortar', 'Distributor', 'China', 'NA', 'APAC'),
(8000614, 'Synthetic', 'Brick & Mortar', 'Distributor', 'Philippines', 'ROA', 'APAC'),
(8000615, 'Novus', 'Brick & Mortar', 'Distributor', 'Philippines', 'ROA', 'APAC');
