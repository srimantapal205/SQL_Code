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