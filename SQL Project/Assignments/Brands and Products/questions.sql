-- Basic questions

--1. Create two Databases Name :- Brands , and Products
--create Database Brands
--create Database Products
use Brands
--2. Create two tables in SQL Server name as ITEMS_TABLE in Brands database and PRODUCT_TABLE in Products database.
-- item table
CREATE TABLE brands.dbo.ITEMS_TABLE (
    Item_Id INT,
    item_description VARCHAR(255),
    vendor_nos INT,
    vendor_name VARCHAR(255),
    bottle_size INT,
    bottle_price DECIMAL(10, 2)
);
--product table
CREATE TABLE products.dbo.PRODUCTS_SALES_TABLE (
    Product_Id INT,
    Country VARCHAR(20),
    Product VARCHAR(255),
    Units_Sold DECIMAL(10, 2),
    Manufacturing_Price INT,
    Sale_Price INT,
    Gross_Sales INT,
    Sales INT,
    COGS INT,
    Profit INT,
    Date DATE,
    Month_Number INT,
    Month_Name VARCHAR(10),
    Year INT
);

--3. After Creating both the tables Add records in that tables (records are available in ITEMS_TABLE Sheet and PRODUCTS_TABLE Sheet)
-- adding data to items table
INSERT INTO brands.dbo.ITEMS_TABLE (Item_Id, item_description, vendor_nos, vendor_name, bottle_size, bottle_price) VALUES
(1, 'Travis Hasse Apple Pie', 305, 'Mhw Ltd', 750, 9.77),
(2, 'D''aristi Xtabentun', 391, 'Anchor Distilling (preiss Imports)', 750, 14.12),
(3, 'Hiram Walker Peach Brandy', 370, 'Pernod Ricard Usa/austin Nichols', 1000, 6.5),
(4, 'Oak Cross Whisky', 305, 'Mhw Ltd', 750, 25.33),
(5, 'Uv Red(cherry) Vodka', 380, 'Phillips Beverage Company', 200, 1.97),
(6, 'Heaven Hill Old Style White Label', 259, 'Heaven Hill Distilleries Inc.', 750, 6.37),
(7, 'Hyde Herbal Liqueur', 194, 'Fire Tail Brands Llc', 750, 5.06),
(8, 'Dupont Calvados Fine Reserve', 403, 'Robert Kacher Selections', 750, 23.61);

--adding data into products table
INSERT INTO products.dbo.PRODUCTS_SALES_TABLE (Product_Id, Country, Product, Units_Sold, Manufacturing_Price, Sale_Price, Gross_Sales, Sales, COGS, Profit, Date, Month_Number, Month_Name, Year) VALUES
(1, 'Canada', 'Carretera', 1618.5, 3, 20, 32370, 32370, 16185, 16185, '2014-01-01', 1, 'January', 2014),
(2, 'Germany', 'Carretera', 1321, 3, 20, 26420, 26420, 13210, 13210, '2015-01-01', 1, 'January', 2015),
(3, 'France', 'Carretera', 2178, 3, 15, 32670, 32670, 21780, 10890, '2016-06-01', 6, 'June', 2016),
(4, 'Germany', 'Carretera', 888, 3, 15, 13320, 13320, 8880, 4440, '2017-06-01', 6, 'June', 2017),
(5, 'Mexico', 'Carretera', 2470, 3, 15, 37050, 37050, 24700, 12350, '2018-06-01', 6, 'June', 2018),
(6, 'Germany', 'Carretera', 1513, 3, 350, 529550, 529550, 393380, 136170, '2019-12-01', 12, 'December', 2019),
(7, 'Germany', 'Montana', 921, 5, 15, 13815, 13815, 9210, 4605, '2020-03-01', 3, 'March', 2020),
(8, 'Canada', 'Montana', 2518, 5, 12, 30216, 30216, 22662, 7554, '2021-06-01', 6, 'June', 2021);
--truncate table products_sales_table
--4. Delete those product having the Units Sold 1618.5 , 888 and 2470.
delete from products.dbo.PRODUCTS_SALES_TABLE where Units_Sold in (1618.5 , 888 , 2470)
--5. Select all records from the bottle_info table.
select * from brands.dbo.ITEMS_TABLE
--6. Select the item_description and bottle_price for all items in the bottle_info table.
select item_description,bottle_price from brands.dbo.ITEMS_TABLE
--7. Find the item_description and bottle_price of items where bottle_price is greater than 20.
select item_description,bottle_price from brands.dbo.ITEMS_TABLE where bottle_price > 20
--8. Select Unique Country from the product_sales table
select distinct country from products.dbo.PRODUCTS_SALES_TABLE 
--9. Count the number of Countries in the product_sales table
select count(distinct country) as total_countries from products.dbo.PRODUCTS_SALES_TABLE 
--10. How Many Countries are there which contain the sales price between 10 to 20 
select count(distinct country) as total_countries from products.dbo.PRODUCTS_SALES_TABLE where Sale_Price between 10 and 20

