USE MASTER
GO

IF DB_ID(N'MARKETPLACEDB') IS NOT NULL  DROP DATABASE MARKETPLACEDB;

IF @@ERROR = 3702
	RAISERROR(N'Data can not be dropped because there ae still open connection', 127,127) WITH NOWAIT, LOG

--CREATE DataBase
CREATE  DATABASE MARKETPLACEDB;

USE MARKETPLACEDB;
GO

-- CREATE SCHEMA
CREATE SCHEMA Sales AUTHORIZATION dbo
GO

USE MARKETPLACEDB;
GO
-- Create the Customer Table
CREATE TABLE Sales.Customer (
	CustomerId INT NOT NULL IDENTITY,
	FristName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Email VARCHAR(100),
	Phone VARCHAR(30),
	Address VARCHAR(200),
	City VARCHAR(50),
	State VARCHAR(50),
	ZipCode VARCHAR(10),
	CreateDate DATETIME DEFAULT GETDATE(),
	CONSTRAINT pk_customers PRIMARY KEY(CustomerId)
);
-- Create the Product Table
CREATE TABLE Sales.Product (
	ProductId INT NOT NULL IDENTITY,
	ProductName VARCHAR(100),
	Category VARCHAR(50),
	Price DECIMAL(10, 2),
	Stock INT,
	CreateDate DATETIME  DEFAULT GETDATE()
	CONSTRAINT pk_products PRIMARY KEY(ProductId)
)

-- Create the Transactions Table
CREATE TABLE Sales.Transactions(
	TransactionId INT NOT NULL IDENTITY,
	Product_Id INT NOT NULL,
	Customer_ID INT NOT NULL,
	Quantity INT,
	TotalAmount DECIMAL(10, 2),
	TransactionDate DATETIME DEFAULT GETDATE(),
	CONSTRAINT pk_Transactions PRIMARY KEY (TransactionId),
	CONSTRAINT fk_product_id FOREIGN KEY (Product_Id) REFERENCES  Sales.Product (ProductId),
	CONSTRAINT fk_customer_id FOREIGN KEY (Customer_ID) REFERENCES Sales.Customer (CustomerId)
)



-- Query to Verify Data
SELECT * FROM Sales.Customer;
SELECT * FROM Sales.Product;
SELECT * FROM Sales.Transactions;

-- Insert Sample Data into Customer Table

INSERT INTO Sales.Customer(FristName, LastName, Email, Phone, Address, City, State, ZipCode ) 
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street', 'Springfield', 'IL', '62701'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Oak Street', 'Chicago', 'IL', '60601'),
('Alice', 'Johnson', 'alice.johnson@example.com', '5551234567', '789 Pine Street', 'Houston', 'TX', '77001'),
('Bob', 'Brown', 'bob.brown@example.com', '4567891230', '321 Maple Street', 'Austin', 'TX', '73301'),
('Clara', 'White', 'clara.white@example.com', '2345678901', '654 Cedar Street', 'Dallas', 'TX', '75201'),
('David', 'Black', 'david.black@example.com', '3456789012', '987 Birch Street', 'Atlanta', 'GA', '30301'),
('Emily', 'Taylor', 'emily.taylor@example.com', '5678901234', '123 Willow Street', 'Miami', 'FL', '33101'),
('Frank', 'Garcia', 'frank.garcia@example.com', '6789012345', '456 Aspen Street', 'Orlando', 'FL', '32801'),
('Grace', 'Martinez', 'grace.martinez@example.com', '7890123456', '789 Redwood Street', 'Phoenix', 'AZ', '85001'),
('Hannah', 'Lee', 'hannah.lee@example.com', '8901234567', '321 Dogwood Street', 'Los Angeles', 'CA', '90001'),
('Ian', 'Harris', 'ian.harris@example.com', '9012345678', '654 Poplar Street', 'San Diego', 'CA', '92101'),
('Julia', 'Clark', 'julia.clark@example.com', '1234567891', '987 Magnolia Street', 'San Francisco', 'CA', '94101'),
('Kevin', 'Wright', 'kevin.wright@example.com', '2345678902', '123 Walnut Street', 'Seattle', 'WA', '98101'),
('Lara', 'King', 'lara.king@example.com', '3456789013', '456 Cherry Street', 'Portland', 'OR', '97201'),
('Mike', 'Adams', 'mike.adams@example.com', '4567891231', '789 Spruce Street', 'Denver', 'CO', '80201'),
('Nina', 'Scott', 'nina.scott@example.com', '5678901235', '321 Elmwood Street', 'Boston', 'MA', '02101'),
('Oscar', 'Green', 'oscar.green@example.com', '6789012346', '654 Hickory Street', 'New York', 'NY', '10001'),
('Paula', 'Baker', 'paula.baker@example.com', '7890123457', '987 Cypress Street', 'Buffalo', 'NY', '14201'),
('Quinn', 'Morris', 'quinn.morris@example.com', '8901234568', '123 Ash Street', 'Philadelphia', 'PA', '19101'),
('Rachel', 'Ward', 'rachel.ward@example.com', '9012345679', '456 Beech Street', 'Pittsburgh', 'PA', '15201'),
('Steve', 'Evans', 'steve.evans@example.com', '1234567892', '789 Oakwood Street', 'Cleveland', 'OH', '44101'),
('Tina', 'Hill', 'tina.hill@example.com', '2345678903', '321 Linden Street', 'Cincinnati', 'OH', '45201'),
('Uma', 'Ramirez', 'uma.ramirez@example.com', '3456789014', '654 Aspenwood Street', 'Columbus', 'OH', '43201'),
('Victor', 'Bell', 'victor.bell@example.com', '4567891232', '987 Pinewood Street', 'Indianapolis', 'IN', '46201'),
('Wendy', 'Carter', 'wendy.carter@example.com', '5678901236', '123 Redwood Lane', 'Chicago', 'IL', '60602'),
('Xander', 'Howard', 'xander.howard@example.com', '6789012347', '456 Birch Lane', 'Springfield', 'IL', '62702'),
('Yara', 'Flores', 'yara.flores@example.com', '7890123458', '789 Cedar Lane', 'San Antonio', 'TX', '78201'),
('Zach', 'Nelson', 'zach.nelson@example.com', '8901234569', '321 Walnut Lane', 'Houston', 'TX', '77002');

