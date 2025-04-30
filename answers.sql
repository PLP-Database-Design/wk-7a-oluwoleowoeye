-- Question 1: Transforming to 1NF
SELECT 
    OrderID,
    CustomerName,
    value AS Product
FROM 
    ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');
-- Question 2: Transforming to 2NF
-- First create Orders table
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Then create OrderProducts table with foreign key
CREATE TABLE OrderProducts_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Insert data
INSERT INTO Orders_2NF
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

INSERT INTO OrderProducts_2NF
SELECT OrderID, Product, Quantity FROM OrderDetails;