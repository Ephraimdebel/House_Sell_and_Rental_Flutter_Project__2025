// Import the mysql2 module Promise Wrapper 
const mysql = require('mysql2/promise');
// Prepare connection parameters we use to connect to the database
const dbConfig = {
  connectionLimit: 10,
  password: process.env.DB_PASS,
  user:  process.env.DB_USER,
  host:  process.env.DB_HOST,
  database:  process.env.DB_NAME,
};

console.log('Database config:', dbConfig);

// Create the connection pool  
const pool = mysql.createPool(dbConfig);


// Prepare a function that will execute the SQL queries asynchronously
async function query(sql, params) {
  try {
    console.log('Executing query:', sql);
    console.log('With parameters:', params);
    const [rows, fields] = await pool.execute(sql, params);
    // console.log("fields",fields)
    return rows;
  } catch (err) {
    console.error('Error executing query:', err.message);
    throw err; // rethrow to be handled elsewhere if needed
  }
}

// Export the query function for use in the application 
module.exports = { query };
