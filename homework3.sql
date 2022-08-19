--  Employees Table: Write a query to return all employees that work under manager whose first name is ‘Nancy’


--with 

--with find_nancy as (
--
--select employee_id 
--from employees e 
---- join employees h on h.employee_id::int = e.manager_id::int
-- where e.first_name = 'Nancy'
-- 
-- )
 
select * 
from employees e 
where manager_id  = (
	select employee_id 
	from employees e 
	-- join employees h on h.employee_id::int = e.manager_id::int
	where e.first_name = 'Nancy'
)


select * from jobs

--Write a query in SQL to display the full name (first name and last name), hire date, commission percentage, 
--email and telephone separated by '-', and salary for those employees who earn the salary above 11000 or the 
--seventh digit in their phone number equals 3 and make the result set in a descending order by the first name. 

select concat(first_name, ' ', last_name) as fullname, hire_date, commission_pct, 
	concat( email, '-', phone_number) as email_phone, salary
from employees e 
where position ('3' in phone_number::varchar) = 7 
	or salary > 10000
order by first_name desc

--3 Write a query in SQL to display the first and last name, and department number for those employees who holds a 
--letter s as a 3rd character in their first name

select first_name, last_name, e.department_id
from employees e 
where position('s' in last_name ) = 3

--4 Write a query in SQL to display the employee ID, first name, job id, and department number 
--for those employees who is working except the departments 50,30 and 80.

select employee_id, first_name, job_id, department_id 
from employees e 
where department_id not in (1,2,3,4,5)

--5 Write a query in SQL to display the employee Id, first name, job id, and department number for
-- those employees whose department number equals 30, 40 or 90 Hint: OR Logic

select employee_id, first_name, job_id, department_id 
from employees e 
where department_id = 1
	or department_id = 2
	or department_id = 11
	
--6 Write a query in SQL to display the ID for those employees who did two or more jobs in the past
--Hint: Job History table



--7 Write a query in SQL to display job ID, number of employees, sum of salary, and difference between 
--highest salary and lowest salary for a job.

select e.job_id, count(e.job_id), sum(salary), (max(salary)-min(salary)) as salary_difference , j.job_title  
from employees e 
inner join jobs j on j.job_id = e.job_id 
group by e.job_id , j.job_title 


--8 Write a query in SQL to display job ID for those jobs that were done by two or more for more than 300 days



--9 Write a query in SQL to display the country ID and number of cities in that country we have
select l.country_id, c.country_name , count(l.city)
from locations l 
left outer join countries c on c.country_id  = l.country_id 
group by l.country_id, c.country_name


--10 Write a query in SQL to display the manager ID and number of employees managed by the manager. 
--select manager_id, 

select manager_id, count(*)
from employees e 
where manager_id is not null
group by manager_id 
	
	
--11 Write a query in SQL to display the details of jobs in descending sequence on job title
select * 
from jobs j
order by job_title desc 


--12 Write a query in SQL to display the first and last name and date of joining of the employees
--  who is either Sales Representative or Sales Man
	
select first_name, last_name, hire_date, j.job_title 
from employees e 
inner join jobs j on j.job_id = e.job_id 
where j.job_title  = 'Sales Representative'
	or j.job_title  = 'Sales Manager'

--13 Write a query in SQL to display the average salary of employees for each department who gets a 
--commission percentage
	
update employees 
set commission_pct = 9 
where employee_id in (120, 116,134, 109)

select avg(salary)
from employees e 
where commission_pct is not null

select * from  departments d limit 5


--14 Write a query in SQL to display those departments where any manager is managing 4 or more employees


--
select department_id, department_name, manager_id 
from departments d 
--
update departments  
set manager_id  = 101
where department_id = 1
--
--
--select first_name, last_name, hire_date, j.job_title , e.job_id, manager_id , employee_id 
--from employees e 
--inner join jobs j on j.job_id = e.job_id 
--where  j.job_title  ilike '%manager%'
--
--
--select first_name, job_Id, manager_id,  employee_id 
--from employees e 
--where employee_id = 100
--	or employee_id  = 101
--

--
select first_name, employee_id, j.job_title 
from employees e  
join jobs j on j.job_id = e.job_id 
where department_id  = 10


