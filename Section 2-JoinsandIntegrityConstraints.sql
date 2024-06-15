USE SAMPLEDB
GO

SELECT  * FROM hcm.employees;
SELECT COUNT(*) as total_emp, e.department_id from hcm.employees AS e GROUP BY e.department_id;
--Join

SELECT  * FROM hcm.departments AS d  JOIN hcm.employees AS e ON d.department_id = e.department_id;
--Inner join
--SELECT FROM departments INNER JOIN employees ON departments dept_id employees dept_id




--Challenge-1:Write a query to return the following attributes for employees who belong to a department:
--employee_id
--first_name
--last_name
--salary
--department_name
SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name FROM hcm.employees AS e INNER JOIN hcm.departments AS d ON e.department_id = d.department_id;



--RIGHT OUTER JOIN
SELECT  e.first_name, e.last_name, e.salary,d.department_name FROM hcm.departments AS d  INNER JOIN hcm.employees AS e ON d.department_id = e.department_id;

--Challenge-2:Write a query to return the following attributes for all employees, including employees who do not belong to a department:
--employee_id
--first_name
--last_name
--salary
--department_name

SELECT e.employee_id, e.first_name, e.last_name, e.salary,d.department_name FROM hcm.employees AS e LEFT OUTER JOIN hcm.departments AS d ON d.department_id = e.department_id WHERE d.department_name IS NULL;
SELECT e.employee_id, e.first_name, e.last_name, e.salary,d.department_name FROM hcm.departments AS d RIGHT OUTER JOIN hcm.employees AS e ON d.department_id = e.department_id
--Challenge-3:Write a query to return the total number of employees in each department. Include the department_name in the query result. Also, include employees who have not been assigned to a department.
SELECT * FROM hcm.departments;
SELECT COUNT(*) as total_emp_in_dep, e.department_id from hcm.employees AS e GROUP BY e.department_id;
SELECT d.department_name, d.department_id, COUNT(e.employee_id) AS total_no_employee  FROM hcm.departments AS d  LEFT JOIN hcm.employees AS e ON d.department_id = e.department_id GROUP BY d.department_name, d.department_id;
SELECT d.department_name,  d.department_id,  COUNT(*) AS total_no_employee  FROM hcm.employees e LEFT JOIN hcm.departments AS d ON d.department_id = e.department_id GROUP BY d.department_name,  d.department_id;

