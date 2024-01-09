use classicmodels;

## DAY 3 
--------------------------------------------------------------------------
-- Q-1

SELECT * FROM CUSTOMERS;

SELECT customerNumber,customerName,state,creditLimit 
FROM CUSTOMERS
WHERE STATE IS NOT NULL
AND CREDITLIMIT BETWEEN 50000 AND 100000
ORDER BY CREDITLIMIT DESC;
--------------------------------------------------------------------------
-- Q-2

SELECT * FROM PRODUCTS;

SELECT DISTINCT productline
FROM products
WHERE productline LIKE '%cars';

--------------------------------------------------------------------------
--------------------------------------------------------------------------
## DAY 4
--------------------------------------------------------------------------
-- Q-1

SELECT * FROM ORDERS;

SELECT orderNumber, status, IFNULL(comments, '-') AS comments
FROM orders
WHERE status = 'Shipped';
----------------------------------------------------------------------------
-- Q-2

SELECT * FROM EMPLOYEES;

SELECT 
    employeeNumber,
    firstName,
    jobTitle,
    CASE
        WHEN jobTitle = 'President' THEN 'P'
        WHEN jobTitle LIKE '%Manager%' THEN 'SM'
        WHEN jobTitle = 'Sales Rep' THEN 'SR'
        WHEN jobTitle LIKE '%VP%' THEN 'VP'
    END AS jobTitleAbbreviation
FROM employees;
----------------------------------------------------------------------------
----------------------------------------------------------------------------
## DAY 5
----------------------------------------------------------------------------
-- Q-1
SELECT * FROM PAYMENTS;

SELECT YEAR(paymentDate),MIN(AMOUNT) FROM PAYMENTS
GROUP BY YEAR(paymentDate)
ORDER BY YEAR(paymentDate);
------------------------------------------------------------------------------
-- Q-2

SELECT * FROM ORDERS;

SELECT
      YEAR(orderDate) as Year,
CONCAT('Q',
          CASE
               WHEN MONTH(orderDate) BETWEEN 1 AND 3 THEN'1'
			   WHEN MONTH(orderDate) BETWEEN 4 AND 6 THEN '2'
	           WHEN MONTH(orderDate) BETWEEN 7 AND 9 THEN '3'
			   WHEN MONTH(orderDate) BETWEEN 10 AND 12 THEN '4'
END
) AS Quarter,
         COUNT(DISTINCT customerNumber) as Unique_Customers,
         COUNT(*) as Total_Orders
FROM ORDERS
GROUP BY YEAR,QUARTER
ORDER BY YEAR,QUARTER;  
---------------------------------------------------------------------------------
-- Q-3

SELECT * FROM PAYMENTS;

SELECT
    DATE_FORMAT(paymentDate, '%b') AS month,
    CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS formattedAmount
FROM payments
GROUP BY month
HAVING SUM(amount) BETWEEN 500000 AND 1000000
ORDER BY SUM(amount) DESC;
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
## DAY 6
---------------------------------------------------------------------------------
-- Q-1

CREATE TABLE JOURNEY(
       BUS_ID INT UNSIGNED NOT NULL,
       BUS_NAME VARCHAR(100) NOT NULL,
       SOURCE_STATION VARCHAR(100) NOT NULL,
       DESTINATION VARCHAR(100) NOT NULL,
       E_mail VARCHAR(255) NOT NULL UNIQUE,
	   primary key (BUS_ID)
);       
       SELECT * FROM JOURNEY;
       DESC JOURNEY;
----------------------------------------------------------------------------------
 -- Q-2

CREATE TABLE VENDOR(
       VENDOR_ID INT UNSIGNED NOT NULL PRIMARY KEY,
       NAME VARCHAR(100) NOT NULL,
       EMAIL VARCHAR(255) NOT NULL UNIQUE,
       COUNTRY VARCHAR(255) DEFAULT 'NA'
);       
       SELECT * FROM VENDOR;
       DESC VENDOR;
------------------------------------------------------------------------------------
-- Q-3

CREATE TABLE MOVIES(
	   MOVIE_ID INT UNSIGNED NOT NULL PRIMARY KEY,
       NAME VARCHAR(255) NOT NULL,
       RELEASE_YEAR VARCHAR(20) DEFAULT('-'),
       CAST VARCHAR(255) NOT NULL,
       GENDER ENUM('MALE','FEMALE') NOT NULL,
       NO_OF_SHOWS INT UNSIGNED CHECK(NO_OF_SHOWS>0)
);      
       INSERT INTO MOVIES(MOVIE_ID,NAME,CAST,GENDER,NO_OF_SHOWS) VALUES (1,'JAWAN','SRK','MALE',5);
       SELECT * FROM MOVIES;
       DESC MOVIES;
