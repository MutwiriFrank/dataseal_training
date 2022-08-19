--1. Write a query to list first name, last name and their salary 
--for employee contained in the employees table.

select  first_name, last_name, salary 
from employees

--Write a query to display all the columns of employees table.

select column_name, data_type, character_maximum_length
    from INFORMATION_SCHEMA.COLUMNS 
    where table_name = 'employees';
    
  
-- Write a query to display first name, last name and their salary of employees
-- where column headings will be specified as aliases: FirstName, LastName and Salary.
   
  select first_name as FirstName, last_name as LastName, salary as Salary
  from employees
  
-- .Write a query to list first name, last name and their salary for 
-- first 10 employee contained in the employees table.

select first_name , last_name, salary
from employees 
limit 10


-- Write a query to list the name of all the employees who
-- are working in department number 2.

select first_name, last_name
from employees 
where department_id = 2


-- 2. Write a query to list the employees name and total salary of a year 
--and yearly salary is more than $100,000.

select first_name, last_name , salary
from employees e
where  salary > 10000
  

-- 3. Write a query to list the employees name and salary who?s daily 
--salary is more than $30000.

select first_name, last_name , salary
from employees e
where  salary > 30000


--4. Write a query to list the name of all the employees who are not working 
--in department number 2

select first_name, last_name, department_id 
from employees 
where department_id <> 2


--Write a query to list the names of all the employees who are working as 
--accountant in finance section and drawing a salary less than $20000.

select first_name, last_name, job_title, department_name, salary
from employees e
inner join jobs j on j.job_id = e.job_id
inner join departments d  on d.department_id  = e.department_id 
where j.job_title = 'Accountant' and d.department_name = 'Finance' and salary < 20000


-- Write a query to list the names, salary of all the employees who are working with a commission package.

select first_name, commission_pct 
from employees e 
where commission_pct is null


-- 9. Write a query to list the name, salary of all the employees where employee 
--first name belongs in a specified list.
 

select  first_name
from employees e 
where first_name in ('Steven', 'Neena', 'Lex' )

-- 10. Write a query to list the first name, last name, Job id of all the 
--employees except "PRESIDENT" & "MGR" in asc order of Salaries.
  
select first_name, last_name, j.job_id, j.job_title, salary 
from employees e
inner join jobs j on j.job_id = e.job_id
where j.job_title not in ('President', 'MGR') 
order by salary asc
 
  
--Write a query to list the name (first and last name), hire date of all the employees
-- who joined before or after 2005.

  select concat (first_name, ' ',last_name) as name, hire_date
  from employees e 
  where  extract(year from  hire_date) < 2005
  
--   Write query to list the name (first and last name), hire date of all the employees who 
--joined on 1-JUL-2006,24-MAR-2007,04-JAN-2008 in ascending order of seniority
  
--select concat(first_name, ' ', last_name) as name, hire_date
--from employees e 
--WHERE
--      hire_date >= '1997-07-01'
--  AND hire_date <  '2007-03-24'
  
select concat(first_name, ' ', last_name) as name, hire_date
from employees e 
WHERE
      hire_date = '2006-07-01'
      or hire_date =  '2007-03-24'
      or hire_date = '2008-01-04'
   
 
--  Write a query to concatenate first name, last name and job id from employees table in the following format.

select concat(first_name, ' ', last_name, ' ', job_id) as name + id
from employees e 
  
--Write a query to list the employees who are joined in the year between '01-Jan-2004' and '31-Dec-2008'.

select * 
from employees e
where hire_date >= '1997-01-01'
	and hire_date <= '2008=12-31'
  
  
  
  
  
  
  
  
  
  