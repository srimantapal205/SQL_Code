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