-------------------------------------------------------------------------------------
-- Q-4

CREATE TABLE SUPPLIERS(
	   SUPPLIERS_ID INT AUTO_INCREMENT PRIMARY KEY,
       SUPPLIER_NAME VARCHAR(255) NOT NULL,
       LOCATION VARCHAR(255)
);      

CREATE TABLE PRODUCT(
       PRODUCT_ID INT AUTO_INCREMENT PRIMARY KEY,
       PRODUCT_NAME VARCHAR(255) NOT NULL UNIQUE,
       DESCRIPTION TEXT,
       SUPPLIERS_ID INT,
       FOREIGN KEY (SUPPLIERS_ID) REFERENCES SUPPLIERS (SUPPLIERS_ID)
); 

CREATE TABLE STOCK(
	   ID INT AUTO_INCREMENT PRIMARY KEY,
       PRODUCT_ID INT,
       FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
       BALNACE_STOCK INT
); 
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
## DAY 7
------------------------------------------------------------------------------------------
-- Q-1

SELECT * FROM EMPLOYEES;
SELECT * FROM CUSTOMERS;  

SELECT
    e.employeeNumber AS employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS SalesPerson,
    COUNT(DISTINCT c.customerNumber) AS uniqueCustomers
FROM
    Employees e
LEFT JOIN
    Customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY
    e.employeeNumber, SalesPerson
ORDER BY
    uniqueCustomers DESC;
-----------------------------------------------------------------------------------------
-- Q-2

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM ORDERDETAILS;
SELECT * FROM PRODUCTS;

SELECT
    c.customerNumber AS CustomerNumber,
    c.customerName AS CustomerName,
    p.productCode AS ProductCode,
    p.productName AS ProductName,
    SUM(od.quantityOrdered) AS Ordered_Qty,
    IFNULL(p.quantityInStock, 0) AS Total_inventory,
    IFNULL(p.quantityInStock - SUM(od.quantityOrdered), 0) AS Left_Qty
FROM
    Customers c
JOIN
    Orders o ON c.customerNumber = o.customerNumber
JOIN
    OrderDetails od ON o.orderNumber = od.orderNumber
JOIN
    Products p ON od.productCode = p.productCode
LEFT JOIN
    products s ON p.productCode = s.productCode
GROUP BY
    c.customerNumber, p.productCode
ORDER BY
    c.customerNumber;    
------------------------------------------------------------------------------------------
-- Q-3

CREATE TABLE LAPTOP(
	   LAPTOP_NAME VARCHAR(255) NOT NULL
);

CREATE TABLE COLOUR(
	   COLOUR_NAME VARCHAR(255) NOT NULL
);       

INSERT INTO laptop(laptop_name) VALUES ('DELL'),('HP'),('DELL'),('HP'),('DELL'),('HP');
INSERT INTO colour(colour_name) VALUES ('BLACK'),('SILVER'),('WHITE'),('BLACK'),('SILVER'),('WHITE');

SELECT * FROM LAPTOP;
SELECT * FROM COLOUR;

SELECT 
     l.laptop_name,
     c.colour_name
FROM
    colour c
CROSS JOIN
     laptop l;

     
-----------------------------------------------------------------------------------------------
-- Q-4

CREATE TABLE PROJECT(
       EmployeeID INT UNSIGNED,
       FullName VARCHAR(255),
       Gender VARCHAR(10),
       ManagerID INT UNSIGNED
);       

INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

SELECT * FROM PROJECT;

SELECT
    p1.FullName AS "Manager Name",
    p2.FullName AS "Emp Name"
FROM
    Project p1
JOIN
    Project p2 ON p1.EmployeeID = p2.ManagerID;
    
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
## DAY 8
-----------------------------------------------------------------------------------------
-- Q-1

CREATE TABLE FACILITY(
       Facility_ID INT UNSIGNED NOT NULL,
       Name VARCHAR(100),
       State VARCHAR(100),
       Country VARCHAR(100)
);       

ALTER TABLE facility MODIFY COLUMN Facility_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE facility ADD COLUMN City VARCHAR(100) NOT NULL AFTER Name;

DESC FACILITY;
-----------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
## DAY 9
-----------------------------------------------------------------------------------------------

