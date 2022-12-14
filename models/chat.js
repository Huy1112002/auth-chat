const mysql = require("mysql");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const { promisify } = require("util");

const db = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.DATABASE_USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE
});

const getAllUser = async(result) => {
    var pool = await db
    var sqlString = "SELECT * FROM user_chat";
    return await pool.request()
    .query(sqlString, function(err, data){
        if(data.recordset.length > 0){
            result(null, data.recordset)
        }else{
            result(err, null)
        }
    });
}

const getChatMessagesOfUser = async(username ,result) => {
    var pool = await db
    var sqlString = 'SELECT * FROM messages WHERE src_user = @username OR des_user = @username';
    return await pool.request()
    .input('username', sql.varchar(50), username)
    .query(sqlString, function(err, data){
        if(data.recordset.length > 0){
            result(null, data.recordset)
        }else{
            result(err, null)
        }
    });
}

module.exports = {getAllUser, getChatMessagesOfUser}
