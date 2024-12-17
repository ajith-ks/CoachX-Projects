--create database Workforce_Income_Analysis
use Workforce_Income_Analysis

--Task 1

--Investigating the job market based on company size in 2021:
--Task: You need to count how many employees are working in different companies, categorized by size (S, M, L).
select company_size, count(*) as employees_working from salaries
where work_year = 2021
group by company_size


-- Task 2
-- Top 3 job titles with the highest average salary for part-time positions in 2023:
--Task: Identify the highest-paying job titles for part-time positions while ensuring you only include countries with more than 50 employees.
select top 3 job_title, AVG(salary) as avg_salary, count(*) as employee_count from salaries
where employment_type = 'PT' and
company_location in (select company_location from salaries group by company_location having count(*) > 50 )
group by job_title
order by avg_salary desc
 

 -- task 3
 --Countries where mid-level salary is higher than the overall mid level salary in 2023:
 --Task: Identify countries where the average salary for mid-level employees (MI) is greater than the overall average for that level.
 select company_location, round(AVG(salary),1) as avg_salary from salaries
 where experience_level = 'MI'
 group by company_location
 having AVG(salary) > (select avg(salary) from salaries)
 order by avg_salary desc



 --task 4
--Highest and lowest average salary locations for senior-level employees in 2023:
--Task: Identify which countries pay seniorlevel (SE) employees the highest and lowest average salaries.

with salaryLocation as(
select company_location, avg(salary_in_usd) as avg_salary from salaries where experience_level = 'SE' and work_year = 2023 group by company_location 
)
select company_location, avg_salary from salaryLocation 
where avg_salary = (select MIN(avg_salary) from salaryLocation) or avg_salary = (select MAX(avg_salary) from salaryLocation) ;

--Task 5
--Salary growth rates by job title: Task: Calculate the percentage increase in salaries for various job titles between two years (e.g., 2023 and 2024).

WITH salaryComparison AS (
select s1.job_title,
avg( s1.salary_in_usd) AS salary_2023,
avg(s2.salary_in_usd) AS salary_2024
from salaries s1
JOIN salaries s2 ON s1.job_title = s2.job_title
WHERE s1.work_year = 2023 and s2.work_year = 2024
group by s1.job_title
)
select job_title,salary_2023,salary_2024,
ROUND(((salary_2024 - salary_2023) / salary_2023) * 100, 2) AS salary_growth_percentage
from salaryComparison;

--task 6
--Top three countries with the highest salary growth for entrylevel roles from 2020 to 2023:with salarycomparison as (
select company_location,
avg(case when work_year = 2020 then salary_in_usd end) as salary_2020,
avg(case when work_year = 2023 then salary_in_usd end) as salary_2023,
count(*) as employee_count
from salaries where experience_level = 'EN'  and (work_year = 2020 or work_year = 2023)  
group by company_location
--having count(*) > 50  
)
select top 3 company_location, salary_2020, salary_2023,
round(((salary_2023 - salary_2020) / salary_2020) * 100, 2) as salary_growth_percentage 
from salarycomparison
order by salary_growth_percentage desc;

-- Task 7
-- Updating remote work ratio for employees earning more than $90,000 in the US and AU:
-- Task: Update the remote_ratio for employees based on their salary and location.

update salaries
set remote_ratio = 100
where salary_in_usd > 90000
and employee_residence in ('US', 'AU');

--Task 8 
--Salary updates based on percentage increases by level in 2024:
-- Task: Update the salaries for various experience levels (SE, MI, etc.) according to predefined percentage increases.
update salaries
set salary_in_usd = salary_in_usd * 
case
when experience_level = 'SE' then 1.22  
when experience_level = 'MI' then 1.30  
when experience_level = 'EN' then 1.15  
when experience_level = 'EX' then 1.10  
else salary_in_usd  -- no change for other levels
end
where work_year = 2024;


-- Task 9
--Year with the highest average salary for each job title:
--Task: Identify which year had the highest average salary for each job title. 
with avg_salary_per_year as (
select job_title,work_year,
avg(salary_in_usd) as avg_salary
from salaries
group by job_title, work_year
)
select a.job_title,a.work_year,a.avg_salary
from avg_salary_per_year a
inner join (
select job_title,max(avg_salary) as max_avg_salary from avg_salary_per_year group by job_title
) b on a.job_title = b.job_title and a.avg_salary = b.max_avg_salary;


--task 10
-- Percentage of employment types for different job titles:
--Task: Calculate the percentage of full-time and part-time employees for each job title.
with employment_counts as (
select job_title, employment_type, count(*) as employee_count
from salaries
group by  job_title, employment_type
)
select job_title,
round(
(cast(sum(case when employment_type = 'FT' then employee_count else 0 end) as float) * 100.0) / 
sum(employee_count), 
2) as full_time_percentage,
round(
(cast(sum(case when employment_type = 'PT' then employee_count else 0 end) as float)* 100.0) / 
sum(employee_count), 
2) as part_time_percentage
from employment_counts
group by job_title;

--task 11
--COUNTRIES OFFERING FULL REMOTE WORK FOR MANAGERS WITH SALARIES OVER $90,000:
--TASK: FIND COUNTRIES WHERE MANAGERS EARN MORE THAN $90,000 AND WORK FULLY REMOTELY.
select employee_residence, count(*) as manager_count
from salaries
where job_title like '%Manager%' and salary_in_usd > 90000  and remote_ratio = 100    
group by employee_residence
order by manager_count desc;

