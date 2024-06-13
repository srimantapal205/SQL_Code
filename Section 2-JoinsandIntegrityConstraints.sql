USE SAMPLEDB
GO

--Join


--Inner join
--SELECT FROM departments INNER JOIN employees ON departments dept_id employees dept_id




--Challenge-1:Write a query to return the following attributes for employees who belong to a department:
--employee_id
--first_name
--last_name
--salary
--department_name
SELECT  e.first_name, e.last_name, e.salary,d.department_name FROM hcm.departments AS d INNER JOIN hcm.employees AS e ON d.department_id = e.department_id;
SELECT  e.first_name, e.last_name, e.salary,d.department_name FROM hcm.departments AS d LEFT OUTER JOIN hcm.employees AS e ON d.department_id = e.department_id;


--Challenge-2:Write a query to return the following attributes for all employees, including employees who do not belong to a department:
--employee_id
--first_name
--last_name
--salary
--department_name



--Challenge-3:Write a query to return the total number of employees in each department. Include the department_name in the query result. Also, include employees who have not been assigned to a department.