--14 Write a query in SQL to display those departments where any manager is managing 4 or more employees

select d.department_name ,  e.manager_id,  count(*) as emp_count
from employees e 
join departments d on d.department_id = e.department_id 
group by e.department_id, e.manager_id, d.department_name 
having count(*) > 4

-- or use a cte

with manager_employee  as
(
select d.department_name ,  e.manager_id,  count(*) as emp_count
from employees e 
join departments d on d.department_id = e.department_id and e.manager_id is not null
group by e.department_id, e.manager_id, d.department_name 


)

select * from manager_employee where emp_count > 4


--15 Write a query in SQL to display those departments where more than 
--ten employees work who got a commission percentage

select d.department_name, commission_pct , count(*)
from employees e 
join departments d on d.department_id = e.department_id 
where commission_pct > 8
group by d.department_name, commission_pct


--16  Write a query in SQL to display the employee ID and the date on which he ended his previous job


-- 17 Write a query in SQL to display the details of the employees who have no commission percentage
--    and salary within the range 7000 to 12000 and works in that department which number is 5

select * 
from employees 
where commission_pct is null 
	and salary between 7000 and 12000
	and department_id = 5


--18 Write a query in SQL to display the job ID for those jobs which average salary is above 8000. 
	
select job_id, avg(salary) 
from employees e 
group by job_id
having avg(salary) > 8000

-- or use a cte

with avg_salary as 
(
select job_id, avg(salary) as avg_salary_8000
from employees e 
group by job_id
)

select * from avg_salary
where avg_salary_8000 > 8000


-- 19 Write a query in SQL to display job Title, the difference between minimum and maximum salaries 
--for those jobs which max salary within the range 12000 to 18000.

-- based on company principles
select *, (max_salary - min_salary) as difference
from jobs j 
where max_salary between 12000 and 18000


-- kwa ground based on current salaries

select j.job_title, min(salary ) as min_salary, max(salary) as max_salary, (max(salary )- min(salary)) as difference
from employees e 
join jobs j on j.job_id  =  e.job_id 
group by j.job_title 
having max(salary ) between 12000 and 18000


-- 20 Write a query in SQL to display all those employees whose first name or last name starts with the letter D

select * 
from employees e 
where first_name ilike 'd%'
	or last_name ilike 'd%'
	
-- 21 Write a query in SQL to display the details of jobs which minimum salary is greater than 9000. 

	
--kwa gound according to employees salaries
select j.job_title  , min(salary)
from employees e 
join jobs j on j.job_id = e.job_id 
group by j.job_title 
having min(salary) > 9000


--according to company guidelines

select * 
from jobs j 
where min_salary > 9000 


-- Write a query in SQL to display those employees who joined after 7th September, 1987


-- sub queries


--23. Write a query to display the name ( first name and last name ) for those employees who
--    gets more salary than the employee whose ID is 110.

select first_name, last_name , salary 
from employees e 
where salary > (
select salary 
from employees e2 
where employee_id = 110
)

--24 Write a query to display the name ( first name and last name ), salary, department id, job id for
--   those employees who works in the same designation as the employee works whose id is 120

select first_name, last_name , salary, department_id, job_id
from employees e 
where job_id = (
select job_id 
from employees e2 
where employee_id = 120
)

--25 Write a query to display the name ( first name and last name ), salary, department id for those 
--  employees who earn such amount of salary which is the smallest salary of any of the departments. 

select first_name, last_name , salary, department_id
from employees e 
where salary  in (
select min_salary
from jobs 
)

-- 26 Write a query to display the employee id, employee name (first name and last name ) for all employees 
--    who earn more than the average salary.

select first_name, last_name, salary 
from employees e 
where salary > (
select avg(salary)
from employees e2 
)

-- 27 Write a query to display the employee name ( first name and last name ), employee id and salary of all 
--    employees who report to Payam

select first_name, last_name, salary 
from employees e 
where manager_id  > (
select employee_id 
from employees e2 
where first_name = 'Payam'
	or last_name  = 'Payam'
)


--28 Write a query to display the department number, name ( first name and last name ), job and department name 
--for all employees in the Finance department.

