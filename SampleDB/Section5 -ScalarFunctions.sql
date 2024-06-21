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

SELECT CAST(SYSDATETIME() AS time) AS sysdatetimevalue;

--UTC date and time functions::
SELECT GETUTCDATE() AS getutcdate_value, SYSDATETIME() AS sysutcdatetime_value;

