const Product = require('../models/Product');

exports.getProducts = async (req, res) => {
  try {
    const products = await Product.getAll();
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addProduct = async (req, res) => {
  try {
    const { name, price, stock } = req.body;
    if (!name || price === undefined || stock === undefined) {
      return res.status(400).json({ error: "Faltan campos obligatorios" });
    }
    const product = await Product.create(name, price, stock);
    res.status(201).json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};