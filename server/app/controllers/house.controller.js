// const { query } = require("../../config/db");
const { StatusCodes } = require("http-status-codes");
const { BASE_URL } = require("../../config/index");


const dbConnection = require("../../config/db");

 const addHouse = async (req, res) => {
  console.log("add house step 1",req.body)
  try {
    const {
      category,
      type,
      streetAddress,
      city,
      province,
      country,
      bedroomCount,
      bathroomCount,
      title,
      description,
      price,
      area,
      facilities
    } = req.body;

    const categoryMap = {
      'House': 1,
      'Apartment': 2,
      'Condo': 3,
      'Townhouse': 4,
      'Villa': 5
    };
    
    const typeMap = {
      'For Sale': 1,
      'For Rent': 2
    };

    const categoryId = categoryMap[category] || null;
const typeId = typeMap[type] || null;
    const photos = req.files;
    const listingPhotos = photos;

    console.log("body ", req.body)
    
    // Check if files are uploaded
    if (!listingPhotos || listingPhotos.length === 0) {
      console.log("no image", )
      return res.status(400).json({ message: 'Please upload property photos' });
    }

    // Map photo paths to a valid URL
    const listingPhotoPaths = listingPhotos.map((file) => {
      const relativePath = file.path.replace(/\\/g, '/');
      return `${BASE_URL}/${relativePath}`;
    });

    const isAdmin = 1;
    console.log("photo ", listingPhotos)

    const query = `
      INSERT INTO Listings(creator_id, category_id, type_id, streetAddress, city, province, country, guestCount, bedroomCount, bathroomCount, listingPhotoPaths, title, description, price,area,facilities)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)
    `;

    const values = [
      1, // Creator ID (hardcoded for testing)
      categoryId,
      typeId,
      streetAddress,
      city,
      province,
      country,
      1,
      bedroomCount,
      bathroomCount,
      JSON.stringify(listingPhotoPaths),
      title,
      description,
      price,
      area,
      JSON.stringify(facilities)
    ];
    console.log("step 2",)

    // Execute the insert query
    const result = await dbConnection.query(query, values);
    console.log("step 4",result)

    // if (!req.user || !req.user.userid) {
    //   return res.status(400).json({ message: 'User not authenticated' });
    // }
    console.log("step 5")

    // const notificationQuery = `
    //   INSERT INTO notifications (user_id, message)
    //   VALUES (?, ?)
    // `;
    // const notificationValues = [
    //   req.user.userid,
    //   `Listing "${title}" created successfully`,
    // ];

    // await dbConnection.query(notificationQuery, notificationValues);

    res.status(200).json({
      message: 'Property created successfully',
      newListing: result,
    });
  } catch (err) {
    console.error('Error in creating listing:', err);
    res.status(500).json({ message: 'Error in creating listing', error: err.message });
  }
};




const editProperty = async (req, res) => {
  const listingId = req.params.id;

  try {
    const {
      category,
      type,
      streetAddress,
      city,
      province,
      country,
      guestCount,
      bedroomCount,
      bathroomCount,
      title,
      description,
      price,
      area,
      facilities
    } = req.body;

    // Map categories and types to IDs
    const categoryMap = {
      'House': 1,
      'Apartment': 2,
      'Condo': 3,
      'Townhouse': 4,
      'Villa': 5
    };

    const typeMap = {
      'Sale': 1,
      'Rent': 2
    };

    const categoryId = categoryMap[category] || null;
    const typeId = typeMap[type] || null;

    // Handle updated photo uploads if available
    let listingPhotoPaths = null;
    if (req.files && req.files.length > 0) {
      listingPhotoPaths = req.files.map(file => {
        const relativePath = file.path.replace(/\\/g, '/');
        return `${BASE_URL}/${relativePath}`;
      });
    }

    // Build the SET part of the query dynamically
    const fields = [];
    const values = [];

    if (categoryId) {
      fields.push('category_id = ?');
      values.push(categoryId);
    }
    if (typeId) {
      fields.push('type_id = ?');
      values.push(typeId);
    }
    if (streetAddress) {
      fields.push('streetAddress = ?');
      values.push(streetAddress);
    }
    if (city) {
      fields.push('city = ?');
      values.push(city);
    }
    if (province) {
      fields.push('province = ?');
      values.push(province);
    }
    if (country) {
      fields.push('country = ?');
      values.push(country);
    }
    if (guestCount) {
      fields.push('guestCount = ?');
      values.push(guestCount);
    }
    if (bedroomCount) {
      fields.push('bedroomCount = ?');
      values.push(bedroomCount);
    }
    if (bathroomCount) {
      fields.push('bathroomCount = ?');
      values.push(bathroomCount);
    }
    if (title) {
      fields.push('title = ?');
      values.push(title);
    }
    if (description) {
      fields.push('description = ?');
      values.push(description);
    }
    if (price) {
      fields.push('price = ?');
      values.push(price);
    }
    if (area) {
      fields.push('area = ?');
      values.push(area);
    }
    if (facilities) {
      fields.push('facilities = ?');
      values.push(JSON.stringify(facilities));
    }
    if (listingPhotoPaths) {
      fields.push('listingPhotoPaths = ?');
      values.push(JSON.stringify(listingPhotoPaths));
    }

    if (fields.length === 0) {
      return res.status(400).json({ message: 'No fields to update' });
    }

    const query = `UPDATE Listings SET ${fields.join(', ')}, updatedAt = CURRENT_TIMESTAMP WHERE id = ?`;
    values.push(listingId);

    const result = await dbConnection.query(query, values);

    res.status(200).json({
      message: 'Property updated successfully',
      updatedListing: result,
    });

  } catch (err) {
    console.error('Error in updating listing:', err);
    res.status(500).json({ message: 'Error updating listing', error: err.message });
  }
};