select first_name, last_name , job_title, department_name
from employees e 
join jobs j on j.job_id = e.job_id 
join departments d on d.department_id = e.department_id 
where e.department_id =  (
select d2.department_id
from departments d2 
where department_name ilike 'finance'
)

-- 29 Write a query to display all the information of an employee whose salary and reporting person id is 
-- 3000 and 121 respectively.


--30 Display all the information of an employee whose id is any of the number 134, 159 and 183.

select * 
from employees e 
where employee_id  in (134, 159, 183)

-- 31 Write a query to display all the information of the employees whose salary is within the range 1000 and 3000

select * 
from employees e 
where salary between 1000 and 3000

-- 32 Write a query to display all the information of the employees whose salary is within the range 
--  of smallest salary and 2500.

select *
from employees e 
where salary between 
(
select min(salary)
from employees e2 
)
and 2500


--33 Write a query to display all the information of the employees who does not work in those departments 
--   where some employees works whose manager id within the range 100 and 200

select * 
from employees e 
where manager_id not between 100 and 200


-- 34 Write a query to display all the information for those employees whose id is any id who earn the 
--  second highest salary.

select * 
from employees e3
where employee_id =
(
select   min(employee_id)
from employees e 
where employee_id > (
	select min(employee_id) from employees 
)
)

--35 Write a query to display the employee name( first name and last name ) and hiredate for all 
--employees in the same department as Clara. Exclude Clara. i used nancy

select first_name, last_name, hire_date, department_id 
from employees e 
where department_id = (

select department_id
from employees e 
where first_name ilike '%nancy%'
	or last_name ilike '%nancy%'

) 
and first_name not ilike '%nancy%'
	and last_name not ilike '%nancy%'

	
-- 36 Write a query to display the employee number and name( first name and last name ) for all employees 
--  who work in a department with any employee whose name contains a T. 

select employee_id, concat(first_name, ' ', last_name) as name, department_id
from employees e 
where department_id in (
--10,20,5,6,8,11,14
select department_id --, first_name , last_name 
from employees e2 
where first_name  ilike '%t%'
	or last_name  ilike '%t%'

)

-- 37 Write a query to display the employee number, name( first name and last name ), and salary for all employees 
--who earn more than the average salary and who work in a department with any employee with a J in their name

select employee_id, concat(first_name, ' ', 'last_name') as name, salary, department_id 
from employees e 
where salary > ( 
	select avg(salary)
	from employees e2 	
) and department_id in  (
	select department_id 
	from employees e2 
	where first_name  ilike '%j%'
	or last_name  ilike '%j%'

)

--38 Display the employee name( first name and last name ), employee id, and job title for all employees 
--   whose department location is Toronto.

select concat(first_name, ' ', 'last_name') as name, employee_id, j.job_title 
from employees e 
join jobs j on j.job_id = e.job_id 
where department_id = (
select d.department_id 
from departments d 
inner join locations l on l.location_id = d.location_id 
where l.city ilike '%toronto%'
)

--39 Write a query to display the employee number, name( first name and last name ) and job title for 
--  all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN

select employee_id, concat(first_name, ' ', last_name )as name, j.job_title, salary
from employees e 
inner join jobs j on j.job_id = e.job_id 
where salary < ( 
select e2.salary 
from employees e2 
join jobs j on j.job_id = e2.job_id 
where job_title ilike 'marketing manager'

)
-- 40 Write a query to display the employee number, name( first name and last name ) and job title for all employees 
--  whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
--  I have used employees with title marketing
 
select employee_id, concat(first_name, ' ', last_name )as name,e.job_id ,  j.job_title, salary
from employees e 
inner join jobs j on j.job_id = e.job_id 
where salary < ( 
	select e2.salary 
	from employees e2 
	join jobs j on j.job_id = e2.job_id 
	where job_title ilike 'marketing manager'

) and j.job_id not in  ( 
	select j2.job_id 
	from jobs j2
	where job_title ilike '%marketing%'

)

--Write a query to display the employee number, name( first name and last name ) and job title for all employees 
--  whose salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.

