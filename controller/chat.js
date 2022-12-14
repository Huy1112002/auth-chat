const{getAllUser, getChatMessagesOfUser} = require('../model/chat.js');

const GetAllUser = function(req,res){
    getAllUser((err, data) => {
        res.send({result: data, error: err});
    });
}

const GetChatMessagesOfUser = function(req,res){
    getChatMessagesOfUser(req.body ,(err, data) => {
        res.send({result: data, error: err});
    });
}


module.exports = {GetAllUser, GetChatMessagesOfUser}