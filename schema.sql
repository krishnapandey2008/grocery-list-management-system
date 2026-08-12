-- Create Database
CREATE DATABASE IF NOT EXISTS grocery_db2;
USE grocery_db2;

-- ============================
-- Table: customers
-- ============================
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================
-- Table: admins
-- ============================
CREATE TABLE IF NOT EXISTS admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================
-- Table: categories
-- ============================
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- ============================
-- Table: products
-- ============================
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    sku VARCHAR(100) UNIQUE,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    mrp DECIMAL(10,2),
    total_quantity INT DEFAULT 0,
    available_quantity INT DEFAULT 0,
    unit VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ============================
-- Table: orders
-- ============================
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'placed',
    total_amount DECIMAL(10,2),
    payment_id INT,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================
-- Table: order_items
-- ============================
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================
-- Table: payments
-- ============================
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_mode VARCHAR(50),
    status VARCHAR(20),

    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- ============================
-- Table: inventory_logs
-- ============================
CREATE TABLE IF NOT EXISTS inventory_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    change_value INT,
    reason VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);






INSERT INTO customers (name, email, phone, address, password) VALUES
('Aman Panwar', 'aman@example.com', '9876500011', 'Noida', 'pass123'),
('Vaibhav Jayant', 'vaibhav@example.com', '9876500022', 'Delhi', 'pass123'),
('Krishna Pandey', 'krishna@example.com', '9876500033', 'Noida', 'pass123'),
('Riya Sharma', 'riya@gmail.com', '9988776655', 'Gurgaon', 'pass123'),
('Arjun Verma', 'arjunv@gmail.com', '8877665544', 'Mumbai', 'pass123'),
('Sneha Kapoor', 'sneha.k@gmail.com', '7788996655', 'Pune', 'pass123'),
('Neeraj Singh', 'neeraj.s@gmail.com', '9090909090', 'Lucknow', 'pass123'),
('Palak Gupta', 'palak.g@gmail.com', '9099887766', 'Ghaziabad', 'pass123'),
('Kabir Mehta', 'kabir.mehta@gmail.com', '8585858585', 'Chennai', 'pass123'),
('Aisha Khan', 'aisha.khan@gmail.com', '9696969696', 'Bangalore', 'pass123');


INSERT INTO admins (username, password, name)
VALUES
('admin1', 'admin123', 'Store Manager'),
('admin2', 'admin123', 'Branch Manager');



INSERT INTO categories (name, description) VALUES
('Grains', 'Wheat, rice, pulses'),
('Dairy', 'Milk, curd, cheese'),
('Snacks', 'Chips, biscuits, chocolates'),
('Bakery', 'Bread, buns, cakes'),
('Vegetables', 'Fresh vegetables'),
('Fruits', 'Seasonal fruits'),
('Beverages', 'Juices, soft drinks'),
('Household', 'Daily household essentials');



INSERT INTO products 
(name, sku, category_id, price, mrp, total_quantity, available_quantity, unit)
VALUES
('Basmati Rice 5kg', 'SKU-RICE-5', 1, 350, 400, 60, 60, 'kg'),
('Wheat Flour 10kg', 'SKU-WHEAT-10', 1, 480, 520, 50, 50, 'kg'),
('Toor Dal 1kg', 'SKU-DAL-1', 1, 120, 140, 80, 80, 'kg'),
('Whole Milk 1L', 'SKU-MILK-1L', 2, 60, 70, 100, 100, 'L'),
('Curd 500g', 'SKU-CURD-500', 2, 40, 50, 90, 90, 'g'),
('Cheese Pack 200g', 'SKU-CHEESE-200', 2, 120, 150, 40, 40, 'g'),
('Potato Chips 100g', 'SKU-CHIPS-100', 3, 30, 40, 200, 200, 'pcs'),
('Chocolate Biscuit 250g', 'SKU-BIS-250', 3, 50, 60, 150, 150, 'pcs'),
('Salted Butter 100g', 'SKU-BUT-100', 4, 55, 65, 75, 75, 'g'),
('Brown Bread 400g', 'SKU-BREAD-400', 4, 35, 45, 60, 60, 'g'),
('Potato 1kg', 'SKU-VEG-POT', 5, 25, 30, 300, 300, 'kg'),
('Tomato 1kg', 'SKU-VEG-TOM', 5, 35, 45, 250, 250, 'kg'),
('Banana Dozen', 'SKU-FRU-BAN', 6, 40, 50, 100, 100, 'pcs'),
('Apple 1kg', 'SKU-FRU-APP', 6, 120, 150, 80, 80, 'kg'),
('Orange Juice 1L', 'SKU-JUICE-1L', 7, 90, 110, 60, 60, 'L'),
('Coca-Cola 1.25L', 'SKU-COKE-125', 7, 75, 90, 100, 100, 'L'),
('Dishwashing Liquid 500ml', 'SKU-DISH-500', 8, 60, 80, 40, 40, 'ml'),
('Detergent Powder 1kg', 'SKU-DET-1', 8, 110, 140, 70, 70, 'kg'),
('Toilet Cleaner 500ml', 'SKU-TCLEAN-500', 8, 85, 100, 50, 50, 'ml'),
('Garbage Bags Pack of 20', 'SKU-GBAG-20', 8, 65, 80, 120, 120, 'pcs');



INSERT INTO orders (customer_id, status, total_amount)
VALUES
(1, 'paid', 460),
(2, 'paid', 150),
(3, 'placed', 80),
(4, 'paid', 300),
(5, 'placed', 120);



INSERT INTO order_items (order_id, product_id, quantity, price, subtotal)
VALUES
(1, 1, 1, 350, 350),
(1, 7, 2, 30, 60),
(1, 4, 1, 60, 60),

(2, 8, 2, 50, 100),
(2, 12, 1, 35, 35),

(3, 10, 2, 35, 70),

(4, 15, 2, 90, 180),
(4, 13, 1, 40, 40),
(4, 3, 1, 120, 120),

(5, 11, 2, 25, 50),
(5, 14, 1, 120, 120);



INSERT INTO payments (order_id, amount, payment_mode, status)
VALUES
(1, 460, 'UPI', 'success'),
(2, 150, 'CARD', 'success'),
(4, 300, 'CASH', 'success');


INSERT INTO inventory_logs (product_id, change_value, reason)
VALUES
(1, -1, 'order'),
(7, -2, 'order'),
(4, -1, 'order'),

(8, -2, 'order'),
(12, -1, 'order'),

(10, -2, 'order'),

(15, -2, 'order'),
(13, -1, 'order'),
(3, -1, 'order');

