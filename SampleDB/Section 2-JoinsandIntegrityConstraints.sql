USE SAMPLEDB
GO

SELECT  * FROM hcm.employees;
SELECT * FROM hcm.countries;


SELECT COUNT(*) as total_emp, e.department_id from hcm.employees AS e GROUP BY e.department_id;


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


--Challenge-1:Write a query to return employee details for all employees as well as the first and last name of each employee's manager. Include the following columns:
--employee_id
--first_name
--last_name
--manager_first_name (alias for first_name)
--manager_last_name (alias for last_name )

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	e.manager_id, 
	m.first_name as manager_first_name, 
	m.last_name as manager_last_name 
FROM hcm.employees e 
LEFT JOIN hcm.employees m 
ON e.manager_id = m.employee_id;

--Challenge-2 : Write a query to return all the products at each warehouse. Include the following attributes:
--product_id
--product_name
--warehouse_id
--warehouse_name
--quantity_on_hand
SELECT 
	p.product_id,
	p.product_name,
	w.warehouse_id,
	w.warehouse_name,
	i.quantity_on_hand
FROM oes.products p
INNER JOIN oes.inventories i
ON p.category_id = i.product_id
INNER JOIN oes.warehouses w
ON w.warehouse_id = i.warehouse_id;
--Challenge-3: Write a query to return the following attributes for all employees from Australia:
--employee_id
--first_name
--last_name
--department_name
--job_title
--state_province

SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name,
	j.job_title,
	e.state_province
FROM hcm.employees e 
LEFT JOIN hcm.departments d
ON e.department_id = d.department_id
INNER JOIN hcm.jobs j
ON e.job_id = j.job_id
INNER JOIN hcm.countries c
ON e.country_id = c.country_id
WHERE c.country_name = 'Australia';



--Challenge-4:Return the total quantity ordered of each product in each category. Do not include products which have never been ordered. Include the product name and category name in the query. Order the results by category name from A to Z and then within each category name order by product name from A to Z.
SELECT
	pc.category_name,
	p.product_name,
	SUM(oi.quantity) as total_quantity_orderd
FROM oes.products p
JOIN oes.order_items oi
ON p.product_id = oi.product_id
JOIN oes.product_categories pc
ON pc.category_id = p.category_id
GROUP BY pc.category_name, p.product_name
ORDER BY pc.category_name, p.product_name

--Challenge-5:Return the total quantity ordered of each product in each category. Include products which have never been ordered and give these a total quantity ordered of 0. Include the product name and category name in the query. Order the results by category name from A to Z and then within each category name order by product name from A to Z.
SELECT 
	pc.category_name,
	p.product_name,
	COALESCE(SUM(oi.quantity),0) as total_quantity_orderd
FROM oes.products p
LEFT JOIN oes.order_items oi
ON p.product_id = oi.product_id
JOIN oes.product_categories pc
ON pc.category_id = p.category_id
GROUP BY pc.category_name, p.product_name
ORDER BY pc.category_name, p.product_name;