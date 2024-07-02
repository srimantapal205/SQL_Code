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

CREATE TABLE dept 
	(
		dept_id INT IDENTITY,
		dept_name VARCHAR(50) NOT NULL,
		CONSTRAINT pk_dept_dept_id PRIMARY KEY (dept_id)
	);
SELECT * FROM dbo.dept;
/*
Challenge-2:
Write an insert statement to insert the following row into the dbo.dept table:

property.
dept_id
dept_name
1
Business Intelligence
*/
INSERT INTO dbo.dept(dept_name) 
	VALUES('Business Intelligence');
/*
Challenge-3:
Populate the dbo.dept table with more rows: Insert all department names from the hcm.departments table.
*/
INSERT INTO dbo.dept(dept_name)
SELECT department_name 
FROM hcm.departments;


/*
Challenge-4:
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
CREATE TABLE emp
	(
		emp_id INT IDENTITY,
		first_name VARCHAR(50),
		last_name VARCHAR(50),
		hire_date DATE NOT NULL,
		dept_id INT	NOT NULL,
		CONSTRAINT PK_emp_emp_id PRIMARY KEY (emp_id),
		CONSTRAINT FK_emp_dept_id FOREIGN KEY(dept_id) REFERENCES  dept(dept_id)
	);
SELECT * FROM dbo.emp;

/*

Challenge-5:
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
INSERT INTO dbo.emp(first_name,last_name,hire_date,dept_id)
	VALUES	('Scott', 'Davis', '20201211', 1),
			('Miriam', 'Yardley', '20201205', 1)
/*
The UNIQUEIDENTIFIRE DATA type

The UNIQUEIDENTIFIRE data type is a 16 byte data type that is globally unique accress all the table and system.

Often pepople will refer to this is a GUID data type.
The term GUID stands for Globallu Unique Identifier.
GUIDs are writen using hexadecimal digits
The hexadecimal system consists of 16 digits - 10 digits(0-9) plus the first letters of the aplhabet(A to F)
Example:: D4963218-0099-49f-84BF-f1a3ad67df29

GUIDs are ofter usefull in situation where you are combining data from diffrent database.

Generating GUID values::
One way that we can generating values for a UNIQUEIDENTIFIER column is by using function called NEWID()

If we want sequential GUID then we can set the column to deafult to value generatedd by the  NEWSEQUENTIALID() function.

USING sequential GUIDs can be faster than using GUIDs generated by the NEWID() function.

If privacy is of a concern then do not use sequential GUIDs.
*/

--Selecting a guid value by using the NEWID function
SELECT NEWID() AS guid_value;
GO

CREATE TABLE dbo.subjects1
(
	subject_id INT IDENTITY,
	subject_name VARCHAR(20),
	global_id UNIQUEIDENTIFIER
	CONSTRAINT PK_subject1_subject_id PRIMARY KEY (subject_id)
);
GO
INSERT INTO dbo.subjects1 (subject_name, global_id)
	VALUES	('Biology',NEWID()),
			('Physics',NEWID()),
			('English',NEWID())


SELECT * FROM dbo.subjects1;


-----------------------Default set GUID-------------------------

CREATE TABLE dbo.subjects2
(
	subject_id INT IDENTITY,
	global_id UNIQUEIDENTIFIER DEFAULT NEWID(),
	subject_name VARCHAR(20),
	CONSTRAINT PK_subject2_subject_id PRIMARY KEY (subject_id)
);

INSERT INTO dbo.subjects2 (subject_name)
	VALUES	('Biology'),
			('Physics'),
			('English')

SELECT * FROM dbo.subjects2;

--------------------------------------
CREATE TABLE dbo.subjects3
(
	subject_id INT IDENTITY,
	global_id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),
	subject_name VARCHAR(20),
	CONSTRAINT PK_subject3_subject_id PRIMARY KEY (subject_id)
);
INSERT INTO dbo.subjects3 (subject_name)
	VALUES	('Biology'),
			('Physics'),
			('English')

SELECT * FROM dbo.subjects3;


