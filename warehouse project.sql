CREATE DATABASE inventory_db;
USE inventory_db;
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    ContactInfo VARCHAR(255)
);

CREATE TABLE Warehouses (
    WarehouseID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    UnitPrice DECIMAL(10, 2),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Stock (
    StockID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);
INSERT INTO Suppliers (Name, ContactInfo) VALUES
('ABC Supplies', 'abc@example.com'),
('XYZ Traders', 'xyz@example.com');

INSERT INTO Warehouses (Name, Location) VALUES
('Central Warehouse', 'Mumbai'),
('East Warehouse', 'Kolkata');

INSERT INTO Products (Name, Description, UnitPrice, SupplierID) VALUES
('Laptop', '14 inch, 8GB RAM', 45000, 1),
('Mouse', 'Wireless Mouse', 700, 2),
('Keyboard', 'Mechanical Keyboard', 2000, 2);

INSERT INTO Stock (ProductID, WarehouseID, Quantity) VALUES
(1, 1, 10),
(2, 1, 50),
(3, 2, 20),
(1, 2, 5);
SELECT 
    p.Name AS Product,
    w.Name AS Warehouse,
    s.Quantity
FROM 
    Stock s
JOIN Products p ON s.ProductID = p.ProductID
JOIN Warehouses w ON s.WarehouseID = w.WarehouseID;
DELIMITER $$

CREATE TRIGGER trg_low_stock
AFTER UPDATE ON Stock
FOR EACH ROW
BEGIN
    IF NEW.Quantity < 10 THEN
        INSERT INTO LowStockAlerts(ProductID, WarehouseID, Quantity, AlertDate)
        VALUES (NEW.ProductID, NEW.WarehouseID, NEW.Quantity, NOW());
    END IF;
END$$

DELIMITER ;

CREATE TABLE LowStockAlerts (
    AlertID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    Quantity INT,
    AlertDate DATETIME
);
DELIMITER $$

CREATE PROCEDURE TransferStock(
    IN fromWarehouseID INT,
    IN toWarehouseID INT,
    IN productID INT,
    IN transferQty INT
)
BEGIN
    UPDATE Stock
    SET Quantity = Quantity - transferQty
    WHERE WarehouseID = fromWarehouseID AND ProductID = productID;

    INSERT INTO Stock (ProductID, WarehouseID, Quantity)
    VALUES (productID, toWarehouseID, transferQty)
    ON DUPLICATE KEY UPDATE Quantity = Quantity + transferQty;
END$$

DELIMITER ;
CALL TransferStock(1, 2, 2, 5);
SELECT 
    p.Name AS Product,
    w.Name AS Warehouse,
    s.Quantity
FROM 
    Stock s
JOIN Products p ON s.ProductID = p.ProductID
JOIN Warehouses w ON s.WarehouseID = w.WarehouseID
WHERE s.Quantity < 10;





