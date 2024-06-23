USE SAMPLEDB
GO

SELECT 3 /2

/*
3 devided by 2 is 1.5 However, SQL return 1 because the two inputs ware integer and therefore the resulting value will also be n integer. 
*/
SELECT 3/2.0

/*
3 divided by 2.0 returns 1.5 in SQL Server. This is beacuse 2.0 includes a decimals points and therefore SQL Server treates it as DECIMAL data type. The resulting value also has a DECIMAL data type.
*/

/*
3 divided by 2.0 return 1.5 in SQL server. This is beacuse 2.0 includes decimal point and therefore SQL server  treats it as a decimal data type . The resulting value also has a decimal daa type. 
*/

/*
The maxmimum value of the INT data type is 2147483647
SQL Server converts integer constants greater then 2147483647 to the DICIMAL data type.
*/
SELECT 2147483649 / 2;

/*
The Decimal Data type.

DECIMAL (precision, scale)
example:: site_measurement DECIMAL(8,5)
Precision is is the maximum number of digits which can be stored. the precision number include digits on both the left and right side of decimalpoint.

Scale is the number of digits that are stored to the right of the decimal point

The largest value DECIMAL(8,5) can hold is 999.99999

The DECIMAL data type is the same as the NUMERIC data.
*/

/*
FLOAT data type.

THE FLOAT data type is an approximate -number data type . As a result not all values in the data type be represented exactly.

flow_measurement FLOAT

FLOAT(n) where n is the number of that are used to store the float number. the default is 53 bits.

In most situation it is better to use the DECIMAL data type insted of FLOAT.
Nnver use the FLOAT data type to store Monetry values.
*/

/*
Declearing a varible called @val odf decimal(12,2) data type and giving it a value of 0.0 using a while loop to add 0.1 to val which continue intersting while val does not equal 10.0.
*/
DECLARE @val DECIMAL(12, 2) = 0.0

WHILE @val !=10.0
BEGIN
	PRINT @val;
	SET @val += 0.1;
END
--If we try same thing but  giv @val a data type of float than the loop doesn't stop:
DECLARE @val FLOAT(24 ) = 0.0;

WHILE @val !=10
BEGIN
	PRINT @val;
	SET @val += 0.1;
END
/*
When  using float data type the value 10 can be stored accurectly. How ever the  value 0.1 cannot be accuratly represented in float . There fore , event though we had the WHILE condition @val !=10.0 the @val will never exactly equal 10 when we use the FLOAT data type. this means that the loop will keep interating - by adding 0.1 - indefinitely.

However, if we look in the message tab we can see that it does show that at one point there was a value of 10. but  this is just SQL server management Studion is rounding the values that are printed. In other word , SSMS is not showing us the actual values.
To get a more accurate picture of the float value we can use the STR function to convert the float to character string::

*/
DECLARE @val FLOAT(24) = 0.0
WHILE @val != 10.0
BEGIN
	PRINT str(@val,20,16 ); -- STR (float_expression [, length[, decial]])
	SET @VAL += 0.1;
END;


/*
CREATE TABLE::
SYNTAX ::
CREATE TABLE table_name
(
	column-1 data-type [NOT NULL],
	column-2 data-type ,
	CONSTRAINT constraint_name constraint_type (column 1)
)

Example::
CREATE TABLE departments
(
	department_id INT IDENTITY(1,1)
	department_name VARCHAR(50) NOT NULL
	CONSTRAINT PK_department_id PRIMARY KEY (department_id)

)

*/

--Create table parks-1
CREATE TABLE parks1
(
	park_id INT,
	park_name VARCHAR(50),
	entry_fee DECIMAL(6,2)
)

SELECT * FROM dbo.parks1;

---Insert data in the table.
INSERT INTO dbo.parks1 (park_id, park_name,entry_fee)
	VALUES(1, 'Bellmont Park', 5)

INSERT INTO dbo.parks1 (park_id, park_name,entry_fee)
	VALUES(2, 'Redmond Park', 10)

INSERT INTO dbo.parks1 (park_id, park_name,entry_fee)
	VALUES(3, 'Highland Mountains', 5.74)