/*

UPDATE Statement

The UPDATE statement is used to update exiting data in a table.
Syntax ::
UPDATE table_name
SET column1 = value1,
	column2 = value2,
	----
	----
WHERE <Conditions>;


Example::
UPDATE products SET price = 5.5 WHERE product_name = 'Sports hat';

--Increase the price on particuler product
Example 2 ::
UPDATE products SET price = price * 1.1 WHERE product_name = 'Sports hat';
UPDATE products 
	SET 
		price = price * 1.1 
		category_name = 'Clothing';
WHERE product_name = 'Sports hat';
*/
SELECT * FROM dbo.emp;

UPDATE dbo.emp
	SET last_name = 'Greenbank' 
WHERE emp_id = 2


/*
DELETE Statement:

The DELETE statement is used to delete rows from a table.

Syntax::
DELETE FROM table_name
WHERE <Conditions>

Example::
DELETE from dbo.products WHERE product_name =  'Sports hat';

This statement will delete rows from the products table which have a product name of 'Sports hat'.

DELETE FROM dbo.product;

This statement will delete all row from the products table.

Npte:: Anothr way to delete all the row in a table is use a TRUNCATE TABLE statement.
*/

DELETE FROM dbo.emp
WHERE emp_id = 1;

/*
TRUNCATE Table statement
The TRUNCATE TABLE statement can be used to be delete all rows in table.

Syntax::
TRUNCATE TABLE table_name;

Example: TRUNCATE TABLE dbo.products;

Diffrence  Between DELETE and TRUNCATE table

DELETE FROM table_name:

In DELETE statement we can specify an optional WHERE clause so that only a subset of row are deleted.
DELETE record entries into the tranction log for each row that is deleted.
DELETE doesnot reset a column which has the IDENTITY property.
DELETE can be used on table that is referanced by a foreign key provided that there are no related rows in the child.


TRUNCT TABLE table_name::
TRUNCATE TABLE does not support a WHERE clause. Therefor, it will delete all rows in table.

TRUNCATE TABLE will reset a column which has the IDENTITY property back to seed value 

TRUNCATE TABLE cannot be used on a table that is referanced by a forigen key in another table.


SUMMARY::
If we need to delete all the rows in table then it generally recommended to to use the TRUNCATE TABLE statement. the main reson is that TRUNCATE TABLE is faster.

IN SQL Server,  both DELETE and TRUNCATE TABLE statement canbe be rolled back if they are within a transaction.
*/
/*
The DROP table statement::
The DROP TABLE statement can be used to completely remove a table from the database.
Syntax::
DROP TABLE database_name.schema_name.table_name;

Example:
DROP TABLE MYDB.dbo.products;

Note::
When a table is dropped then all associated indexes and constraints on that table are also dropped.


*/
DROP  TABLE SAMPLEDB.dbo.dept;
GO

SELECT * FROM dbo.dept
/*
We need to either drop the child table first i.e. dbo.emp or drop the froeign key constraint on the child table that is referencing the parent table dbo.dept.
*/

ALTER TABLE dbo.emp DROP CONSTRAINT [FK_emp_dept_id] ;
GO
--IF we try and drop a table that no longer exits then we get an error message:
DROP  TABLE SAMPLEDB.dbo.dept; --Cannot drop the table 'SAMPLEDB.dbo.dept', because it does not exist or you do not have permission.
GO

-- TO avoide this we can use IF EXITS to only drop a table if it currently xits.
--Note that the IF EXITS option is only available FROM SQL SERVER 2016 onwords:: 
DROP TABLE IF EXISTS dbo.dept;
GO

--Older version of SQL Server can use the following equivalent methods::
IF OBJECT_ID (N'SAMPLEDB.dbo.dept', N'U') IS NOT NULL DROP TABLE dbo.dept;


