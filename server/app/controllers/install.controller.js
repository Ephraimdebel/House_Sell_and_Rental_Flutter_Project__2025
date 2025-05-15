const conn = require("../../config/db");
const fs = require("fs");

async function install(req,res) {
  const queryfile = __dirname + "/sql/schema.sql";
  let queries = [];
  let finalMessage = {};
  let templine = "";

  const lines = await fs.readFileSync(queryfile, "utf-8").split("\n");

  await new Promise((resolve) => {
    lines.forEach((line) => {
      if (line.trim().startsWith("--") || line.trim() === "") {
        return;
      }
      templine += line;
      if (line.trim().endsWith(";")) {
        const sqlQuery = templine.trim();
        queries.push(sqlQuery);
        templine = "";
      }
    });
    resolve("Queries added");
  });

  for (let i = 0; i < queries.length; i++) {
    try {
      const result = await conn.query(queries[i]);
      console.log(`✅ Query ${i + 1} executed successfully`);
    } catch (err) {
      console.error(`❌ Error in Query ${i + 1}: ${queries[i]}`);
      console.error("Error message:", err.message);
      finalMessage.message = "Not all tables were created successfully";
    }
  }

  if (!finalMessage.message) {
    finalMessage.message = "All tables created successfully";
    finalMessage.status = 200;
  } else {
    finalMessage.status = 500;
  }

  return res.json(finalMessage)
}

module.exports = { install };
