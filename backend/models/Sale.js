const pool = require('../config/database');

class Sale {
  // Registrar una nueva venta
  static async create({ productId, quantity, total }) {
    const [result] = await pool.query(
      'INSERT INTO sales (product_id, quantity, total, date) VALUES (?, ?, ?, NOW())',
      [productId, quantity, total]
    );
    return result.insertId;
  }

  // Obtener todas las ventas
  static async getAll() {
    const [rows] = await pool.query(`
      SELECT s.*, p.name as product_name 
      FROM sales s
      JOIN products p ON s.product_id = p.id
    `);
    return rows;
  }

  // Obtener estadísticas de ventas
  static async getStats() {
    const [rows] = await pool.query(`
      SELECT 
        SUM(total) as total_sales,
        COUNT(*) as total_orders,
        p.name as best_selling_product
      FROM sales s
      JOIN products p ON s.product_id = p.id
      GROUP BY product_id
      ORDER BY SUM(quantity) DESC
      LIMIT 1
    `);
    return rows[0] || { total_sales: 0, total_orders: 0, best_selling_product: null };
  }
}

module.exports = Sale;