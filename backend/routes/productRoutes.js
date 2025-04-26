const express = require('express');
const {
  getProducts,
  getProductById,
  createProduct,
  updateProduct,
  deleteProduct,
} = require('../controllers/productController');

const router = express.Router();

// CRUD de productos
router.get('/', getProducts);          // GET /api/products?name=&minPrice=&maxPrice=
router.get('/:id', getProductById);   // GET /api/products/1
router.post('/', createProduct);      // POST /api/products
router.put('/:id', updateProduct);    // PUT /api/products/1
router.delete('/:id', deleteProduct); // DELETE /api/products/1

module.exports = router;