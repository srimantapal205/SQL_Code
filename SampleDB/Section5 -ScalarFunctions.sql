USE SAMPLEDB
GO

SELECT * FROM hcm.employees;

/*
Concatenation
Concatenation is a way to combine character strings end-to-end.
For example the concateton of 'snow' and 'ball' is is snowball
SQL server provides two methods of concatetion : 
	1. Using the + operator
	2. Using the concat function.
Exaample:
SELECT customer_id,first_name, middle_name, last_name, firstname+ISNULL(''+middle_name,'')+''+last_name as full_name from customers;
SELECT customer_id,first_name, middle_name, last_name, concat(firstname, ' '+middle_name, ' ',last_name) as full_name from customers;


String Manipulation Function

SELECT customer_d customer_name,
CHARINDEX(' ', customer_name) AS index_position_of space FROM customers



*/

/*
String Manipulation
CHARINDEX function syntax::
CHARINDEX(substring, string, [string_position])

LEFT Function syntax::
LEFT(STRING, number_of_characters)

SUBSTRING function Syntax::
SUBSTRING(string, start_position,length)

SELECT customer_id, customer _name, CHARINDEX('', customer_name) AS index_position_of_space FROM customers;
SELECT customer_id, customer _name, LEFT( customer_name, 2 ) AS index_position_of_space FROM customers;
SELECT customer_id, customer _name, LEFT( customer_name, CHARINDEX('', customer_name) -1 ) AS first_name FROM customers;

SELECT customer-ID, CUSTOMER_NAME, substring(customer_name, CHARINDEX('', customer_name)+1, LEN(customer_name)) AS last_name FROM customers;

SELECT customer_id, customer_name. CHARINDEX('', customer_name) + 1 AS start_position, LEN(customer_name) AS string_length, SUBSTRING(customer_name, CHARINDEX('', customer)+1, LEN(customer_name)) AS last_name FROM customers;
*/

/*
DATE and TIME Function

*/

SELECT GETDATE() AS get_date_value;

SELECT GETDATE() AS get_date_value, CURRENT_TIMESTAMP AS current_timestamp_value

SELECT SYSDATETIME() AS systemdatetime;

SELECT CAST(SYSDATETIME() AS DATE) AS systemdate_value

--CAST function syntax :: CAST(Expression as data_type)

SELECT CAST(SYSDATETIME() AS TIME) AS sysdatetimevalue;

--UTC date and time functions::
SELECT GETUTCDATE() AS getutcdate_value, SYSDATETIME() AS sysutcdatetime_value;

--Selecting some column from the hcm.employees table

SELECT employee_id, first_name, last_name, birth_date, hire_date FROM hcm.employees;

--The DATEPART function return an integer representing the specified datepart of the specified date::
SELECT 
	employee_id, 
	first_name, 
	last_name, 
	birth_date, 
	hire_date, 
	DATEPART(YEAR, hire_date) AS hire_year, 
	DATEPART(MONTH, hire_date) AS hire_month, 
	DATEPART(DAY, hire_date) AS hire_day

FROM hcm.employees;

SELECT 
	employee_id, 
	first_name, 
	last_name, 
	birth_date, 
	hire_date, 
	DATENAME(YEAR, hire_date) AS hire_year, 
	DATENAME(MONTH, hire_date) AS hire_month, 
	DATENAME(DAY, hire_date) AS hire_day

FROM hcm.employees;

--Count of employees hired each year
SELECT
	DATEPART(YEAR, hire_date) AS hire_year,
	COUNT(*) AS hire_count
FROM hcm.employees
GROUP BY  DATEPART(YEAR, hire_date);

--Count of the employee hired in each year using Year function
SELECT 
	YEAR(hire_date) AS hire_year,
	COUNT(*) AS hire_count
FROM hcm.employees
GROUP BY YEAR(hire_date);

--DATE ADD function ysntax:: DATEADD(inteval, number, date_expression)
--Use DATEADD to add 5 years to the hire_date to know when each employees 5 years anniversary is::
SELECT 
	employee_id,
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEADD(YEAR, 5, hire_date) AS five_years_date
FROM hcm.employees;

