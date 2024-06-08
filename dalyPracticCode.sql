USE SAMPLEDB
GO

SELECT * FROM hcm.employees;

--First challange Solution
SELECT employee_id, first_name, last_name, salary FROM hcm.employees;
SELECT employee_id as ID, first_name+' '+last_name as Name, salary from hcm.employees;

--Second challange Solution
SELECT last_name as customer_last_name, city FROM hcm.employees; 

--Third challange Solution
SELECT * FROM oes.order_items;

--Selecting all column from the table.
SELECT * FROM bird.antarctic_populations;

--First  DISTINCT challange solution 
SELECT DISTINCT locality FROM bird.antarctic_populations;

--Second  DISTINCT challange solution 
SELECT DISTINCT locality, species_id FROM bird.antarctic_populations;

--TOP and OrderBy 
SELECT employee_id as ID, first_name, last_name FROM hcm.employees ORDER BY last_name ASC  ;
SELECT * FROM hcm.employees ORDER BY last_name ASC  ;

SELECT TOP 10 employee_id as ID, first_name, last_name FROM hcm.employees ORDER BY last_name ASC ;

SELECT employee_id as ID, first_name+' '+last_name as Name, salary from hcm.employees ORDER BY salary DESC; 
SELECT * from hcm.employees ORDER BY salary DESC; 

SELECT employee_id as ID, first_name+' '+last_name as Name, hire_date from hcm.employees ORDER BY hire_date DESC;
SELECT * from hcm.employees ORDER BY hire_date DESC;

SELECT employee_id as ID, department_id as Dept_ID , first_name+' '+last_name as Name, salary from hcm.employees ORDER BY Dept_ID ASC , salary DESC ;
SELECT * from hcm.employees ORDER BY department_id ASC , salary DESC ;

SELECT TOP (10) employee_id as ID, first_name, last_name, salary FROM hcm.employees ORDER BY salary DESC ;

SELECT  TOP (1) WITH TIES employee_id as ID, first_name, last_name, salary FROM hcm.employees ORDER BY salary ASC ;