const getAllListings= async (req, res) => {
  console.log("Fetching all listings...");
  try {
    // Query to fetch all listings
    const query = `SELECT * FROM Listings`;

    // Execute the query
    const results = await dbConnection.query(query);

    // Return the results
    res.status(200).json({
      message: "All Listingsretrieved successfully",
      data: results, // Use results[0] if using mysql2's promise API
    });
  } catch (err) {
    console.error("Error fetching listings:", err);
    res.status(500).json({ message: "Error fetching listings", error: err.message });
  }
};


// const getAllListingsNew = async (req, res) => {
//   console.log("Fetching all listings...");
//   try {
//     // Query to fetch specific fields and join with Types and Categories tables
//     const query = `
//      SELECT 
//     l.id,
//     u.userName AS creator_name, -- Assuming 'name' is the column for the user's name in the Users table
//     l.title,
//     t.name AS type, -- Assuming 'name' is the column for type in the Types table
//     l.city,
//     l.createdAt,
//     c.name AS category -- Assuming 'name' is the column for category in the Categories table
// FROM listings l
// JOIN users u ON l.creator_id = u.id -- Join with Users table to get the creator's name
// JOIN types t ON l.type_id = t.id -- Join with Types table to get the type name
// JOIN categories c ON l.category_id = c.id -- Join with Categories table to get the category name

//     `;

//     // Execute the query
//     const results = await dbConnection.query(query);

//     // Return the results
//     res.status(200).json({
//       message: "All Listingsretrieved successfully",
//       data: results, // Use results[0] if using mysql2's promise API
//     });
//   } catch (err) {
//     console.error("Error fetching listings:", err);
//     res.status(500).json({ message: "Error fetching listings", error: err.message });
//   }
// };

async function getListingsByType(req, res) {
  try {
    const typeId = parseInt(req.query.type_id, 10);
    const page = req.query.page ? parseInt(req.query.page, 10) : null;
    const limit = req.query.limit ? parseInt(req.query.limit, 10) : null;
    const offset = page && limit ? (page - 1) * limit : null;

    // Validate type_id
    if (isNaN(typeId)) {
      return res.status(400).json({ error: 'Invalid type_id' });
    }

    console.log('Fetching listings by type...', { typeId, page, limit });

    let query = `SELECT * FROM Listings WHERE type_id = ?`;
    const params = [typeId];

    // Only add LIMIT and OFFSET if provided
    if (limit && offset !== null) {
      query += ` LIMIT ${parseInt(limit)} OFFSET ${parseInt(offset)}`;
      // params.push(limit, offset);
    }

    console.log('Executing query:', query, 'With parameters:', params);

    const results = await dbConnection.query(query, params);

    // Count total records regardless of pagination
    const countQuery = `SELECT COUNT(*) AS total FROM Listings WHERE type_id = ?`;
    const [{total} ] = await dbConnection.query(countQuery, [typeId]);

    console.log("total", total)
    const totalPages = limit ? Math.ceil(total / limit) : 1;

    return res.status(200).json({
      message: `Listings with type_id ${typeId} retrieved successfully`,
      data: results,
      currentPage: page || 1,
      totalPages,
      totalRecords: total,
    });
  } catch (error) {
    console.error('Error fetching listings by type:', error);
    return res.status(500).json({ error: 'Error fetching listings by type' });
  }
}






