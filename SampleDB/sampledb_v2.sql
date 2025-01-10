CREATE TABLE Person1    (
  PersonId INT NOT NULL IDENTITY,
  FirstName VARCHAR(50) NOT NULL,
  MiddleName VARCHAR(50),
  LastName VARCHAR(50) NOT NULL,
  Date DATE NOT NULL,
);

INSERT INTO Person1 (FirstName, MiddleName, LastName, Date)
VALUES
('John', 'A.', 'Doe', '2024-01-15'),
('Jane', NULL, 'Smith', '2023-12-05'),
('Robert', 'B.', 'Johnson', '2024-06-20'),
('Emily', 'C.', 'Davis', '2023-10-10'),
('Michael', NULL, 'Brown', '2024-04-30');


UPDATE Person1
SET 
    FirstName = 'Janet',
    MiddleName = 'E.',
    LastName = 'Smithers',
    Date = '2024-11-18'
WHERE PersonId = 2;

SELECT * FROM Person1;

CREATE TABLE employeesData
(
  surg_key INT NOT NULL IDENTITY PRIMARY KEY,
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR(50),
  last_name VARCHAR(50) NOT NULL,
  salary INT,
  isActive INT
);


INSERT INTO employeesData (employee_id, first_name, middle_name, last_name, salary, isActive)
VALUES 
(101, 'John', NULL, 'Doe', 50000, 1),
(102, 'Jane', 'Marie', 'Smith', 60000, 1),
(103, 'Robert', NULL, 'Brown', 70000, 0),
(104, 'Emily', 'Ann', 'Davis', 55000, 1),
(105, 'Michael', 'James', 'Johnson', 75000, 1),
(106, 'Sophia', 'Grace', 'Wilson', 65000, 0),
(107, 'Daniel', NULL, 'Taylor', 58000, 1),
(108, 'Olivia', 'Rose', 'Anderson', 72000, 1),
(109, 'William', NULL, 'Thomas', 68000, 0),
(110, 'Emma', 'Lynn', 'White', 80000, 1);


SELECT * FROM employeesData;