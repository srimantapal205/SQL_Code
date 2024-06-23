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





*/