--Use the DATEDIFF function to calculate how many days each employee has worked at the company 

SELECT
	employee_id,
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEDIFF(YEAR, hire_date, CURRENT_TIMESTAMP) AS years_employee,
	DATEDIFF(MONTH, hire_date, CURRENT_TIMESTAMP) AS months_employee,
	--DATEDIFF(DAYOFYEAR, hire_date, CURRENT_TIMESTAMP) AS dayofyear_employee,
	DATEDIFF(WEEK, hire_date, CURRENT_TIMESTAMP) AS weeks_employee,
	DATEDIFF(DAY, hire_date, CURRENT_TIMESTAMP) AS days_employee
FROM hcm.employees;

/*
Some possible time intervals we can use in the first argument of the DATEADD and DATEDIFF functions:
year
month
dayofyear
day
week
weekday
hour
minute
second
millisecond
*/

/*
Challenge-1:
Concatenate the first name and last name of each employee. Include a single space between the first and last name. Name the new expression employee_name .
-employee_id
-first_name
-last_name
-employee_name
*/
SELECT
	employee_id,
	first_name,
	last_name,
	first_name+ ' '+last_name AS employee_name
FROM hcm.employees;

--OR
SELECT
	employee_id,
	first_name,
	last_name,
	CONCAT(first_name, ' '+last_name) AS employee_name
FROM hcm.employees;

/*
Challenge-2:
Concatenate the first name, middle name, and last name of each employee. Include a single space between each of the names. Name the new expression employee_name .
-employee_id
-first_name
-last_name
-middle_name
-employee_name
*/
SELECT
	employee_id,
	first_name,
	middle_name,
	last_name,
	CONCAT(first_name, ' '+middle_name,' '+last_name) AS employee_name
FROM hcm.employees;

/*
Challenge-3:
Extract the genus name from the scientific_name as given in the bird.antarctic_species table. (Display the first word)
*/
SELECT * FROM bird.antarctic_species;
SELECT 
	scientific_name,
	LEFT(scientific_name, CHARINDEX(' ',scientific_name)-1) AS genus_name FROM  bird.antarctic_species;
/*
Challenge-4:
Extract the species name from the scientific_name as given in the bird.antarctic_species table. (Display the Second word)
*/
SELECT 
	scientific_name,
	SUBSTRING(scientific_name, CHARINDEX(' ', scientific_name)+1, LEN(scientific_name)) AS species_name 
FROM bird.antarctic_species;
/*
Challenge-5:
Return the age in years for all employees. Name this expression as employee_age .
-employee_id
-first_name
-last_name
-birth_date
-employee_age
*/
SELECT 
	employee_id,
	first_name,
	last_name,
	birth_date,
	DATEDIFF(YEAR, birth_date, CURRENT_TIMESTAMP) AS employee_age 
FROM hcm.employees;
/*
Challenge-6:
Assuming an estimated shipping date of 7 days after the order date, add a column expression called estimated_shipping_date for all unshipped orders. Include:
-order_id
-order_date
-estimated_shipping_date
*/
SELECT * FROM oes.orders WHERE shipped_date IS NULL;
SELECT
	order_id,
	order_date,
	DATEADD(DAY,7, order_date)AS estimated_shipping_date
FROM oes.orders
WHERE shipped_date IS NULL;

/*
Challenge-7:
Calculate the average number of days it takes each shipping company to ship an order. Call this expression avg_shipping_days .
-company_name
-avg_shipping_days
*/
SELECT * FROM oes.shippers

SELECT  
	s.company_name,
	AVG(DATEDIFF(DAY, o.order_date, o.shipped_date)) AS avg_shipping_days
FROM oes.orders o
INNER JOIN  oes.shippers s
ON o.shipper_id = s.shipper_id
GROUP BY s.company_name;