--Intermediate Questions
--------------------------------------------------------------------------------------------------------------------------------------------
--PRODUCTS_SALES_TABLE:-
---------------------------------------------------
--1. Find the Total Sale Price and Gross Sales
select sum(Sale_Price) as total_sale_price, sum(Gross_Sales) as total_gross_sales from products.dbo.PRODUCTS_SALES_TABLE
--2. In which year we have got the highest sales
select * from products.dbo.PRODUCTS_SALES_TABLE where Sales = (select MAX(sales) from products.dbo.PRODUCTS_SALES_TABLE)
select top 1 * from products.dbo.PRODUCTS_SALES_TABLE order by Sales desc 
--3. Which Product having the sales of $ 37,050.00
select PRODUCT, sales from products.dbo.PRODUCTS_SALES_TABLE where Sales = 37050
--4. Which Countries lies between profit of $ 4,605 to $ 22 , 662.00
select distinct Country from products.dbo.PRODUCTS_SALES_TABLE where Profit between 4605 and 22662
--5. Which Product Id having the sales of $ 24 , 700.00
select Product_Id from products.dbo.PRODUCTS_SALES_TABLE where Sales = 24700
--6. Find the total Units Sold for each Country.
select Country, sum(Units_Sold) as total_units from products.dbo.PRODUCTS_SALES_TABLE group by Country
--7. Find the average sales for each country
select Country, avg(Sales) as avg_sales from products.dbo.PRODUCTS_SALES_TABLE group by Country
--8. Retrieve all products sold in 2014
select * from products.dbo.PRODUCTS_SALES_TABLE where Year = 2014
--9. Find the maximum Profit in the product_sales table.
select * from products.dbo.PRODUCTS_SALES_TABLE where Profit = (select max(Profit) from products.dbo.PRODUCTS_SALES_TABLE)
--10. Retrieve the records from product_sales where Profit is greater than the average Profit of all records.
select * from products.dbo.PRODUCTS_SALES_TABLE where Profit > (select avg(Profit) from products.dbo.PRODUCTS_SALES_TABLE)
--11. Find the item_description having the bottle size of 750
select item_description from ITEMS_TABLE where bottle_size = 750
--12. Find the vendor Name having the vendor_nos 305 , 380 ,391
select vendor_name from brands.dbo.ITEMS_TABLE where vendor_nos in (305 , 380 ,391)
--13. What is total Bottle_price
select sum(bottle_price) as total_bottle_price from brands.dbo.ITEMS_TABLE
--14. Make Primary Key to Item_id
alter table brands.dbo.items_table alter column item_id int not null
alter table brands.dbo.items_table add primary key(item_id)
--15. Which item id having the bottle_price of $ 5.06
select item_id from brands.dbo.ITEMS_TABLE where bottle_price = 5.06