/*
Transaction Statement::
A transaction is single unit of work some times made multiple operation.

Sor example a transaction could consist of one or more SQL statements which change data in table

In order to maintain consistency in database, a transaction should have four properties as given bty the ACID acronym::
	Aromic
	Consistency
	Isolation
	Durability
ACID property -- Atomic::
A tranction should be Automic.
This means that eithe all the statements within the transaction are successfully saved or none of them are saved you do not want some statements to succeed and some thar fail. Instead, it should be all or nothing.

Note:: When a change is saved to the database we say that it hasbeen commited to database.


ACID property -- Consistency::
A tranction should be consistent. This means that a tranction should remove the database from one constent state to another. ALL data remains vali accroding  to defined such as constraints.

ACID property -- Isolation::
A transaction should be isolated. This means that each transaction occurs in isolation.  In other words, no tranction will be affected then multiple tranction can occur independently of other without interference.

ACID property -- Durability::
A transaction shoul be durable. This means that the changes made by a successful transction means are committed to the database and will persist even if ans a system failure event occurs e.g, if a power failure event e.g., if a power failure event ware to occur.


Transaction in SQL Server::

A transaction is successfull if are raised.
If transaction encounters errors then it must be canceled or rolled back. therefore , no data modification are committed.
The Default mode for SQL server is that it auto commits every successfull SQL statement.
This means that if you successfully execute a statement - such as an INSERT sttement - then it will be automatically committed to the database.

Explicit Transactions::
We can define an explicit transaction by using BEGIN TRANSACTION statement this can then bended with either a COMMIT or ROLLBACK statement.
It is common to put an explicit tranactions within store procedure

--Begin a new transaction:
BEGIN TRANSACTION;

--DECLEAR a varible call ed @new_product_id that will hold the new product_id value::
DECLRE @new_product_id INT;

-- Insert the new product. the product_id value is generated by the IDENTITY property:
INSERT INTO oes.product(product_name, category_id, list_price, discontinued) 
	VALUES ('PBX Printer', 7, 45.99, 0)

--The SCOPE_IDENTITY() function returns the last value inserted into the IDENTITY column::
SET @new_product_id = SCOPE_IDENTITY()


--Insert the inventory informaation for the new products::

INSERT INTO oes.inventories (product _id, warehouse_id, quentity_on_hand)
	VALUES	(@new_product_id,1, 100),
			(@new_product_id, 4, 35);


--Commit the changes. The commit will only happen if both insert  statements are successfull::
COMMIT TRANSACTION; 

*/

/*
Stored Procedures::

A store procedure is simply some SQL code that is saved in datbase which can be executed.
When a stored procedure is executed the SQL statements contained within the procedure are executed.
Often stored procedures will contain a batch of SQL statement which are treated as a logical unit.
A stored procedure can be defined to accept input and output parameters.

Benifits of Store Procedures::
Stored procedures support workflows consisting of multiple steps.
They can be sued to modify table data as well as alter, drop, or create database object.
They can hide complex logic from users. All a user needs to do is provide some parameter values and execute the stored procedure.
The application can execute (call) a stored procedure instead of implementing that same logic in the application itself.

SYNTAX:::

CREATE PROCEDURE procedure_name
	(
		@parameter1 data_type, @parameter2 data_type
	) AS
	sql_statement ...
	;

CREATE PROCEDURE procedure_name
	(
		@parameter1 data_type, @parameter2 data_type
	) 
	AS
	BEGIN
	sql_statement ...
	
	END;

CREATE PROCEDURE procedure_name
	(
		@parameter1 data_type, @parameter2 data_type
	) 
	AS
	BEGIN TRANSACTION;
	sql_statement ...
	
	COMMIT TRANSACTION;


Executing a Stored Procedure
EXECUTE procedure_name 
	@parameter1 = parame1_value;
	@parameter2 = parame2_value;

*/

-- Select all employees from the 'Finance department';

SELECT * FROM hcm.employees;

SELECT
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	d.department_name 
FROM hcm.employees AS e
INNER JOIN hcm.departments AS d
ON e.department_id = d.department_id
WHERE d.department_name='Finance';

GO

-- Stored procedure on input parameter::
CREATE PROCEDURE hcm.getEmployeeByDepartment(@department_name VARCHAR(50))
AS
SELECT
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	d.department_name 
FROM hcm.employees AS e
INNER JOIN hcm.departments AS d
ON e.department_id = d.department_id
WHERE d.department_name= @department_name;

GO

--Execute hcm.getEmployeeByDepartment  stored procedure to get all employee in the 'Finance' department;

EXECUTE hcm.getEmployeeByDepartment @department_name = 'Finance' ;

--OR

EXECUTE hcm.getEmployeeByDepartment 'Finance';

--OR

EXEC hcm.getEmployeeByDepartment 'Finance';


--Execute hcm.getEmployeeByDepartment  stored procedure to get all employee in the 'Sales' department;
EXEC hcm.getEmployeeByDepartment 'Sales';

