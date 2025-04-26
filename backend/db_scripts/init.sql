CREATE DATABASE sales_app;

USE sales_app;

-- Tabla de productos
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL DEFAULT 0
);

-- Tabla de ventas
CREATE TABLE sales (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  total DECIMAL(10, 2) NOT NULL,
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insertar datos de ejemplo
INSERT INTO products (name, price, stock) VALUES
  ('Laptop HP', 1200.00, 15),
  ('Mouse Logitech', 25.50, 30),
  ('Teclado Mecánico', 80.00, 20);