require("dotenv").config();
const express = require("express");
const path = require('path');

const app = express();
const port = process.env.PORT || 5500;
const cors = require("cors");
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

//user routes middleware
const userRoute = require("./app/routes/user.routes");
app.use("/api/users", userRoute);

// house routes middleware
const houseRoute = require("./app/routes/house.routes");
app.use("/api", houseRoute);

const installRoute = require("./app/routes/install.routes");
app.use("/api", installRoute);


app.use('/uploads', express.static(path.join(__dirname, '/uploads')));


app.listen(5500, '0.0.0.0', () => {
  console.log("Server running on http://localhost:5500");
});