const getHouseDetails = async (req, res) => {
  try {
    const { id } = req.params;

    // Validate input
    if (!id || isNaN(id)) {
      return res.status(400).json({ message: "Invalid or missing house ID" });
    }

    // Query to fetch house details by ID
    const sqlQuery = `
      SELECT * 
      FROM Listings
      WHERE id = ?
    `;

    const houseDetails = await dbConnection.query(sqlQuery, [id]);

    if (houseDetails.length === 0) {
      return res.status(404).json({ message: "House not found" });
    }

    res.status(200).json({
      message: "House details retrieved successfully",
      data: houseDetails, // Return the first result since ID is unique
    });
  } catch (error) {
    console.error("Error retrieving house details:", error.message);
    res.status(500).json({
      message: "An error occurred while retrieving house details",
      error: error.message,
    });
  }
}


const getFavoriteListings = async (req, res) => {
  const userId = req.params.userId;

  try {
    const rows = await dbConnection.query(
      `SELECT Listings.* 
       FROM Favorites 
       JOIN Listings ON Favorites.listing_id = Listings.id 
       WHERE Favorites.user_id = ?`,
      [userId]
    );

    res.status(200).json({ favorites: rows });
  } catch (err) {
    console.error("Error fetching favorite listings:", err);
    res.status(500).json({ message: "Server error while fetching favorites" });
  }
};


const addFavorite = async (req, res) => {
  const { user_id, listing_id } = req.body;
  console.log(req.body)

  try {
    // 1. Check if the listing exists
    const listing = await dbConnection.query(
      "SELECT * FROM Listings WHERE id = ?",
      [listing_id]
    );

    if (listing.length === 0) {
      return res.status(404).json({ message: "Listing does not exist" });
    }

    // 2. Check if the favorite already exists
    const existing = await dbConnection.query(
      "SELECT * FROM Favorites WHERE user_id = ? AND listing_id = ?",
      [user_id, listing_id]
    );

    if (existing.length > 0) {
      return res.status(409).json({ message: "Already in favorites" });
    }

    // 3. Insert new favorite
    await dbConnection.query(
      "INSERT INTO Favorites (user_id, listing_id) VALUES (?, ?)",
      [user_id, listing_id]
    );

    res.status(201).json({ message: "Added to favorites" });
  } catch (err) {
    console.error("Error adding to favorites:", err.message);
    res.status(500).json({ message: "Server error", error: err.message });
  }
};


const removeFavorite = async (req, res) => {
  const { user_id, listing_id } = req.params; 

  try {
    // Check if the favorite exists
    const existing = await dbConnection.query(
      "SELECT * FROM Favorites WHERE user_id = ? AND listing_id = ?",
      [user_id, listing_id]
    );

    if (existing.length === 0) {
      return res.status(404).json({ message: "Favorite not found" });
    }

    // Remove the favorite
    await dbConnection.query(
      "DELETE FROM Favorites WHERE user_id = ? AND listing_id = ?",
      [user_id, listing_id]
    );

    res.status(200).json({
      "message": "Favorite removed successfully"
    }
    );
  } catch (err) {
    console.error("Error removing from favorites:", err);
    res.status(500).json({ "message": "Server error" });
  }
};


const getFilteredHouses = async (req, res) => {
  try {
    // Extract query parameters
    const { category, city, bathrooms, type, minPrice, maxPrice } = req.query;

    console.log('Received filters:', req.query); // Debug incoming query parameters

    // Base query
    let query = `SELECT * FROM Listings WHERE 1=1`;
    const queryParams = [];

    // Dynamically add filters
    if (category) {
      query += ` AND category_id = ?`;
      queryParams.push(category);
    }

    if (city) {
      query += ` AND LOWER(city) = LOWER(?)`; // Case-insensitive comparison
      queryParams.push(city.trim()); // Trim spaces from input
    }

    if (bathrooms) {
      query += ` AND bathroomCount >= ?`;
      queryParams.push(bathrooms);
    }

    if (type) {
      query += ` AND type_id = ?`;
      queryParams.push(type);
    }

    if (minPrice && maxPrice) {
      query += ` AND price BETWEEN ? AND ?`;
      queryParams.push(minPrice, maxPrice);
    } else if (minPrice) {
      query += ` AND price >= ?`;
      queryParams.push(minPrice);
    } else if (maxPrice) {
      query += ` AND price <= ?`;
      queryParams.push(maxPrice);
    }

    console.log('Generated Query:', query); // Debug the SQL query
    console.log('Query Parameters:', queryParams); // Debug query parameters

    // Execute query
    const filteredHouses = await dbConnection.query(query, queryParams);

    res.status(200).json({
      message: 'Filtered houses retrieved successfully',
      houses: filteredHouses,
    });
  } catch (error) {
    console.error('Error fetching filtered houses:', error.message);
    res.status(500).json({
      message: 'Error fetching filtered houses',
      error: error.message,
    });
  }
};


