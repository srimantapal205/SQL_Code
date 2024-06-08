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