CREATE TABLE UNIVERSITY(
       ID INT UNSIGNED PRIMARY KEY,
       NAME VARCHAR(100)
);       

INSERT INTO University
VALUES (1, "       Pune          University     "), 
               (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");

SELECT * FROM UNIVERSITY;

set sql_safe_updates=0;
set sql_safe_updates=1;

UPDATE university SET Name = TRIM(REGEXP_REPLACE(Name,'[[:SPACE:]]+', ' '));


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
## DAY 10
-----------------------------------------------------------------------------------------------
CREATE VIEW products_status AS
SELECT
    YEAR(o.orderDate) AS Year,
    CONCAT(
        count(od.priceEach),
        ' (',
        ROUND((SUM(od.priceEach * od.quantityOrdered) / (SELECT SUM(od2.priceEach * od2.quantityOrdered) 
        FROM OrderDetails od2)) * 100),
        '%)'
    ) AS Value
FROM
    Orders o
JOIN
    OrderDetails od ON o.orderNumber = od.orderNumber
GROUP BY
    Year
ORDER BY
  Value desc;

SELECT * FROM PRODUCTS_STATUS;

SELECT * FROM ORDERDETAILS;
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
## DAY 11
-----------------------------------------------------------------------------------------------------------
-- Q-1

select * from customers;
drop procedure GetCustomerLevel;
DELIMITER //

CREATE PROCEDURE GetCustomerLevel(IN CN INT, OUT CL VARCHAR(10))
BEGIN
    DECLARE credit DECIMAL(10, 2);

    SELECT creditLimit INTO credit FROM Customers WHERE customerNumber = CN;

    IF credit > 100000 THEN
        SET CL = 'Platinum';
    ELSEIF credit between 25000 and 100000 THEN
        SET CL = 'Gold';
    ELSE
        SET CL = 'Silver';
    END IF;
END //

DELIMITER ;

CALL GetCustomerLevel(110,@CL);
CALL GetCustomerLevel(129,@CL);
SELECT @CL AS "Customer Level";
-----------------------------------------------------------------------------------------------------------
-- Q-2

DELIMITER //

CREATE PROCEDURE Get_country_payments(IN inputYear INT, IN inputCountry VARCHAR(255))
BEGIN
    SELECT
        YEAR(p.paymentDate) AS Year,
        c.country AS Country,
        CONCAT(FORMAT(SUM(p.amount)/1000, 0), 'K') AS 'Total Amount'
    FROM
        Payments p
    JOIN
        Customers c ON p.customerNumber = c.customerNumber
    WHERE
        YEAR(p.paymentDate) = inputYear AND c.country = inputCountry
    GROUP BY
        Year, Country;
END //

DELIMITER ;

CALL Get_country_payments(2003, 'France');
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
## DAY 12
---------------------------------------------------------------------------------------------------------
-- Q-1 (PENDING)

SELECT * FROM ORDERS;

SELECT YEAR(OrderDate) AS YEAR,
       MONTHNAME(OrderDate) AS MONTH,
       COUNT(OrderNumber) AS TOTAL_ORDERS,
       CONCAT(ROUND((COUNT(OrderNumber)-LAG(COUNT(OrderNumber)) OVER(ORDER BY YEAR(OrderDate)))/
       LAG(COUNT(OrderNumber)) OVER(ORDER BY YEAR(OrderDate))*100),'%') AS YOY
       FROM ORDERS
GROUP BY YEAR(OrderDate),MONTHNAME(OrderDate);       
--------------------------------------------------------------------------------------------------------
-- Q-2

CREATE TABLE EMP_UDF(
	   EMP_ID INT UNSIGNED auto_increment PRIMARY KEY,
       NAME VARCHAR(255),
       DOB DATE
);       

SELECT * FROM EMP_UDF;
DESC EMP_UDF;

INSERT INTO Emp_UDF(Name, DOB) VALUES 
("Piyush", "1990-03-30"), 
("Aman", "1992-08-15"), 
("Meena", "1998-07-28"), 
("Ketan", "2000-11-21"), 
("Sanjay", "1995-05-21");

DELIMITER //

CREATE FUNCTION calculate_age(date_of_birth DATE)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE years INT;
    DECLARE months INT;
    DECLARE age VARCHAR(50);

    SET years = TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE());
    SET months = TIMESTAMPDIFF(MONTH, date_of_birth, CURDATE()) % 12;

    IF years = 0 THEN
        SET age = CONCAT(months, ' months');
    ELSEIF months = 0 THEN
        SET age = CONCAT(years, ' years');
    ELSE
        SET age = CONCAT(years, ' years ', months, ' months');
    END IF;

    RETURN age;