select employee_id, concat(first_name, ' ', last_name )as name,e.job_id ,  j.job_title, salary
from employees e 
inner join jobs j on j.job_id = e.job_id 
where salary > ( 
	select e2.salary 
	from employees e2 
	join jobs j on j.job_id = e2.job_id 
	where job_title ilike 'marketing manager'

) and j.job_id not in  ( 
	select j2.job_id 
	from jobs j2
	where job_title ilike '%marketing%'

)

--42 Write a query to display the employee number, name( first name and last name ) and job title for all employees 
--   whose salary is more than any average salary of any department.

select employee_id, concat(first_name, ' ', last_name )as name , j.job_title, salary
from employees e 
inner join jobs j on j.job_id = e.job_id 
where salary > (

	select  avg(salary)
	from employees e2
	group by job_id 
	order by avg(salary) 
	limit 1

)

-- 43 Write a query to display the employee name( first name and last name ) and department for all employees for 
-- any existence of those employees whose salary is more than 3700

select employee_id, concat(first_name, ' ', last_name )as name , d.department_name , salary
from employees e 
join departments d on d.department_id =e.department_id 
where salary > 3700


-- 44 Write a query to display the department id and the total salary for those departments which
-- contains at least one employee.

select department_id, count(*), sum(salary) as dpt_salary
from employees e 
group by department_id 
having count(*) > 1


-- 45 Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified
-- title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.

select e.employee_id, concat(first_name, ' ', last_name )as name , e.job_id , j.job_title,
	case 
		when j.job_title = 'Programmer' then 'Developer'
	end
	as job
	
from employees e 
join jobs j on j.job_id = e.job_id  


-- 46 Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a 
--title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.


select e.employee_id, concat(first_name, ' ', last_name )as name , salary,
case 
	when e.salary > (select avg(salary) from employees e2) then 'High'
	when e.salary < (select avg(salary) from employees e2) then 'Low'
end
from employees e 
group by e.employee_id  


--47 Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary -
-- the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for 
-- those employees whose salary is more than and less than the average salary of all employees.

select e.employee_id, concat(first_name, ' ', last_name )as name , salary, salary - (select avg(salary) from employees e3 ),
case 
	when e.salary > (select avg(salary) from employees e2) then 'High'
	when e.salary < (select avg(salary) from employees e2) then 'Low'
end
from employees e 

--48 Write a subquery that returns a set of rows to find all departments that do actually have one or more employees 
--assigned to them.
select d.department_name , count(*) 
from employees e
join departments d on d.department_id = e.department_id 
group by (e.department_id), d.department_name 
having count(*) > 4


-- 49 Write a query that will identify all employees who work in departments located in the United Kingdom. 
select e.*
from departments d  
left join locations l on l.location_id = d.location_id 
right join employees e on e.department_id = d.department_id 
where l.country_id  ilike 'uk' 


--50 Write a query to identify all the employees who earn more than the average and who work in any of the IT departments.
select e.* , d.department_name 
from employees e 
join departments d on d.department_id = e.department_id 
where salary > (
	select avg(salary) from employees
) and department_name = 'IT'


-- 51 Write a query to determine who earns more than Mr. Ozer.
select * 
from employees e 
where salary > (
	select salary 
	from employees e2 
	where first_name ilike '%diana%'
		or last_name ilike '%diana%'
)

-- 52 Write a query to find out which employees have a manager who works for a department based in the US
select e.*
from employees e 
join departments d on d.department_id = e.department_id 
join locations l on l.location_id  = d.location_id 
where l.country_id ilike 'us'


-- 53 Write a query which is looking for the names of all employees whose salary is greater than 50% of
-- their department’s total salary bill
--
--select  first_name 
--from employees e 
--where salary > (
--	select percentile_cont(0.5) within group (order by salary)
--	
--	from employees )


--54 Write a query to get the details of employees who are managers
select * 
from employees e 
where employee_id in (
select manager_id 
from employees e2 
)

--56 Write a query to display the employee id, name ( first name and last name ), salary, department name and 
--  city for all the employees who gets the salary as the salary earn by the employee which is maximum within 
--  the joining person January 1st, 2002 and December 31st, 2003



--57 Write a query in SQL to display the department code and name for all departments which located in the city London.
 























