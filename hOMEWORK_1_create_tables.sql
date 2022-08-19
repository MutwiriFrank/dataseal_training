-- create regions table

create table regions(
region_id BIGSERIAL not null primary key,
region_name varchar(50) not null unique

);

-- create countries table

create table countries (
country_id BIGSERIAL not null primary key,
country_name varchar(40),
region_id BIGINT references regions(region_id)

);

-- create locations table

create table locations (
location_id BIGSERIAL not null primary key,
street_address varchar(25),
postal_code varchar(12),
city varchar(30),
state_province varchar(12),
country_id BIGINT references countries(country_id)
);

-- create departments table

create table departments (
department_id bigserial not null primary key,
department_name varchar(20),
manager_id int,
location_id BIGINT references locations(location_id)
)

create table employees(
employee_id BIGSERIAL not null primary key,
first_name varchar(20),
last_name varchar(25),
email varchar(25),
phone_number varchar(20),
hire_date date,
job_id varchar(20),
salary bigint,
commission_pct int,
manager_id int,
department_id int
)

create table jobs(
job_id varchar(10),
job_title varchar(35),
min_salary int,
max_salry int
)

alter table employees
drop column job_id


--convert jobs_id to primary key


--alter table jobs 
--  add primary KEY(job_id)  ; 


------------------------convert jobs from varchar to bigserial



-- alter table jobs 
-- alter column job_id type BIGINT using(job_id::BIGINT),
--  alter column job_id set not null,
--  ALTER COLUMN job_id SET DEFAULT nextval('jobs_job_id_seq'::regclass);
-- 
 
 
 alter table jobs 
	drop column job_id
	

 alter table jobs 
	add job_id varchar(10) not null primary key


alter table employees 
	add job_id varchar(10) references jobs(job_id)


alter table locations 
	alter column street_address type varchar(100) 
	
	
delete from jobs  cascade;

truncate table  countries  cascade;

select * from countries  ;

insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (20, '29 Cala Drive', '98 kEX 711', 'Kanairo 10', 'de-Kenya', 2);

alter table jobs 
rename column max_salry to max_salary

delete from locations

alter table countries 
 drop column country_id cascade

alter table countries 
	add column country_id VARCHAR(4)  primary key

alter table locations 
	alter column country_id type VARCHAR(4)

alter table employees 
	alter column email type VARCHAR(50)

