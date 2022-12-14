const express = require("express");
const chatController = require("../controller/chat.js");

const router = express.Router();

router.get('/getAllUser', chatController.GetAllUser);
router.get('/getChatMessagesOfUser/:username', chatController.GetChatMessagesOfUser);

module.exports = router;