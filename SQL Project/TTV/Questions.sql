/*
questions
design a db for media company
create 5 different types of table with multiple data types. all these tables should hold different informations
all these tables should have primary key
out of 5 tables 3 tables should have foreign key relationship
write down atleast 5 search queries (complex)
Write down atleast 2 update statement
write down atleast 2 delete statement
Your search criteria should be satisfied by either clusterd or non clusterd index
Alter 2 tables by adding new column
Alter 2 tables by deleting existing columns
create a view with join defenition 
Write 1 sub query using multiple tables with multiple operations
Write a cte query
Write a stored procedure accepting atleast 2 parameters */


use ttv;
-- retrieve shows and corresponding viewership statistics
select s.showtitle, r.name as reportername, c.categoryname, sum(v.viewcount) as totalviews from shows s
join reporters r on s.reporterid = r.reporterid
join categories c on s.categoryid = c.categoryid
join viewership v on s.showid = v.showid
group by s.showtitle, r.name, c.categoryname
order by totalviews desc;

-- list reporters with their shows
select r.reporterid, r.name as reportername, s.showtitle from reporters r
left join shows s on r.reporterid = s.reporterid order by r.reporterid;

-- get shows by category with view counts > 1500
select c.categoryname, avg(v.viewcount) as averageviewcount from categories c 
join shows s on c.categoryid = s.categoryid
join viewership v on s.showid = v.showid
group by c.categoryname
having avg(v.viewcount)  >1500
order by averageviewcount desc;

-- list viewership trends over time
select v.viewdate, sum(v.viewcount) as totalviews from viewership v
where v.showid = 1 and v.viewdate between '2024-01-01' and '2024-01-03'
group by v.viewdate
order by v.viewdate;

--reporters' contribution to categories
select r.name as reportername, c.categoryname, count(s.showid) as showcount from reporters r
left join shows s on r.reporterid = s.reporterid
left join categories c on s.categoryid = c.categoryid
group by r.name, c.categoryname
order by reportername, categoryname;

-- Write down atleast 2 update statement
-- Insert a new location
insert into Locations (LocationID, City, Country, Region) values
(6, 'Kannur', 'India', 'Kerala');

-- Insert a new viewership record
insert into Viewership (ViewershipID, ShowID, ViewCount, ViewDate) values
(19, 1, 3000, '2024-01-04');


-- write down atleast 2 delete statement
-- Delete the newly inserted location
delete from Locations 
where LocationID = 6;

-- Delete the newly inserted viewership record
delete from Viewership 
where ViewershipID = 19;

-- Your search criteria should be satisfied by either clusterd or non clusterd index
-- Clustered Index
-- Creating a clustered index on the LocationID column of the Locations table
create clustered index idx_locationid on Locations (LocationID);

-- Creating a clustered index on the ShowTitle column of the Shows table
create clustered index idx_showtitle on Shows (ShowTitle);

-- #### unable to create new clustered index due to having primary key already present in the table ####


-- Select Query Utilizing the PK on LocationID
select LocationID, City, Country, Region from Locations 
where LocationID = 3;  


-- Non-Clustered Index
-- Creating a non-clustered index on the Email column of the Reporters table
create nonclustered index idx_email on Reporters (Email);

-- Creating a non-clustered index on the name column of the Reporters table
create nonclustered index idx_name on Reporters (Name);
-- #### multiple non clustered index can be created for a single table

-- Select Query Utilizing the Non-Clustered Index on Email
select ReporterID, Name, HireDate from Reporters 
where Email = 'anita.menon@ttv.com'; 

-- Select Query Utilizing the Non-Clustered Index on name
select ReporterID, Name, HireDate from Reporters 
where name = 'anita menon'; 

-- Alter 2 tables by adding new column
-- Add PhoneNumber column to the Reporters table
alter table Reporters 
add PhoneNumber VARCHAR(15);

-- Add Rating column to the Shows table
alter table Shows 
add Rating DECIMAL(2, 1);  

-- Alter 2 tables by deleting existing columns
-- Delete PhoneNumber column from the Reporters table
alter table Reporters 
drop column PhoneNumber;

-- Delete Rating column from the Shows table
alter table Shows 
drop column Rating;

-- create a view with join defenition
-- Create a view that joins Shows, Reporters, and Categories
create view vw_show_details as
select s.ShowID, s.ShowTitle, r.Name as ReporterName, c.CategoryName, s.AirDate, s.Duration from Shows s
join Reporters r on s.ReporterID = r.ReporterID
join Categories c on s.CategoryID = c.CategoryID;

-- Select from the view
select * from vw_show_details;


-- Write 1 sub query using multiple tables with multiple operations
-- Select shows in the Politics category with view counts greater than the average view count for that category
select s.ShowTitle, v.ViewCount from Shows s
join Viewership v on s.ShowID = v.ShowID
where s.CategoryID = (select c.CategoryID from Categories c 
                    where c.CategoryName = 'Politics')
    and v.ViewCount > (select avg(v2.ViewCount) from Viewership v2 
                       join Shows s2 on v2.ShowID = s2.ShowID 
                       where s2.CategoryID = (select c.CategoryID from Categories c 
                                              where c.CategoryName = 'Politics'));


-- Write a cte query
-- Define the CTE to calculate average view counts by category
with AverageViewCounts as (
    select c.CategoryID, c.CategoryName, avg(v.ViewCount) as AvgViewCount from Categories c
    join Shows s on c.CategoryID = s.CategoryID
    join Viewership v on s.ShowID = v.ShowID
    group by c.CategoryID, c.CategoryName
)
select s.ShowTitle, s.ShowID, v.ViewCount, avc.AvgViewCount from Shows s
join Viewership v on s.ShowID = v.ShowID
join AverageViewCounts avc on s.CategoryID = avc.CategoryID
where v.ViewCount > avc.AvgViewCount;

-- Write a stored procedure accepting atleast 2 parameters
-- Create a stored procedure to get shows by category and minimum view count
/*
create procedure GetShowsByCategoryAndViewCount @CategoryID INT,  @MinimumViewCount INT as
begin
    select s.ShowTitle, s.ShowID, v.ViewCount, c.CategoryName from Shows s
    join Viewership v on s.ShowID = v.ShowID
    join Categories c on s.CategoryID = c.CategoryID
    where s.CategoryID = @CategoryID and v.ViewCount > @MinimumViewCount
    order by v.ViewCount desc;  
end;
*/

exec GetShowsByCategoryAndViewCount @CategoryID = 1, @MinimumViewCount = 1500;