--Advance Questions:-
--------------------------------------------------------------------------------------------------------------------------------------------
--1. Apply INNER , FULL OUTER , LEFT JOIN types on both the table
--inner join
select * from brands.dbo.ITEMS_TABLE i 
join products.dbo.PRODUCTS_SALES_TABLE p on i.Item_Id = p.Product_Id
-- full outer join
select * from brands.dbo.ITEMS_TABLE i 
full outer join products.dbo.PRODUCTS_SALES_TABLE p on i.Item_Id = p.Product_Id
--left join
select * from brands.dbo.ITEMS_TABLE i 
left join products.dbo.PRODUCTS_SALES_TABLE p on i.Item_Id = p.Product_Id
--2. Find the item_description and Product having the gross sales of 13,320.00
select i.item_description, p.Product from brands.dbo.ITEMS_TABLE i 
join products.dbo.PRODUCTS_SALES_TABLE p on i.Item_Id = p.Product_Id
where p.Gross_Sales = 13320
--3. Split the Item_description Column into Columns Item_desc1 and Item_desc2
ALTER TABLE brands.dbo.ITEMS_TABLE
ADD Item_desc1 VARCHAR(255),Item_desc2 VARCHAR(255);


update brands.dbo.ITEMS_TABLE 
set item_desc1 = left(item_description, CHARINDEX(' ', item_description)) ,
item_desc2 = ltrim(SUBSTRING(item_description, CHARINDEX(' ', item_description ),LEN(item_description)))

select * from Brands.dbo.ITEMS_TABLE
--4. Find the top 3 most expensive items in the bottle_info table.
select top 3 * from Brands.dbo.ITEMS_TABLE order by bottle_price desc
--5. Find the total Gross Sales and Profit for each Product in each Country.
select Country, SUM(Gross_Sales) as Total_gross_sales, SUM(profit) as Total_profit from Products.dbo.PRODUCTS_SALES_TABLE
group by Country
--6. Find the vendor_name and item_description of items with a bottle_size of 750 and bottle_price less than 10.
select vendor_name, item_description from Brands.dbo.ITEMS_TABLE
where bottle_price > 10 and bottle_size =750
--7. Find the Product with the highest Profit in 2019.
-- assuming the total profit
select top 1 Product,year, SUM(profit) as total_profit from Products.dbo.PRODUCTS_SALES_TABLE
where year = 2019
group by product, Year
order by total_profit
-- assuming individual profit
select top 1 product , year, profit from Products.dbo.PRODUCTS_SALES_TABLE
where year = 2019
order by Profit desc
--8. Retrieve the Product_Id and Country of all records where the Profit is at least twice the COGS.
select Product_Id,Country from Products.dbo.PRODUCTS_SALES_TABLE
where profit >= COGS*2
--9. Find the Country that had the highest total Gross Sales in 2018
select top 1 Country,year, SUM(Gross_Sales) as total_gross_sales from Products.dbo.PRODUCTS_SALES_TABLE
where year = 2018
group by Country, Year
order by total_gross_sales desc
--10. Calculate the total Sales for each Month Name across all years.
select Month_Name,year, SUM(Sales) as total_sales from Products.dbo.PRODUCTS_SALES_TABLE
group by  Year,Month_Name
order by year
--11. List the item_description and vendor_name for items whose vendor_nos exists more than once in the bottle_info table.
select item_description, vendor_name from Brands.dbo.ITEMS_TABLE 
where vendor_nos in (
select vendor_nos from Brands.dbo.ITEMS_TABLE group by vendor_nos having count(vendor_nos) > 1)
--12. Find the average Manufacturing Price for Product in each Country and only include those Country and Product combinations where the average is above 3
select Country, Product, AVG(Manufacturing_Price) as AVG_Manufacturing_Price from Products.dbo.PRODUCTS_SALES_TABLE
group by Country, Product
having avg(Manufacturing_Price) > 3