END //

DELIMITER ;

SELECT Emp_ID,Name, DOB, calculate_age(DOB) AS Age FROM emp_udf;


------------------------------------------------------------------------------------------------------------
## DAY 13
------------------------------------------------------------------------------------------------------------
-- Q-1

SELECT * FROM ORDERS;
SELECT * FROM CUSTOMERS;

SELECT CustomerNumber, CustomerName
FROM Customers
WHERE CustomerNumber NOT IN (SELECT CustomerNumber FROM Orders);
-------------------------------------------------------------------------------------------------------------
-- Q-2

SELECT C.CustomerNumber, C.CustomerName, IFNULL(COUNT(O.OrderNumber), 0) AS TotalOrders
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerNumber = O.CustomerNumber
GROUP BY C.CustomerNumber, C.CustomerName
UNION
SELECT O.CustomerNumber, C.CustomerName, IFNULL(COUNT(O.OrderNumber), 0) AS TotalOrders
FROM Customers AS C
RIGHT JOIN Orders AS O ON C.CustomerNumber = O.CustomerNumber
GROUP BY O.CustomerNumber, C.CustomerName;
-------------------------------------------------------------------------------------------------------------
-- Q-3

SELECT * FROM ORDERDETAILS;
SELECT
    OrderNumber,
    MAX(QuantityOrdered) AS quantityOrdered
FROM
    Orderdetails AS od1
WHERE
    QuantityOrdered < (
        SELECT MAX(QuantityOrdered)
        FROM Orderdetails AS od2
        WHERE od1.OrderNumber = od2.OrderNumber
    )
GROUP BY OrderNumber;
------------------------------------------------------------------------------------------------------------
-- Q-4

SELECT * FROM ORDERDETAILS;

  SELECT
    MAX(ProductCount) AS "MAX(Total)",
    MIN(ProductCount) AS "MIN(Total)"
FROM (
    SELECT
        OrderNumber,
        COUNT(*) AS ProductCount
    FROM
        Orderdetails
    GROUP BY
        OrderNumber
) AS Counts;
-------------------------------------------------------------------------------------------------------------
-- Q-5

SELECT * FROM PRODUCTLINES;
SELECT * FROM PRODUCTS;

SELECT p.ProductLine,
    COUNT(*) AS Total
FROM
    Products AS p
JOIN (
    SELECT
        AVG(BuyPrice) AS AvgBuyPrice
    FROM
        Products
) AS avg_prices
ON p.BuyPrice > avg_prices.AvgBuyPrice
GROUP BY
    p.ProductLine
ORDER BY
    Total DESC;
-------------------------------------------------------------------------------------------------------------
## DAY 14
-------------------------------------------------------------------------------------------------------------
CREATE TABLE Emp_EH(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(255),
    EmailAddress VARCHAR(255)
);
SELECT * FROM EMP_EH;

-- Create the stored procedure for inserting values with exception handling
DELIMITER //

CREATE PROCEDURE InsertEmp_EH(
    IN p_EmpID INT,
    IN p_EmpName VARCHAR(255),
    IN p_EmailAddress VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred';
    END;

    START TRANSACTION;

    -- Insert the values into the Emp_EH table
    INSERT INTO Emp_EH (EmpID, EmpName, EmailAddress)
    VALUES (p_EmpID, p_EmpName, p_EmailAddress);
    
    SELECT * FROM EMP_EH;
    
    COMMIT;
END //

DELIMITER ;  

CALL INSERTEmp_EH(1,'ABC','ABC@GMAIL.COM');

-------------------------------------------------------------------------------------------------------------
## DAY 15
-------------------------------------------------------------------------------------------------------------
CREATE TABLE EMP_BIT(
       NAME VARCHAR(255),
       OCCUPATION VARCHAR(255),
       WORKING_DATE DATE,
       WORKING_HOURS INT
);       

SELECT * FROM EMP_BIT;

INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  

-- Create a before-insert trigger
DELIMITER //
CREATE TRIGGER EnsurePositiveWorkingHours
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = -NEW.Working_hours;
    END IF;
END //
DELIMITER ;

INSERT INTO Emp_BIT VALUES ('Robin', 'Scientist', '2020-10-04', -20);  
-------------------------------------------------------------------------------------------------------------
