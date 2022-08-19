
-- 1
create table trainer (
	traine_id BIGSERIAL not null primary key,
	first_name varchar(50) not null,
	email varchar(50) unique
	
);

create table trainee (
	trainee_id BIGSERIAL not null primary key,
	first_name varchar(50) not null,
	email varchar(50) unique,
	trainer BIGINT references trainer(trainer_id)
	
);


-- 2. display data from emp table whose DEPTNO is '20' and who joined in the year 1981' 
select * 
from emp e
where DEPTNO = 20
	and extract(year from  HIREDATE) =  1981
  

-- 3. displays the EMPNO ,ENAME,SALARY and  SAL + COMMISSION as total salary from employee table whose commission is not null and only for dept 30.


select EMPNO ,ENAME,SAL, (SAL + COMM) AS total_salary
from emp e
where comm is not null 
    and deptno = 30


-- 4. write a SQL query to find the unique designations from employee table.

select distinct job
from emp 

-- 5. write a SQL query to list the employees’ name, increased their salary by 50% in descending order.

select ename, (sal * 1.5) as increased_sal
from emp
order by increased_sal


-- 6. write a SQL query to find the minimum ,maximum and average salary BY department for those employees whose job is 'SALESMAN' and'CLERK'

select deptno, max(sal), min(sal), avg(sal)
from emp e
where job in ('SALESMAN','CLERK')
group by deptno



-- 7. write a SQL query to find total salary of employees who commission is null and joined in APRIL month. 

select sum(sal)
from emp e
where comm is null
    and extract ( month from  HIREDATE) = 4


-- 8. write a SQL query to find those employees whose commission is more than their salary. 

select *
from emp e
where comm > sal


-- 9  write a SQL query to find those employees whose salary exceeds 2000 after giving 10% increment.

select * 
from emp
where sal * 1.1 > 2000

-- 10.write a SQL query to find which department total salary is grathan 10000.

select deptno, sum(sal)
from emp
group by deptno
having sum(sal) > 10000;


-- 11.write a SQL query to show each employee experience in months till current month.
select ENAME, 
MONTHS_BETWEEN(CURRENT_DATE, hiredate)
from emp ;

-- 12.write a SQL query to show total salary of all the emplyees from department  number 10 and 30 and who's commisson is null and salary less than or equal to 1000 
 
 select sum(sal)
 from emp 
 where deptno in ( 10, 30) and comm is null and sal < 1000


-- 13.write a SQL query to show $ at the begining and end of each emplyee name.

select '$' || ename || '$'
from emp e

-- 14.display data from emp table whose joined in the month of may but not between year 82 to 88.

select * 
from emp
where extract ( month from  HIREDATE) = 5 and 
     extract ( year from  HIREDATE) not between 1982 and 1988


 
-- 15. display data from emp table whose names starts with 'A' and joined in the year '87'.

select *
from emp
where ename like 'A%'
    and extract ( year from  HIREDATE) = 1987;


