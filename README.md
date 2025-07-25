
# 💾 DBMS Mini Projects – SQL Based Systems

Welcome to my repository of two end-to-end DBMS mini projects. These are real-world SQL systems simulating e-commerce and warehouse operations, designed with relational integrity, procedures, triggers, and admin-level reporting.

---

## 📦 Projects Included

### 1. 🛍️ E-Commerce Management System  
A complete backend for an online retail platform that manages customers, orders, products, and payments.

### 2. 🏭 Warehouse Inventory Management System  
A multi-warehouse stock tracking system with low-stock alerts and inter-warehouse transfer features.

---

## 🔧 Technologies Used

- ✅ MySQL 8.0
- ✅ SQL Workbench / DBeaver
- ✅ SQL Views, Triggers, and Procedures
- ✅ ER Diagrams via dbdiagram.io

---

## 🛍️ Project 1: E-Commerce Management System

### 📌 Features

- Customer & Product Management
- Order & Payment Handling
- Sales Reporting via SQL View

### 📁 Files
- `E-com project.sql`: Full schema + sample data
- `E-com ER Diagram.png`: Visual schema (optional)

### 🧱 Tables

- `Customers(customer_id, name, email, phone)`
- `Products(product_id, name, price, stock)`
- `Orders(order_id, customer_id, status)`
- `OrderItems(order_item_id, order_id, product_id, quantity)`
- `Payments(payment_id, order_id, amount, method)`
- `SalesReport`: Admin analytics view

### ✅ Sample Flow

- John Doe places an order → Items added to OrderItems → Payment logged → Admin views via `SalesReport`.

---

## 🏭 Project 2: Warehouse Inventory Management System

### 📌 Features

- Multi-location stock tracking
- Stored procedure for stock transfer
- Trigger-based low stock alert system

### 📁 Files
- `warehouse project.sql`: Full schema + triggers + procedures
- `warehouse ER diagram.png`: Visual model (optional)

### 🧱 Tables

- `Suppliers(supplier_id, name, contact)`
- `Warehouses(warehouse_id, location)`
- `Products(product_id, supplier_id, price)`
- `Stock(product_id, warehouse_id, quantity)`
- `LowStockAlerts`: Auto-logged when quantity < 10

### 🔁 Stored Procedure

```sql
CALL TransferStock(fromWarehouseID, toWarehouseID, productID, transferQty);
