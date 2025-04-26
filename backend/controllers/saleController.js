const Sale = require('../models/Sale');
const Product = require('../models/Product');

// Registrar una venta
exports.createSale = async (req, res) => {
  try {
    const { productId, quantity } = req.body;
    const product = await Product.getById(productId);

    if (!product) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }

    if (product.stock < quantity) {
      return res.status(400).json({ error: 'Stock insuficiente' });
    }

    const total = product.price * quantity;
    const saleId = await Sale.create({ productId, quantity, total });

    // Reducir stock
    await Product.reduceStock(productId, quantity);

    res.status(201).json({ saleId, productId, quantity, total });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Obtener todas las ventas
exports.getSales = async (req, res) => {
  try {
    const sales = await Sale.getAll();
    res.json(sales);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Obtener estadísticas
exports.getStats = async (req, res) => {
  try {
    const stats = await Sale.getStats();
    res.json(stats);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};