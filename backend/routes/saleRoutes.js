const express = require('express');
const {
  createSale,
  getSales,
  getStats,
} = require('../controllers/saleController');

const router = express.Router();

router.post('/', createSale);   // POST /api/sales
router.get('/', getSales);     // GET /api/sales
router.get('/stats', getStats); // GET /api/sales/stats

module.exports = router;