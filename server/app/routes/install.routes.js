const express = require("express");
const router = express.Router();
const { install} = require("../controllers/install.controller");


router.get("/install",install);

module.exports = router;