--Select query that select customer who contain the string 34th in their street address

SELECT * FROM oes.customers;
SELECT 
	customer_id,
	first_name,
	last_name,
	email,
	street_address
FROM oes.customers
WHERE street_address LIKE '%34th%';
GO

CREATE PROCEDURE oes.searchCustomersByStreetAdderess 
(
	@street_address_search VARCHAR(50)
)
AS
SELECT 
	customer_id,
	first_name,
	last_name,
	email,
	street_address
FROM oes.customers
WHERE street_address LIKE '%'+@street_address_search+'%';
GO

EXECUTE oes.searchCustomersByStreetAdderess '34th';
GO

--Select query that customer from Australia who have gmail email addresses::

SELECT
	cu.customer_id,
	cu.first_name,
	cu.last_name,
	cu.email,
	ct.country_name
FROM oes.customers cu
INNER JOIN hcm.countries ct
ON cu.country_id = ct.country_id
WHERE ct.country_name = 'Australia'
AND cu.email LIKE '%gmail.com'

GO

CREATE PROCEDURE oes.getCustomerBycountryEmail
(
	@country VARCHAR(50),
	@email_domain VARCHAR(320)
)
AS
BEGIN
	SELECT
		cu.customer_id,
		cu.first_name,
		cu.last_name,
		cu.email,
		ct.country_name
	FROM oes.customers cu
	INNER JOIN hcm.countries ct
	ON cu.country_id = ct.country_id
	WHERE ct.country_name = @country
	AND cu.email LIKE '%'+ @email_domain
END
GO 

EXECUTE oes.getCustomerBycountryEmail 'Australia', 'gmail.com';

--Select employee who have a salary greater than or equal to 80000 nd less than or equal 100000
SELECT 
	employee_id,
	first_name,
	last_name,
	department_id,
	salary
FROM hcm.employees
WHERE salary >= 80000
AND salary <= 100000
GO


CREATE PROCEDURE hcm.getemployeeBySalaryRange
(
	@min_salary DECIMAL (12,2),
	@max_salary DECIMAL (12,2)
)
AS
SELECT 
	employee_id,
	first_name,
	last_name,
	department_id,
	salary
FROM hcm.employees
WHERE salary >= @min_salary
AND salary <= @max_salary
GO


--SELECT employees between default range i.e @min_salary = 0, @max_salary = 9999999999
EXECUTE  hcm.getemployeeBySalaryRange 80000, 100000;


/*
--Optional parameters::
We can specify default values for paremeters.  In alter procedure below. @min_salary is set to default value of 0 and @max_salary is set to default 9999999. there fore when you executer the stored procedure you have the option to skip the parameter which have default  parameter.

*/

GO
ALTER PROCEDURE hcm.getemployeeBySalaryRange 
(
	@min_salary DECIMAL (12,2) = 0,
	@max_salary DECIMAL (12,2) = 99999999
)
AS
SELECT 
	employee_id,
	first_name,
	last_name,
	department_id,
	salary
FROM hcm.employees
WHERE salary >= @min_salary
AND salary <= @max_salary
GO


--Select employee with main salary of 90000 and default max salary
EXECUTE hcm.getemployeeBySalaryRange @min_salary = 90000;

--Select employee with main salary of 90000 and default min salary
EXECUTE hcm.getemployeeBySalaryRange @max_salary = 150000;



---OutputParemeters
SELECT * FROM dbo.parks2;

CREATE PROCEDURE dbo.addNewPark
(
	@park_name VARCHAR(50),
	@entree_free DECIMAL(6,2) = 0,
	@new_park_id INT OUT
)
AS
-- Setting the NOCOUNT option ON means that SQL server won't show message reporting how many row created.
SET NOCOUNT ON;

--If XACT_ABORT setting is OFF then not all run-time errors will cause the tranction to rollback.
-- By setting XACT_ABORT setting ON then all errors will cause the transction to rollback and exeution of the code to abort:
SET XACT_ABORT ON;

BEGIN
INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES(@park_name, @entree_free)

--Setting the  @new_park_id output paremeters to the value returnd by the scope_IDENTITY 
--SOCPE_IDENTITY() return the IDENTITY value of the last insert thar occurred in the same 