const deleteProperty = async (req, res) => {
  try {
    const { id } = req.params;

    // Validate input
    if (!id || isNaN(id)) {
      return res.status(400).json({ message: "Invalid or missing property ID" });
    }

    // Check if the property exists
    const checkQuery = `SELECT * FROM Listings WHERE id = ?`;
    const [property] = await dbConnection.query(checkQuery, [id]);

    if (property.length === 0) {
      return res.status(404).json({ message: "Property not found" });
    }

    // Delete related favorites first
    const deleteFavoritesQuery = `DELETE FROM Favorites WHERE listing_id = ?`;
    await dbConnection.query(deleteFavoritesQuery, [id]);

    // Then delete the property
    const deleteQuery = `DELETE FROM Listings WHERE id = ?`;
    await dbConnection.query(deleteQuery, [id]);

    res.status(200).json({ message: "Property and related favorites deleted successfully" });
  } catch (error) {
    console.error("Error deleting property:", error.message);
    res.status(500).json({
      message: "An error occurred while deleting the property",
      error: error.message,
    });
  }
};



const patchUpdateHouse = async (req, res) => {
  try {
    const listingId = req.params.id;

    if (!listingId) {
      return res.status(400).json({ message: 'Listing ID is required' });
    }

    const {
      category_id,
      type_id,
      streetAddress,
      city,
      province,
      country,
      bedroomCount,
      bathroomCount,
      title,
      description,
      price,
      area,
      facilities
    } = req.body;

    const categoryMap = {
      'House': 1,
      'Apartment': 2,
      'Condo': 3,
      'Townhouse': 4,
      'Villa': 5
    };

    const typeMap = {
      'For Sale': 1,
      'For Rent': 2
    };

    const fields = [];
    const values = [];

    // Conditionally build the update fields
    if (category_id) {
      fields.push('category_id = ?');
      values.push(category_id);
    }

    if (type_id) {
      fields.push('type_id = ?');
      values.push(type_id);
    }

    if (streetAddress) {
      fields.push('streetAddress = ?');
      values.push(streetAddress);
    }

    if (city) {
      fields.push('city = ?');
      values.push(city);
    }

    if (province) {
      fields.push('province = ?');
      values.push(province);
    }

    if (country) {
      fields.push('country = ?');
      values.push(country);
    }

    if (bedroomCount) {
      fields.push('bedroomCount = ?');
      values.push(bedroomCount);
    }

    if (bathroomCount) {
      fields.push('bathroomCount = ?');
      values.push(bathroomCount);
    }

    if (title) {
      fields.push('title = ?');
      values.push(title);
    }

    if (description) {
      fields.push('description = ?');
      values.push(description);
    }

    if (price) {
      fields.push('price = ?');
      values.push(price);
    }

    if (area) {
      fields.push('area = ?');
      values.push(area);
    }

    if (facilities) {
      fields.push('facilities = ?');
      values.push(JSON.stringify(facilities));
    }

    const listingPhotos = req.files;
    if (listingPhotos && listingPhotos.length > 0) {
      const listingPhotoPaths = listingPhotos.map((file) => {
        const relativePath = file.path.replace(/\\/g, '/');
        return `${BASE_URL}/${relativePath}`;
      });

      fields.push('listingPhotoPaths = ?');
      values.push(JSON.stringify(listingPhotoPaths));
    }

    // Always update updatedAt
    fields.push('updatedAt = CURRENT_TIMESTAMP');

    // If nothing to update
    if (fields.length === 1) {
      return res.status(400).json({ message: 'No valid fields provided to update' });
    }

    const updateQuery = `UPDATE Listings SET ${fields.join(', ')} WHERE id = ?`;
    values.push(listingId);

    const result = await dbConnection.query(updateQuery, values);

    res.status(200).json({
      message: 'Listing updated successfully',
      result
    });
  } catch (err) {
    console.error('Error updating listing:', err);
    res.status(500).json({ message: 'Error updating listing', error: err.message });
  }
};


module.exports = { addHouse,getHouseDetails,getListingsByType,getFilteredHouses,deleteProperty,getFavoriteListings,addFavorite,getAllListings,editProperty,patchUpdateHouse,removeFavorite};
