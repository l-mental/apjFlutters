const pool = require('../config/database');

class Product {
  static async getAll() {
    const [rows] = await pool.query('SELECT * FROM products');
    return rows;
  }

  static async create(name, price, stock) {
    const [result] = await pool.query(
      'INSERT INTO products (name, price, stock) VALUES (?, ?, ?)',
      [name, price, stock]
    );
    return { id: result.insertId, name, price, stock };
  }
}

module.exports = Product;