SELECT @new_park_id = SCOPE_IDENTITY();

END
GO


/*
To execute a stored procedure with an output parameter(s) we must declear a varible to store the value returned by the output parameter ::
*/

-- Declear a varible called @parkID of data type INT.
--This will store the value returnd by the  'Green meadows ' park.
DECLARE @ParkID INT;
--Execute the stored procedure to add the 'Green Meadows' park.
EXEC dbo.addNewPark @park_name = 'Green Meadows-3', @entree_free= 5.8, @new_park_id = @ParkID OUT;
SELECT @ParkID
GO
SELECT * FROM dbo.parks2;

/*
Notes::
We set the output paremeter (@new_park_id ) to the varible (@parkID).
Importentlyy, we need to include the keyword out or output after any output paremeter. If we need to include the keyword out or output paremeter in the execute statement the varible will not recive the value from the output paremeter.

*/


/*
Challenge 1:: Create a stored procedure called oes.getQuantityOnHand that returns the quantity_on_hand in the oes.inventories table for a
given product_id and warehouse_id Execute the stored procedure to return the quantity on hand of product id 4 at warehouse id 2.
*/
SELECT * FROM oes.inventories;

CREATE PROCEDURE oes.getQuantityOnHand 
(
	@product_id INT,
	@warehouse_id INT
)
AS
BEGIN 
-- How much quentity on hand is there for product_id X at wherehouse Y?
SELECT 
	quantity_on_hand
FROM oes.inventories
WHERE 
	product_id = @product_id AND warehouse_id = @warehouse_id;

END
GO

EXEC oes.getQuantityOnHand 4 , 1;

/*
Challenge 2 :: Create a stored procedure called oes.getCurrentProducts that returns current products ( discontinued = 0 ) in the oes.products table. In addition, define two input parameters: 
- A parameter called @product_name of data type VARCHAR ( 100). Allow users to wildcard search on the product_name 
- A parameter called @max_list_price of data type DECIMAL ( 19,4). Allow users to only include current products that have a list_price that is less than or equal to a specified value for this parameter. Execute the stored procedure to return current products that contain the word ‘Drone’ and have a maximum price of $700.
*/

CREATE PROCEDURE oes.getCurrentProducts 
(
	@product_name  VARCHAR ( 100),
	@max_list_price  DECIMAL ( 19,4)
)
AS
BEGIN

SELECT 
	product_id,
	product_name,
	list_price

FROM oes.products
WHERE discontinued = 0
AND product_name  LIKE '%' + @product_name  + '%'
AND list_price <= @max_list_price;

END
GO

EXEC oes.getCurrentProducts 'Drone' , 700;

/*

Challenge 3:: Create a stored procedure called oes.transferFunds that transfers money from one bank account to another bank account by updating the balance column in the oes.bank_accounts table. Also, insert the bank transaction details into oes.bank_transactions table. Define three inputparameters:
-@withdraw_account_id of data type INT
-@deposit_account_id of data type INT
-@transfer_amount of data type DECIMAL (Test the stored procedure by transferring $100 from Anna’s bank account to Bob’s account. 
*/

CREATE TABLE oes.bank_accounts 
(
	account_id INT IDENTITY,
	account_name VARCHAR(50) NOT NULL,
	balance DECIMAL(30,2),
CONSTRAINT pk_bank_accounts_account_id PRIMARY KEY (account_id),
CONSTRAINT chk_bank_accounts_balance CHECK (balance >= 0)
);


INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Anna', 3400);
INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Bob', 2400);
INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Sandra', 2800);
INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Abdul', 3200);




CREATE TABLE oes.bank_transactions
(
	tr_id INT IDENTITY,
	tr_datetime datetime2 DEFAULT GETDATE(),
	from_account_id INT,
	to_account_id INT,
	amount DECIMAL(30,2),
CONSTRAINT pk_transactions_transaction_id PRIMARY KEY (tr_id),
CONSTRAINT fk_transactions_from_account_id FOREIGN KEY (from_account_id)
	REFERENCES oes.bank_accounts(account_id),
CONSTRAINT fk_transactions_to_account_id FOREIGN KEY (to_account_id)
	REFERENCES oes.bank_accounts(account_id)
);



