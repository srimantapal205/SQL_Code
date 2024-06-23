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

*/

