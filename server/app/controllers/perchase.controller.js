const dbConnection = require("../../config/db");
const { v4: uuidv4 } = require('uuid');

const createPurchase = async (req, res) => {
  try {
      const { listing_id } = req.params;
      const {userid}  = req.user;// Listing ID from URL params
      const { amount, payment_gateway } = req.body;
      const transaction_reference = uuidv4();
      // Get the host_id from the Listings table based on the listing_id
      const listingQuery = "SELECT creator_id FROM Listings WHERE id = ?";
      const [listing] = await dbConnection.query(listingQuery, [listing_id]);

      if (!listing || listing.length === 0) {
          return res.status(404).json({ message: "Listing not found" });
      }

      const host_id = listing[0].creator_id;

      // Create the new purchase
      const insertPurchaseQuery = `
          INSERT INTO Purchases (buyer_id, listing_id, host_id, amount, transaction_reference, payment_gateway)
          VALUES (?, ?, ?, ?, ?, ?)
      `;
      const purchaseValues = [
        userid,
          listing_id,
          host_id,
          amount,
          transaction_reference,
          payment_gateway,
      ];
      const [purchaseResult] = await dbConnection.query(insertPurchaseQuery, purchaseValues);

      const newPurchaseId = purchaseResult.insertId;

      res.status(201).json({
          message: `Purchase created successfully for listing ID ${listing_id}`,
          purchase: {
              id: newPurchaseId,
              userid,
              listing_id,
              host_id,
              amount,
              transaction_reference,
              payment_gateway,
              status: 'pending', // You can default to 'pending'
          },
      });
  } catch (err) {
      res.status(500).json({ message: "Failed to create purchase", error: err.message });
  }
};


const getBuyerPurchases = async (req, res) => {
  try {
    const buyerId = req.user.userid;  // Assuming req.user contains the logged-in user's ID

    if (!buyerId) {
      return res.status(400).json({ message: "Buyer ID is required" });
    }

    // Query to fetch all purchases made by the buyer
    const query = `
      SELECT 
        p.id AS purchase_id,
        l.title AS listing_title,
        p.amount,
        p.status,
        p.payment_status,
        p.transaction_reference,
        p.purchase_date
      FROM Purchases p
      JOIN Listings l ON p.listing_id = l.id
      WHERE p.buyer_id = ?
      ORDER BY p.purchase_date DESC
    `;

    // Execute the query
    const [purchases] = await dbConnection.query(query, [buyerId]);

    // Return the purchases
    res.status(200).json({
      message: "Purchases retrieved successfully",
      data: purchases,
    });

  } catch (err) {
    console.error("Error fetching purchases:", err);
    res.status(500).json({ message: "Failed to fetch purchases", error: err.message });
  }
};


const getListingPurchases = async (req, res) => {
  try {
    const { listing_id } = req.params;

    // Query to fetch all purchases for a particular listing
    const query = `
      SELECT 
        p.id AS purchase_id,
        u.userName AS buyer_name,
        p.amount,
        p.status,
        p.payment_status,
        p.transaction_reference,
        p.purchase_date
      FROM Purchases p
      JOIN Users u ON p.buyer_id = u.id
      WHERE p.listing_id = ?
      ORDER BY p.purchase_date DESC
    `;

    // Execute the query
    const [purchases] = await dbConnection.query(query, [listing_id]);

    // Return the purchases
    res.status(200).json({
      message: "Purchases retrieved successfully for this listing",
      data: purchases,
    });

  } catch (err) {
    console.error("Error fetching listing purchases:", err);
    res.status(500).json({ message: "Failed to fetch listing purchases", error: err.message });
  }
};

const updatePurchaseStatus = async (req, res) => {
  try {
      const { purchase_id } = req.params;  // Purchase ID from URL params
      const { status, payment_status } = req.body;  // Status and payment status from the request body

      // Validate status and payment status
      const validStatuses = ["pending", "completed", "cancelled", "refunded"];
      const validPaymentStatuses = ["pending", "success", "failed"];

      if (!validStatuses.includes(status)) {
          return res.status(400).json({ message: "Invalid purchase status value" });
      }

      if (!validPaymentStatuses.includes(payment_status)) {
          return res.status(400).json({ message: "Invalid payment status value" });
      }

      // Update purchase status in the database
      const updateQuery = `
          UPDATE Purchases
          SET status = ?, payment_status = ?
          WHERE id = ?
      `;
      const [result] = await dbConnection.query(updateQuery, [status, payment_status, purchase_id]);

      if (result.affectedRows === 0) {
          return res.status(404).json({ message: "Purchase not found" });
      }

      res.status(200).json({
          message: `Purchase status updated to '${status}' and payment status updated to '${payment_status}' successfully`,
      });
  } catch (err) {
      res.status(500).json({ message: "Failed to update purchase status", error: err.message });
  }
};



const getHostPurchases = async (req, res) => {
  try {
    const hostId = req.user.userid; // Assuming req.user contains the logged-in host's ID

    if (!hostId) {
      return res.status(400).json({ message: "Host ID is required" });
    }

    // Query to fetch purchases for the host
    const query = `
      SELECT 
        p.id AS purchase_id,
        u.userName AS buyer_name,
        l.title AS listing_title,
        p.amount,
        p.status AS purchase_status,
        p.payment_status,
        p.transaction_reference,
        p.purchase_date
      FROM Purchases p
      JOIN Users u ON p.buyer_id = u.id
      JOIN Listings l ON p.listing_id = l.id
      WHERE p.host_id = ?
      ORDER BY p.purchase_date DESC
    `;

    // Execute the query
    const [purchases] = await dbConnection.query(query, [hostId]);

    // Return the purchases
    res.status(200).json({
      message: "Purchases retrieved successfully",
      data: purchases,
    });
  } catch (err) {
    console.error("Error fetching purchases:", err);
    res.status(500).json({ message: "Failed to fetch purchases", error: err.message });
  }
};
module.exports = {
  createPurchase,
  updatePurchaseStatus,
  getBuyerPurchases,
  getListingPurchases,
  getHostPurchases
};