INSERT INTO oes.bank_transactions (from_account_id, to_account_id, amount) VALUES (4, 3, 150);
INSERT INTO oes.bank_transactions (from_account_id, to_account_id, amount) VALUES (1, 4, 92.5); 

SELECT * FROM oes.bank_accounts;
SELECT * FROM oes.bank_transactions;

CREATE PROCEDURE oes.transferFunds
(
	@withdraw_account_id  INT,
	@deposit_account_id  INT,
	@transfer_amount DECIMAL (30,2)
)
AS
--Setting the acount option to ON means tht SQL Server won't show message repoting How 

SET XACT_ABORT ON;

BEGIN
BEGIN TRANSACTION;

UPDATE oes.bank_accounts 
SET balance = balance - @transfer_amount
WHERE account_id = @withdraw_account_id;

UPDATE oes.bank_accounts 
SET balance = balance + @transfer_amount
WHERE account_id = @deposit_account_id;

INSERT INTO oes.bank_transactions (from_account_id, to_account_id, amount)
VALUES (@withdraw_account_id, @deposit_account_id, @transfer_amount);

COMMIT TRANSACTION;

END
GO

EXEC oes.transferFunds 1,2,100.12;


SELECT * FROM oes.bank_accounts;
GO



/*
ALTER table statement 
The ALTER TABLE statement can be used to add modify or drop column in an exiting table.
Note:: 
In SQL we used the term 'drop' when we delete an object such as a table, column etc wheres, we use the term delete when deleting a row.

Syntax::
ALTER TABLE table_name
ADD column_name column _data_type

Example::
ALTER dbo.products ADD product_code INT;

Note::
When we add a column to a table it always get added to the end of the table.

For multiple column::
ALTER TABLE table_name
ADD column1 column1_data_type,
	column2 column2_data_type;

Example::
ALTER TABLE dbo.products
ADD product_code INT,
	date_added DATETIME2,
	notes VARCHAR(100)


Modify an exiting column::
Syntax::
ALTER TABLE table_name
ALTER COLUMN column_name column_data_type;

Example::
ALTER TABLE dbo.products
ALTER COLUMN product_name VARCHAR(50) NOT NULL;


DROP a column in a table
SYNTAX:
ALTER TABLE table_name
DROP COLUMN column_name;

EXAMPLE::
ALTER TABLE dbo.products DROP COLUMN color:

In this example, the column call ed 'color' - as well as all the data in this column - is permantly removed from the database table.


Eename a column in table::
Syntax::
sp_rename 'schema_name.table_name.old_column_name', 'new_column_name', 'COLUMN';

EXAMPLE::
sp_rename 'dbo.prducts.product_name', 'prod_name' 'COLUMN';

NOTE::
Beware that changing a column name can breake script, stored procedure and views that are still referancing the old column name.

sp_rename can alsobe used to rename other type of object. however, it is not recommended to use sp_rename for some type of objects. such as stored procedure and views. this is beacuse there are some metadata system views which store the object code and these will not be updated.

*/

/*
Challenge-1:: Add a new column called ‘termination_date ’ onto the hcm.employees table. Give this new column a data type of DATE
*/
ALTER TABLE hcm.employees
ADD termination_date DATE;

SELECT * FROM hcm.employees

/*
Challenge-2:: Write two SQL statements to change the data type of the first_name and last_name columns to NVARCHAR(60) in the oes.customers table.
*/

ALTER TABLE oes.customers
	ALTER COLUMN first_name NVARCHAR(60) NOT NULL;
ALTER TABLE oes.customers
	ALTER COLUMN last_name NVARCHAR(60) NOT NULL; 


/*
Challenge-3:: Use sp_rename to rename the column name 'phone' to main_phone ' in the oes.customers table. Note that this challenge does not use an ALTER TABLE statement.
*/

sp_rename 'oes.customers.phone', 'main_phone', 'COLUMN';

SELECT * FROM oes.customers;