-- Insert  Sample Products into the Product Table
INSERT INTO Sales.Product(ProductName, Category, Price, Stock) 
VALUES
('Laptop', 'Electronics', 1200.00, 50),
('Smartphone', 'Electronics', 800.00, 100),
('Desk Chair', 'Furniture', 150.00, 200),
('Monitor', 'Electronics', 300.00, 75),
('Book', 'Stationery', 20.00, 500),
('Tablet', 'Electronics', 600.00, 80),
('Wireless Mouse', 'Accessories', 25.00, 300),
('Keyboard', 'Accessories', 45.00, 250),
('Gaming Console', 'Electronics', 500.00, 60),
('Headphones', 'Electronics', 75.00, 200),
('Desk', 'Furniture', 200.00, 150),
('Office Chair', 'Furniture', 180.00, 180),
('Notebook', 'Stationery', 10.00, 1000),
('Pen Set', 'Stationery', 15.00, 800),
('Printer', 'Electronics', 200.00, 90),
('External Hard Drive', 'Electronics', 100.00, 150),
('USB Flash Drive', 'Accessories', 20.00, 500),
('Projector', 'Electronics', 400.00, 40),
('Whiteboard', 'Office Supplies', 120.00, 70),
('Backpack', 'Accessories', 50.00, 200),
('Smartwatch', 'Electronics', 250.00, 100),
('Fitness Tracker', 'Electronics', 150.00, 150),
('Gaming Keyboard', 'Accessories', 100.00, 70),
('Gaming Mouse', 'Accessories', 60.00, 90),
('Graphic Tablet', 'Electronics', 350.00, 30),
('Water Bottle', 'Accessories', 20.00, 300),
('Calculator', 'Office Supplies', 30.00, 200),
('Desk Lamp', 'Furniture', 45.00, 150),
('Ruler', 'Stationery', 5.00, 1000),
('Stapler', 'Stationery', 15.00, 500),
('Scissors', 'Stationery', 10.00, 400),
('Camera', 'Electronics', 700.00, 60),
('Tripod', 'Accessories', 50.00, 100),
('Phone Case', 'Accessories', 20.00, 400),
('Screen Protector', 'Accessories', 10.00, 500),
('Speakers', 'Electronics', 150.00, 100),
('Router', 'Electronics', 100.00, 80),
('Extension Cord', 'Electronics', 25.00, 200),
('Coffee Mug', 'Accessories', 15.00, 300),
('Desk Organizer', 'Office Supplies', 30.00, 250),
('Couch', 'Furniture', 800.00, 20),
('Bookshelf', 'Furniture', 120.00, 40),
('Conference Table', 'Furniture', 600.00, 10),
('Paper Shredder', 'Office Supplies', 150.00, 30),
('Sticky Notes', 'Stationery', 10.00, 700),
('Markers', 'Stationery', 20.00, 600),
('Glue Stick', 'Stationery', 5.00, 800),
('Drawing Tablet', 'Electronics', 250.00, 40),
('VR Headset', 'Electronics', 900.00, 20),
('Drone', 'Electronics', 1200.00, 15);


-- Insert 100 Random Transactions
DECLARE @CustomerId INT;
DECLARE @ProductId INT;
DECLARE @Quantity INT;
DECLARE @Count INT = 1;
WHILE @Count <= 100
BEGIN
    -- Generate Random CustomerID
    SELECT @CustomerId = FLOOR(RAND(CHECKSUM(NEWID())) * (SELECT MAX(CustomerId) FROM Sales.Customer) + 1);

    -- Generate Random ProductID
    SELECT @ProductId = FLOOR(RAND(CHECKSUM(NEWID())) * (SELECT MAX(ProductId) FROM Sales.Product) + 1);

    -- Generate Random Quantity (1 to 10)
    SELECT @Quantity = FLOOR(RAND(CHECKSUM(NEWID())) * 10 + 1);

    -- Insert Transaction
    INSERT INTO Sales.Transactions (Customer_ID, Product_Id, Quantity)
    VALUES (@CustomerId, @ProductId, @Quantity);

    -- Increment Counter
    SET @Count = @Count + 1;
END;

-- Update TotalAmount in the Transaction table
UPDATE t  SET t.TotalAmount = p.Price * t.Quantity FROM Sales.Transactions AS t
JOIN Sales.Product AS p ON t.Product_Id = p.ProductId