--Create table parks-2
CREATE TABLE parks2
(
	park_id INT IDENTITY(1,1),
	park_name VARCHAR(50),
	entry_fee DECIMAL(6,2),
	CONSTRAINT PK_parks2_park_id PRIMARY KEY(park_id)
)

SELECT * FROM dbo.parks2;

---Insert data in the table.
INSERT INTO dbo.parks2 (park_name,entry_fee)
	VALUES( 'Bellmont Park', 5)

INSERT INTO dbo.parks2 (park_name,entry_fee)
	VALUES('Redmond Park', 10)

INSERT INTO dbo.parks2 (park_name,entry_fee)
	VALUES('Highland Mountains', 5.74)


--Create child table called park_visits::

CREATE TABLE dbo.park_visits
	(
		visit_id INT IDENTITY,
		park_id INT NOT NULL,
		visit_date DATE NOT NULL,
		first_name NVARCHAR(50) NOT NULL,
		last_name NVARCHAR(50) NOT NULL
		CONSTRAINT PK_park_visits_visit_id PRIMARY KEY(visit_id),
		CONSTRAINT FK_park_visitis_id FOREIGN KEY (park_id) REFERENCES parks2 (park_id)
	);

SELECT * FROM dbo.park_visits;

INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES(2, '20200109', 'Bill', 'Evans');
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES(1, '20201122', 'Jane', 'Dillon');
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES(1, '20200623', 'Mike', 'Cruz');
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES(3, '20200520', 'Irene', 'Pritchard');

/*
INSERT STATEMENT
SYNTAX ::
INSERT IN TO table_name(Column1, column2, ....)
	VALUES(Col1_value, col2_value, ....)

EXAMPLE:: INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES(3, '20200520', 'Irene', 'Pritchard');

Multi-row INSERT statement:
INSERT INTO dbo.parks1 (park_id, park_name,entry_fee)
	VALUES	(1, 'Bellmont Park', 5),
			(2, 'Redmond Park', 10),
			(3, 'Highland Mountains', 5.74)


INSERT INTO ... SELECT statement

We can use the INSER INTO ... SELECT statement to insert data that comes from another table(s).

INSERT INTO table_name (column1, column2)
SELECT column1, column2
FROM table2_name;

Example:: 
INSERT INTO dbo.dept(dept_name,loc_id)
SELECT department_name, location_id
FROM hcm.departments
WHERE department_name= 'IT';

*/


/*
Challenge-1:
Create a table called dept in the dbo schema. Specify the following
columns:
-dept_id INT
-dept_name VARCHAR(50)

Give the IDENTITY property to the dept_id column. Also, put a primary key constraint on the dept_id column. Put a NOT NULL constraint on the dept_name column.
*/

/*
Write an insert statement to insert the following row into the dbo.dept table:

property.
dept_id
dept_name
1
Business Intelligence
*/

/*
Challenge:
Populate the dbo.dept table with more rows: Insert all department names from the hcm.departments table.
*/

/*
Challenge:
Create a table called a emp in the dbo schema. Specify the following columns:
-emp_id INT
-first_name VARCHAR(50)
-last_name VARCHAR(50)
-hire_date DATE
-dept_id INT
Give the
IDENTITY property to the emp_id column. Also, put a primary key constraint on the emp_id column. Put NOT NULL constraints on any columns you think need them. Put a foreign key constraint on the dept_id column which references back to the dept_id column from the dbo.dept table.
Hints: 
Syntax for a foreign key:
CONSTRAINT
fk_name FOREIGN KEY ( child_col )
REFERENCES
parent_table parent_col
*/

/*

Challenge:
Populate the dbo.emp table with the following two employees:
Hints:
You do not need to specify emp_id in the insert statement as it has the identity property. For the hire_date column use the standard format ‘YYYYMMDD’ in digits.
emp_id
first_name
last_name
hire_date
dept_id
1 Scott Davis Dec-11 2020 1
2 Miriam Yardley Dec-05 2020 1
*/