/*
The UNIQUE constaint 

The UNIQUE constrint is type of integrity constraint.
A UNIQUE constraint ensure that the column specified in the constraint cn only have unique values.
If multiple column are specified in the constraint then only unique combinations of the column values are allowed.
The UNIQUE constraint is similar to a PRIMARY KEY constraint. However there are some important diffrences.

PRIMARY KEY vs. UNIQUE constraint

PRIMARY KEY Constraint:: 
A single table can only have one primary key constraint.
A primary key ensures that values are both unique and NOT NULL.
A primary ke automatically create an associated unique index.

UNIQUE constraint::
A single table can have multiple unique constraint.
A unique constraint ensure values are unique but does allow a null.
A unique constraint autometically cretes an associated unique index.

SYNTAX::
ALTER TABLE table_name
ADD CONSTRAINT constraint_name UNIQUE (COLUMN_name);

Example::
ALTER TABLE dbo.products
ADD CONSTRAINT uk_products_product_name UNIQUE (product_name);
*/
/*
Challenge-1:: Use an ALTER TABLE statement to add a  UNIQUE constraint to the department_name column in the hcm.departments 
*/
SELECT * FROM hcm.departments;

--Query information schema views to get metadata on contraint on hecm.department table::
SELECT 
	tc.TABLE_SCHEMA,
	tc.TABLE_NAME,
	tc.CONSTRAINT_TYPE,
	CCU.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
AND tc.TABLE_NAME = ccu.TABLE_NAME
AND tc.TABLE_SCHEMA = ccu.TABLE_SCHEMA
WHERE tc.TABLE_SCHEMA = 'hcm' AND tc.TABLE_NAME = 'departments';

SELECT COUNT(*), COUNT(DISTINCT department_name) FROM hcm.departments;


ALTER TABLE  hcm.departments 
ADD CONSTRAINT uk_departments_department_name UNIQUE (department_name);



/*
CHECK Constraints::
A CHECK constraint is a type of integrity constraint.
A CHECK constraint can be applied to column and check tht each value in the column meets a certain condition.
A CHECK constraint cannot refer to a column from another table.
A check constraint cannot contain a subquery.

SYNTAX::
ALTER TABLE table_name
ADD CONSTRAINT constraint_name CHECK (column_name condition);

Example::
ALTER TABLE dbo.order_details
ADD CONSTRAINT check_order_details_quantity CHECK (quentity > 0);

THIS CHECK constraint ensure that the column called quentity will always have a value greater than zero.
Example::
ALTER TABLE dbo.products
ADD CONSTRAINT check_product_color
CHECK(COLOR IN ('Red', 'Blue', 'Yellow', 'Black','White'));


*/

/*
Challange::
Use an ALTER TABLE statement to add a CHECK constraint on the salary column in the hcm.employees table to ensure that salary is greater than or equal to zero.
*/
SELECT * FROM  hcm.employees;
ALTER TABLE hcm.employees 
ADD CONSTRAINT check_employees_salary CHECK(salary >= 0);

