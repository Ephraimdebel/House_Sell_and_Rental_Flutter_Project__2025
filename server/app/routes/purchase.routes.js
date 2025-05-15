const express = require('express');
const router = express.Router();
const { createPurchase, getBuyerPurchases, getListingPurchases ,updatePurchaseStatus, getHostPurchases} = require('../controllers/perchase.controller');
const authMiddleware = require('../middlewares/auth_middle_ware');

// Create a new purchase

// Update purchase status

// Get all purchases made by the logged-in buyer
router.get('/purchases/buyer', getBuyerPurchases);

// Get all purchases for a specific listing
router.get('/purchases/listing/:listing_id', getListingPurchases);




router.patch('/purchases/:purchase_id',authMiddleware, updatePurchaseStatus);
router.post('/purchases/:listing_id', authMiddleware, createPurchase);
router.get('/purchases/host',authMiddleware, getHostPurchases);

module.exports = router;
