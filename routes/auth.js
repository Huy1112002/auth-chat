const express = require("express");
const authController = require("../controller/auth.js");

const router = express.Router();

router.post('/register', authController.Register)
router.post('/login', authController.Login);
router.get('/logout', authController.Logout);

module.exports = router;