--task 12
--Top 5 countries with the most large companies:
-- Task: Identify which countries have the highest number of large companies.
select top 5 company_location, count(*) as large_company_count
from salaries
where company_size = 'L' 
group by company_location
order by large_company_count desc;

--task 13
--Percentage of employees with fully remote roles earning more than $100,000:
--Task: Calculate the percentage of fully remote employees earning more than $100,000.
select round(
(cast(count(case when remote_ratio = 100 and salary_in_usd > 100000 then 1 end) as float) * 100) / cast(count(*) as float), 2
) as percentage_remote_over_100k
from salaries;
--task 14
--Locations where entry-level average salaries exceed market average for entry level:
--Task: Identify locations where entrylevel salaries surpass the market average.
with market_avg as (
select avg(salary_in_usd) as market_average
from salaries
where experience_level = 'EN'
),
location_avg as (
select company_location,avg(salary_in_usd) as location_average
from salaries
where experience_level = 'EN'
group by company_location
)
select la.company_location, la.location_average
from location_avg la
join market_avg ma on la.location_average > ma.market_average;

-- task 15
--Countries paying the maximum average salary for each job title:
--Task: For each job title, identify which country pays the highest average salary. 
with job_title_avg as (
select job_title, employee_residence, round(avg(salary_in_usd),2) as avg_salary
from salaries
group by job_title, employee_residence
)
select job_title, employee_residence, avg_salary
from job_title_avg j1
where avg_salary = (select max(avg_salary) from job_title_avg j2 where j2.job_title = j1.job_title);

--task 16
--Countries with sustained salary growth over three years:
--Task: Identify countries with consistent salary growth over the past three years.
with yearly_avg_salaries as (
select employee_residence, work_year, ROUND( avg(salary_in_usd),2) as avg_salary
from salaries
where work_year in (2021, 2022, 2023)
group by employee_residence, work_year
),
salary_growth as (
select a.employee_residence, a.avg_salary as salary_2021, b.avg_salary as salary_2022,  c.avg_salary as salary_2023
from yearly_avg_salaries a
join yearly_avg_salaries b on a.employee_residence = b.employee_residence and a.work_year = 2021 and b.work_year = 2022
join yearly_avg_salaries c on a.employee_residence = c.employee_residence and a.work_year = 2021 and c.work_year = 2023
)
select employee_residence, salary_2021, salary_2022, salary_2023 from salary_growth
where salary_2022 > salary_2021 and salary_2023 > salary_2022;

--task 17
-- PERCENTAGE OF FULLY REMOTE WORK BY EXPERIENCE LEVEL (2021 VS 2024):
-- TASK: COMPARE THE ADOPTION OF FULLY REMOTE WORK ACROSS EXPERIENCE LEVELS BETWEEN 2021 AND 2024.
with remote_percentage as (
select experience_level, work_year,
round(cast(count(case when remote_ratio = 100 then 1 end) as float) / count(*) * 100,2) as remote_percentage
from salaries
where work_year in (2021, 2024)
group by experience_level, work_year
)
select experience_level,
max(case when work_year = 2021 then remote_percentage end) as remote_percentage_2021,
max(case when work_year = 2024 then remote_percentage end) as remote_percentage_2024
from remote_percentage
group by experience_level;

--task 18
--Average salary increase percentage by experience level and job title (2023 to 2024):
-- Task: Calculate the average salary increase for each experience level and job title.
with salary_increase as (
select a.experience_level, a.job_title, a.salary_in_usd as salary_2023, b.salary_in_usd as salary_2024,
cast((b.salary_in_usd - a.salary_in_usd) as float) / a.salary_in_usd * 100 as salary_increase_percentage
from salaries a
join salaries b on a.experience_level = b.experience_level and a.job_title = b.job_title and a.work_year = 2023 and b.work_year = 2024
)
select experience_level, job_title, round(avg(salary_increase_percentage),2) as avg_salary_increase_percentage
from salary_increase
group by experience_level, job_title
order by avg_salary_increase_percentage desc;


--task 19
--Role-based access control for employees based on experience level:
--Task: Implement security to restrict access based on an employee's experience level.
-- View for Entry-Level Employees (EL)
create procedure get_employee_data_by_experience_level
@user_experience_level varchar(5)
as
begin
select experience_level, salary_in_usd, company_location, work_year,employment_type, job_title
from salaries
where experience_level = @user_experience_level;
end;

exec get_employee_data_by_experience_level 'MI';

-- task 20
--Guiding clients in switching domains based on salary insights:
--Task: Based on an employee's data (experience, job title, location), suggest new domains they can transition to, based on salary trends.

with salary_growth_cte as (
select job_title, company_location, experience_level ,
round(avg(case when work_year = 2023 then salary_in_usd end),2) as salary_2023,
round(avg(case when work_year = 2024 then salary_in_usd end),2) as salary_2024
from salaries
where work_year in (2023, 2024)
group by job_title, company_location,experience_level
)
select job_title, company_location,experience_level, salary_2023, salary_2024,
round(((salary_2024 - salary_2023) / salary_2023) * 100,2) as salary_growth_percentage
from salary_growth_cte
where ((salary_2024 - salary_2023) / salary_2023) * 100 > 10 
order by salary_growth_percentage desc;



