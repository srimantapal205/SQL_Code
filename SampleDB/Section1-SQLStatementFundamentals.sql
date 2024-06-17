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

SELECT employee_id as ID, department_id as Dept_ID , first_name+' '+last_name as Name, salary from hcm.employees where department_id IS  NOT NULL ORDER BY Dept_ID ASC , salary DESC;
SELECT * from hcm.employees ORDER BY department_id ASC , salary DESC ;

SELECT TOP (10) employee_id as ID, first_name, last_name, salary FROM hcm.employees ORDER BY salary DESC ;

SELECT  TOP (1) WITH TIES employee_id as ID, first_name, last_name, salary FROM hcm.employees ORDER BY salary ASC ;

-- isnull function 
-- ISNULL(<field-name>,0 or Deafult value)
-- COALESCE(expression-1, expression-1, expression-2, ..... expression-n) We can specifi more than two expression when using the coalesc function and the function will return the  value of the first non null expression of each row.
 




-- NULL

SELECT * FROM oes.products;
--Challenge1:Select products from theoes.products table which have a price greater than $100.
SELECT * FROM oes.products WHERE list_price > 100 ORDER BY list_price ASC;

SELECT * FROM oes.orders;
-- Challenge 2 :Select all orders from the oes.orders table which have not yet been shipped.
SELECT * FROM oes.orders WHERE shipped_date IS NULL;

--Challenge 3:Select all orders from the oes.orders table which were placed on the 26 th of February 2020.
SELECT * FROM oes.orders WHERE order_date = '20200226';

-- Challenge 4: Select all orders from the oes.orders table which were placed on or after the 1 st of January 2020.
SELECT * FROM oes.orders WHERE order_date >= '20200101';

--Pattern Matching Challenges

--Query the INFORMATION_SCHEMA.COLUMNS view to find the collation used for the table :: 
SELECT table_schema, table_name, column_name,data_type,collation_name FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='hcm' AND TABLE_NAME='countries';

SELECT * FROM hcm.countries;
--Challenge-1: Select countries from the hcm.countries table which  start with the letter ‘N’.
SELECT * FROM hcm.countries WHERE country_name LIKE 'N%';

SELECT * FROM oes.customers;
--Challenge- 2: Select customers from the oes.customers table who have a Gmail email address.
SELECT * FROM oes.customers WHERE email LIKE '%@gmail%';

SELECT * FROM oes.products;
--Challenge- 3: Select product names from the oes.products table which contain the word ‘mouse’ anywhere within the product name.
SELECT * FROM oes.products WHERE product_name LIKE '%mouse%';
--Challenge- 4: Select all product names from the oes.products table which end in a number.
SELECT * FROM oes.products WHERE product_name LIKE '%[0-9]';

-- GROUP BY Challenges

SELECT * FROM hcm.employees;
-- Challenge-1: Write query to give the total number of employees in each department as given by the department_id column in the hcm.employees table.
SELECT COUNT(employee_id ) AS 'Number Of Employee'  FROM hcm.employees;
SELECT  DISTINCT department_id , COUNT(employee_id ) AS 'Number Of Employee'  FROM hcm.employees GROUP BY  department_id ;

-- Challenge-2:Write a query to give the average salary in each  department as given by the department_id column in the hcm.employees table. Order the query result by average salary from highest to lowest.
SELECT  department_id, AVG(salary) AS 'AverageSalary' FROM hcm.employees  GROUP BY  department_id ORDER BY  AverageSalary DESC ;

SELECT * FROM oes.inventories;
--Challenge-3: Write a query to give the total number of products on hand at each warehouse as given by the warehouse_id column in the oes.inventories table. Also, limit the result to only warehouses which have greater than 5,000 product items on hand
SELECT warehouse_id, SUM(quantity_on_hand) AS 'TotalItem' FROM oes.inventories  GROUP BY warehouse_id HAVING SUM(quantity_on_hand) >= 5000;

SELECT * FROM bird.antarctic_populations;
--Challenge-4: What is the date of the most recent population count at each locality in the bird.antarctic_populations table
SELECT locality, MAX([date_of_count]) AS  most_recent_population_count FROM bird.antarctic_populations GROUP BY locality;

--Challenge-5: What is the date of the most recent population count for each species at each locality in the bird.antarctic_populations table

SELECT species_id, locality, MAX([date_of_count]) AS  most_recent_population_count FROM bird.antarctic_populations GROUP BY species_id,locality;

 --Logical Operator Challenges

 --Challenge 1:Select employees from the hcm.employees table who live in either Seattle or Sydney.
  SELECT * FROM hcm.employees WHERE city = 'Seattle' OR city = 'Sydney';
 --Challenge 2:Select employees who live in any of the following cities:-Seattle-Sydney-Ascot-Hillston:
 SELECT * FROM hcm.employees WHERE city IN ('Seattle' ,'Sydney', 'Ascot', 'Hillston');

 --Challenge 3:Select employees from Sydney who have a salary greater than $200,000.
 SELECT * FROM hcm.employees WHERE city = 'Sydney' AND salary > 200000
 --Challenge 4:Select employees who live in either Seattle or Sydney and were also hired on or after 1 st January 2019.
  SELECT * FROM hcm.employees WHERE (city = 'Seattle' OR city = 'Sydney') AND hire_date >= '20190101';
 --Challenge 5:Select products from the oes.products table which do not have a product category_id of either 1, 2, or 5.
 SELECT * FROM  oes.products WHERE category_id NOT IN (1,2,5);