--Super-Advance Questions:-
--------------------------------------------------------------------------------------------------------------------------------------------
--1. Find the item_description and bottle_price of items that have the same vendor_name as items with Item_Id 1.
select item_description, bottle_price from Brands.dbo.ITEMS_TABLE
where vendor_name = (select vendor_name from Brands.dbo.ITEMS_TABLE where Item_Id =1)
--2. Create a stored procedure to retrieve all records from the bottle_info table where bottle_price is greater than a given value
create procedure SP_get_info_by_price
@price decimal
as
begin
select * from Brands.dbo.ITEMS_TABLE
where bottle_price > @price
end;
exec SP_get_info_by_price 9
--3. Create a stored procedure to insert a new record into the product_sales table.
create procedure SP_insert_into_sales
@Product_Id INT,
@Country VARCHAR(20),
@Product VARCHAR(255),
@Units_Sold DECIMAL(10, 2),
@Manufacturing_Price INT,
@Sale_Price INT,
@Gross_Sales INT,
@Sales INT,
@COGS INT,
@Profit INT,
@Date DATE,
@Month_Number INT,
@Month_Name VARCHAR(10),
@Year INT
As
begin
INSERT INTO products.dbo.PRODUCTS_SALES_TABLE (
Product_Id, Country, Product, Units_Sold, Manufacturing_Price, Sale_Price, Gross_Sales, Sales, COGS, Profit, Date, Month_Number, Month_Name, Year) 
VALUES 
(@Product_Id, @Country, @Product, @Units_Sold, @Manufacturing_Price, @Sale_Price, @Gross_Sales, @Sales, @COGS, @Profit, @Date, @Month_Number, @Month_Name, @Year)
end;
exec SP_insert_into_sales 10, 'India', 'test item', 20, 4, 454, 3433, 2432, 3, 343, '2024-01-01',1,'January', 2024


select * from Products.dbo.PRODUCTS_SALES_TABLE


--4. Create a trigger to automatically update the Gross_Sales field in the product_sales table whenever Units_Sold or Sale_Price is updated.
use Products;
create trigger tgr_update_gross_sales
on products.dbo.PRODUCTS_SALES_TABLE
after update
As 
begin
	if UPDATE(units_sold) or UPDATE(sale_price)
	begin
		update Products.dbo.PRODUCTS_SALES_TABLE 
		set Gross_Sales = i.Units_Sold * i.Sale_Price
		from Products.dbo.PRODUCTS_SALES_TABLE p
		join inserted i
		on i.Product_Id = p.Product_Id;
	end;
end;

select * from sys.triggers where name = 'tgr_update_gross_sales'
select * from Products.dbo.PRODUCTS_SALES_TABLE where Product_Id =2
update Products.dbo.PRODUCTS_SALES_TABLE
set Units_Sold = 2
where Product_Id = 2;
select * from Products.dbo.PRODUCTS_SALES_TABLE where Product_Id =2
--5. Write a query to find all item_description in the bottle_info table that contain the word "Whisky" regardless of case.
select * from Brands.dbo.ITEMS_TABLE where item_description like '%whisky%'
--6. Write a query to find the Country and Product where the Profit is greater than the average Profit of all products.
select Country, Product from Products.dbo.PRODUCTS_SALES_TABLE where Profit > (select AVG(profit) from Products.dbo.PRODUCTS_SALES_TABLE)
--7. Write a query to join the bottle_info and product_sales tables on a common field (e.g., vendor_nos) and select relevant fields from both tables.
select p.Product_Id, i.Item_Id, p.Product, p.Country, i.item_description, i.vendor_name, i.vendor_nos from Products.dbo.PRODUCTS_SALES_TABLE p 
join Brands.dbo.ITEMS_TABLE i
on p.Product_Id = i.Item_Id
--8. Write a query to combine item_description and vendor_name into a single string for each record in the bottle_info table, separated by a hyphen.
select CONCAT(item_description, ' - ',vendor_name) as concated_string from Brands.dbo.ITEMS_TABLE
--9. Write a query to display the bottle_price rounded to one decimal place for each record in the bottle_info table.
Select ROUND(bottle_price,1) as Rounded_Bottle_Price from Brands.dbo.ITEMS_TABLE
--10. Write a query to calculate the number of days between the current date and the Date field for each record in the product_sales table.
select Product,DATEDIFF(DAY,Date,GETDATE()) as Days_Difference_as_Today from Products.dbo.PRODUCTS_SALES_TABLE



