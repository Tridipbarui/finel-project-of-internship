CREATE DATABASE IF NOT EXISTS CUSTOMER;
USE CUSTOMER;
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_order DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Completed',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901');

INSERT INTO Products (name, description, price, stock_quantity) VALUES
('Laptop', '15 inch gaming laptop', 1500.00, 10),
('Smartphone', 'Latest model smartphone', 800.00, 25),
('Headphones', 'Noise cancelling headphones', 200.00, 50);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, NOW(), 'Processing'),
(2, NOW(), 'Shipped');

INSERT INTO OrderItems (order_id, product_id, quantity, price_at_order) VALUES
(1, 1, 1, 1500.00),
(1, 3, 2, 200.00),
(2, 2, 1, 800.00);

INSERT INTO Payments (order_id, payment_date, amount, payment_method, status) VALUES
(1, NOW(), 1900.00, 'Credit Card', 'Completed'),
(2, NOW(), 800.00, 'PayPal', 'Completed');

CREATE VIEW SalesReport AS
SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    p.name AS product_name,
    oi.quantity,
    oi.price_at_order,
    (oi.quantity * oi.price_at_order) AS total_price,
    pay.payment_method,
    pay.status AS payment_status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
ORDER BY o.order_date DESC
LIMIT 100;