const pool = require('../config/database');

class Product {
  // Obtener todos los productos (con filtros opcionales)
  static async getAll({ name = '', minPrice = 0, maxPrice = Infinity }) {
    const [rows] = await pool.query(
      `SELECT * FROM products 
       WHERE name LIKE ? AND price >= ? AND price <= ?`,
      [`%${name}%`, minPrice, maxPrice]
    );
    return rows;
  }

  // Obtener un producto por ID
  static async getById(id) {
    const [rows] = await pool.query('SELECT * FROM products WHERE id = ?', [id]);
    return rows[0];
  }

  // Crear un nuevo producto
  static async create({ name, price, stock }) {
    const [result] = await pool.query(
      'INSERT INTO products (name, price, stock) VALUES (?, ?, ?)',
      [name, price, stock]
    );
    return { id: result.insertId, name, price, stock };
  }

  // Actualizar un producto
  static async update(id, { name, price, stock }) {
    await pool.query(
      'UPDATE products SET name = ?, price = ?, stock = ? WHERE id = ?',
      [name, price, stock, id]
    );
    return { id, name, price, stock };
  }

  // Eliminar un producto
  static async delete(id) {
    await pool.query('DELETE FROM products WHERE id = ?', [id]);
    return { id };
  }

  // Reducir stock al vender
  static async reduceStock(id, quantity) {
    await pool.query(
      'UPDATE products SET stock = stock - ? WHERE id = ?',
      [quantity, id]
    );
  }
}

module.exports = Product;