/*
Introduction to Indexs::
An index is a data structure which can speed up search on a table if properly implemented. 
An index can be applied to one or more columns in table.
Indexes are a separate date structure to the table on which they are applied.
Indexs take up applied.
An index can slow down insert update and delete statement because the index also need to be updated.


Book Index Analogy::
An index in a database can be likend to an index in a book.
A book index helps you to quickly find what page to find some topic.
A book index copies a small piece of information( i.e. a topic ) and then order it alphabetically.
Each topic has a reference to one or more page numbers in the book.
An index in a database referances locations in table, rather than page in a book.

Terminology::
Heap:
A heap is  a table that doesnot have a clustered index on it.

Table Scan::
A table scan is where the SQL engine reads all the rows and columns.

Index Scan:
An index scan is where the SQL engine reads all the rows (or index pages) and only the columns in the indx.

Index seek:
An index seek uses the index to pinpoint only the rows thar are needed to satisfy the query.

Cardinility::
Cardinality refers to the number of unique value in an column.

Selectivity::
Selectivity is a measure of how much an index can help to narrow the search for specific values in table. there are to ways it can be expressed:
	Average Selectivity:  Average Selectivity is the cadinality divided by the total number of rows in table.
	Selectivity of a specific value: It is the number of rows for a specific value divided by the total number of rows in a table.
Example::

SELECT 
	COUNT(DISTINCT(order_status)) AS cardinality FROM db.orders;

SELECT
	(COUNT(DISTINCT(order_status)) * 1.0 / COUNT(*)) AS avg_selectivity FROM dbo.orders;

SELECT
	(SELECT COUNT(*) FROM orders WHERE order_status = 'Closed') * 1.0/COUNT(*) AS selectivity_fro_value_closed
FROM orders;


Implications of selectivity::
When average selectivity is low for a column then it is often best not to index that column.

For example, imagine a column with to possibe values 'Yes' or 'No' and there are 10,000 rows in the table, then the selectivity would be only 0.0002
If the column had an even distribution  i.e 50% of the rows have a value of 'Yes' and 50% of 'No', then this means...
SQL would need to access the index 5000 times to find one of the two possible values
Accessing the index takes time and in this case the query optimizer will likely determine it faster to simply do a full table scan and therefore no use index. 

Index Type::
Non-Clusterd Indexs:
A non-clustered index is regular b+ tree index.
A nopn-clusterd index is stored at diffrent place to the table data.
The non-clusterd index contains pointers to the location of data.
This allows for multiple non-clusterd indexes on a single table 

Syntax:
CREATE NONCLUSTERD INDEX index_name
ON able_name (column1_name, column2_name,...)

Example::
CREATEX index ix_account_name ON dbo.accounts(account_name);

Clusterd Indexes::
A clusterd index is an index which physically sorts the table data accroding to the indeed column(s)
Table data can be stored in only one way. Therefore, we can only create one clusterd index per table.
By default, a primary key constraint will also create a clusterd index on the primary key column.
For example:
ALTER TABLE dbo.accounts ADD CONSTRAINT px_account_acount_id PRIMARY KEY CLUSTERED (acount_id);

If requried, it is possible to create a clustred index by itself on a column that is not the primary key. 
FOR example::
CREATE CLUSTERD INDEX  ix_employee_login_id ON dbo.employees(login_id);

Primary Key vs. Cluster Index::
A primary ke constraint is logical concept:
	A primary  key constraint ensure that the key column(s) can be used to uniquely identify each row in table.

A cluster index is phycal concept:
	A cluster index defines the order that the row in a table are stored on disk. It does this based on the column specified in the clusterd index.
	A clusterd index can even be applied to a column that does not have unique values.	
	However it generally recommended to apply the clusterd inddex index on a column that has unique values.

	The Primary key column do not necessarly have to be same as cluterd index column(s).


Should Primary Key always have a clusterd index?
A primary ke automatically creates a clusterd index if there is no other exiting clusterd index on the table.
In most situation, it is best to just leave it on the default, and have the primary key create an associated clustered index.
There are some situations where we might put a clustered index on a diffrent column to the primary key:
	If there is some alternate key that is more frequently used in queries.
	The primary key has a large key width. This is more frequently used in queryes.
	The primary key has a large key width. This is because the clusterd key values get replicated in very one of the non-clusterd indexes on the same table.

Unique Indexes
A unique index ensure that a column can only contain unique values.
By default in SQL server..
	When either a unique constraint or primary key constraint is created, then a corresponding unique index also created.
	A unique constraint will automatically create a corresponding clustered index.
	A primary key constraint will automatically create a corresponding clusterd index.
A unique index can also be created by itself.

Syntax:
CREATE UNIQUE INDEX index_name
	ON table_name (column1, column2,....)


Filterd Indexs
A filtered index is a type of non-clusterindex where only some of the rows are index based on some condition.
Because only a portion of the rows are indexed this can save on space and improve query performance.
Filterd indexes are usefull on column that have a lot of nulls
Filterd index are also useful if you often query for a value that makes up a small proportion of the total rows in table.

Syntax::
CREATE INDEX index_name
	On table(columnName, column2)
Where condition

CREATE INDEX ix_employee_termination_date
	ON hcm.employees (termination_date)
WHERE TERMINATION_DATE is null


General Indexing Guidelines::
Avoid over-indexing heavily update tamle.
Keep indexes  narrow it with as few column as is rquried.
You can create many indexes on table that is seldom update.
Indexing small tables that are likely to stay small is often not necessary to do.
Consider indexingforigen key columns.
Consider filtering index to help optimize queries that return a well-defined subset of rows from a large table.

Clusterd Index Guidelines::
With few exceptions, it is best to put a cluster index on everytable.
Ideally the clusterd index should be on a column that is unique, non-null, narrow in size, and are typically accessed sequentially.