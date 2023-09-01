//create_database
CREATE DATABASE KUDSE202F009;

//use_database
USE KUDSE202F009;

//create_tables

CREATE TABLE Customer(
    CustomerID varchar(50)PRIMARY KEY NOT NULL, 
    CHECK(CustomerID='C%'),
    CName varchar(50) NOT NULL,
    CAddress varchar(50),
    CTelephone varchar(50));

CREATE TABLE Orders(
    OrderID varchar(50) NOT NULL PRIMARY KEY,
    CID varchar(50),
    FOREIGN KEY(CID) REFERENCES CUSTOMERS(CustomerID),
    Orderdate DEFAULT GETDATA(),
    Total decimal(10,2),
    CHECK(OrderID='O%'));

CREATE TABLE Supplier(
     SupplierID varchar(50) NOT NULL,
    SName varchar(50) NOT NULL,
    SAddress varchar(50) NOT NULL,
    STelePhone varchar(50),
    CHECK(SupplierID = 'S%'));

CREATE TABLE Product(
    ProdID varchar(50) PRIMARY KEY NOT NULL,
    Product_Name varchar(50) NOT NULL,
     Unit_Price decimal(10,2) NOT NULL,
    FOREIGN KEY(SupID) REFERENCES Supplier(SupplierID),
    CHECK(ProID='P%'));

CREATE TABLE OrderItem(
     RECID varchar(50) NOT NULL,
     OrderId varchar(50),
    ProductID varchar(50),
    Unit_Price decimal(10.2),
    Quantity int,
    PRIMARY KEY (RECID),
    FOREIGN KEY(OrderId) REFERENCES Orders(OrderID),
    FOREIGN KEY(ProductID) REFERENCES Product(ProdID),
    CHECK(RECID = 'R%'));

//insert_values

INSERT INTO Customer VALUES 
           ('C1','Amali','Colombo','0772569014'),
           ('C2','Asanka','Colombo','0715469875'),
           ('C3','Sunil','Kandy','0772548921'),
           ('C4','Kasun','Galle','0714589756'),
           ('C5','Pathum','Matara','0784589415');

    INSERT INTO Supplier VALUES 
           ('S1','Perera','Colombo','0712569014'),
           ('S2','Silva','Matara','0765469875'),
           ('S3','Ferenando','Jaffna','0782548921'),
           ('S4','Damika','Gampha','0774589756'),
           ('S5','Darshana','Gampola','0784589415');

    INSERT INTO Orders VALUES
            ('O1','C1',2019-08-16,8500.00),
            ('O2','C1',2019-08-16,9750.00),
            ('O3','C2',2019-08-16,1500.00),
            ('O4','C3',2019-08-16,27000.50),
            ('O5','C4',2019-08-16,48252.00);

    INSERT INTO Product VALUES
            ('P1','Milk Packet',35.00,'S1'),
            ('P2','Yoghurt',30.00,'S1'),
            ('P3','Oats',475.00,'S2'),
            ('P4','Corn Flex',890.00,'S3'),
            ('P5','Cheese',1200.00,'S2');

           INSERT INTO OrderItem VALUES 
            ('R1','O1','P1',35.00,100),
            ('R2','O1','P2',30.00,166),
            ('R3','O2','P2',30.00,100),
            ('R4','O2','P3',475.00,14),
            ('R5','O3','P1',35.00,43);


//select_(questions)
SELECT  *
     FROM Customer
     WHERE CAddress='Colombo' OR CAddress='Kandy';

SELECT CName,CAddress
      FROM Customer
      WHERE CName LIKE 'A%';

SELECT *
       FROM Customer
       WHERE CName LIKE 'S%' AND CAddress='Kandy';

SELECT *
        FROM Customer
        ORDER BY CName ASC;


SELECT OrderID
      FROM Orders
     WHERE Total>5000;

  SELECT OrderID
      FROM Orders
      WHERE Total BETWEEN 15000 AND 30000;
    
    SELECT Product_Name  
       FROM Product
       WHERE SupID='S1';

	SELECT COUNT(*)
       FROM customer;

   	SELECT COUNT(Total)
	FROM Orders;

   	SLECT AVG(Total)
	FROM Orders;

   	SELECT MIN(Total)
	FROM Orders;

   	SELECT SUM(Total)
	FROM Orders
	WHERE CID= 'C1';

   	SELECT MAX(Total)
	FROM Orders
	WHERE Orderdate= 2019;


SELECT Customer.CAddress,COUNT(*)
      FROM Customer
      GROUP BY Customer.CAddress;

    SELECT Customer.CustomerID,Cusotmer.CName,SUM(Orders.Total)
       FROM  Customer
       INNER JOIN Orders
       ON Customer.CustomerID=Orders.CID 
       GROUP BY Customer.CustomerID
       HAVING Orders.Total>10000;

    SELECT Customer.CustomerID,COUNT(OrderItem.OrderID)
      FROM ((Customer INNER JOIN Orders ON Customer.CustomerID=Orders.CID)
      INNER JOIN OrderItem ON Orders.OrderID=OrderItem.OrderID)
      GROUP BY Customer.CustomerID
      HAVING COUNT(OrderItem.OrderID)>1;


   SELECT Orders.CID,AVG(Orders.Total)
      FROM Orders 
     GROUP BY Orders.CID
     HAVING AVG(Orders.Total) BETWEEN 5000 AND 45000;

   


	UPDATE Customer 
	SET CAddress= ‘Galle’
	WHERE CID= ‘C1’;

  	UPDATE Product
        SET Unit_Price= Unit_Price+( Unit_Price*0.1);

	DELETE FROM OrderItem
	WHERE Quantity>100;

  	TRUNCATE TABLE Supplier;

	DROP TABLE Supplier;
