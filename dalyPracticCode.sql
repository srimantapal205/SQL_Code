USE SAMPLEDB
GO

SELECT * FROM hcm.employees;

SELECT employee_id, first_name, last_name, salary FROM hcm.employees;
SELECT employee_id as ID, first_name+' '+last_name as Name, salary from hcm.employees;