/*
The Case Expression
InSQL the Case expression has the functionlity of an IF-THEN-ELSE statement.
Often people will refer to SQL statement that includes a case expression as CASE statement.
Example::

SELECT customer_id first_name, country, club member FROM customers
TASK:: Add an expression to the query called 'customer_status'. If the customer is the USA and is a club member give a value of domestic member for the expression. If from USA and is not a club member then 'Domestic  non_member'.

If a customer is from the USA but is a club member then their customer status is 'Foreign member'. 
If not from the USA and is not a club member then ''Foregn non-member.

SELECT
	customer_id, first_name, country,club_member,
	CASE 
		WHEN country = 'USA' AND club_member ='Yes' THEN 'Domestic  member'
		WHEN country = 'USA' AND club_member ='No' THEN 'Domestic  non_member'
		WHEN country <> 'USA' AND club_member ='Yes' THEN 'Foreign  member'
		WHEN country <> 'USA' AND club_member ='No' THEN 'Foreign  non_member'
		ELSE 'unknown'
		END AS customer_status
FROM customers.
*/

/*
Challenge-1:
Select the following columns from the oes.products table:
•product_id
•product_name
•discontinued
Include a CASE expression in the SELECT statement called discontinued_description . Give this expression the string ‘No’ when the discontinued column equals 0 and a string of ‘Yes’ when the discontinued column equals 1. In all other cases give the expression the string of ‘unknown’.
*/
SELECT 
	product_id, product_name, discontinued,
	CASE
		WHEN discontinued = 0 THEN 'NO'
		WHEN discontinued = 1 THEN 'YES'
		ELSE 'unknown'
		END AS 'discontinued_description'		
FROM oes.products;



/*Challenge-2:
Select the following columns from the oes.products table:
•product_id
•product_name
•list_price
•Include a CASE expression in the SELECT statement called price_grade . For this expression..
•If list_price is less than 50 then give the string ‘Low’.
•If list_price is greater than or equal to 50 and list_price is less than 250 then give the string ‘Medium’.
•If list_price is greater than or equal to 250 then give the string ‘High’.
•In all other cases, give the expression the string of ‘unknown’.
*/

SELECT
	product_id,
	product_name,
	list_price,
	CASE
		WHEN list_price < 50 THEN 'Low'
		WHEN list_price >= 50 AND list_price < 250 THEN 'Medium'
		WHEN list_price >= 250 THEN 'High'
		ELSE 'unknown'
		END AS price_grade
FROM oes.products

/*Challenge-3:
•Select the following columns from the oes.orders table:
•order_id
•order_date
•shipped_date
•Include a CASE expression called shipping_status which determines the difference in days between the order_date and the shipped_date . When this difference is less than or equal to 7 then give the string value ‘Shipped within one week’.
•If the difference is greater than 7 days, then give the string ‘Shipped over a week later’.
•If shipped_date is null then give the string ‘Not yet shipped’.*/

SELECT
	order_id, order_date, shipped_date,
	DATEDIFF(DAY, order_date, shipped_date) AS shipped_days,
	CASE
		WHEN DATEDIFF(DAY, order_date, shipped_date) <= 7 THEN 'Shipped within one week'
		WHEN DATEDIFF(DAY, order_date, shipped_date) > 7 THEN 'Shipped over a week later'
		ELSE 'Not yet shipped'
		END AS shipping_status
	FROM oes.orders;
	--WHERE shipped_date IS NULL


/*Challenge-4:
Repeat the third challenge to derive the shipping_status expression, but this time get the count of orders by the shipping_status expression..*/

SELECT
	s.shipping_status,
	count(*) AS order_Count_by_status
	FROM(
	SELECT CASE
		WHEN DATEDIFF(DAY, order_date, shipped_date) <= 7 THEN 'Shipped within one week'
		WHEN DATEDIFF(DAY, order_date, shipped_date) > 7 THEN 'Shipped over a week later'
		ELSE 'Not yet shipped'
		END AS shipping_status
	FROM oes.orders
	) s
GROUP BY s.shipping_status;