const express = require("express");
const path = require("path")
const http = require('http');
const sql = require('mysql');
const app = express();
const dotenv = require("dotenv").config();
const cookieParser = require("cookie-parser");
const server = http.createServer(app)
const { Server } = require('socket.io')
const io = new Server(server)
const cookieParserIo = require('socket.io-cookie-parser');
const { promisify } = require("util");
const jwt = require("jsonwebtoken");
const e = require("express");

process.env.PWD = process.cwd()

app.use(express.static(process.env.PWD + '/storage'));

io.use(cookieParserIo());

app.use(express.static("public"));
app.use(express.urlencoded({ extended: false }))
app.use(express.json());
app.use(cookieParser());
app.set('view engine', 'html');

const db = sql.createConnection({
    host: process.env.HOST,
    user: process.env.DATABASE_USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE
});

db.connect((err) => {
    if (err) {
        console.log(err);
    } else {
        console.log("MYSQL CONNECTED")
    }
})

app.use('/auth', require('./routes/auth'));
app.use('/chat', require('./routes/chat'));

io.on('connection', async (socket) => {
    uploader.dir = "./storage/";
    uploader.listen(socket);

    uploader.on("saved", function (event) {
        console.log(event.file.name);
    });

    const users = []

    console.log('a user connected');

    const decoded = await promisify(jwt.verify)(socket.request.cookies.userSave,
        process.env.JWT_SECRET
    );

    db.query("UPDATE user_chat SET socket_id = '" + socket.id + "' WHERE username = " + decoded.username);
    db.query("SELECT * FROM user_chat", function (err, result) {
        result.forEach(element => {
            users.push(element);
        });
        io.emit('load_users_list', users);
    });

    socket.on('joining room', data => {
        db.query("SELECT * FROM user_chat WHERE username = " + decoded.username, function (err, result) {
            socket.broadcast.emit('chat message', { message: result[0].name + " joined the chat", type: "join" })
            io.to(socket.id).emit('set_user_name', result[0].name);
        });
    });

    socket.on('chat message', data => {
        if(data.socket_id != null) io.to(data.socket_id).emit('chat message', { message: data.message, socket_id: socket.id});

        db.query("SELECT usename FROM users_id WHERE socket_id = " + data.socket_id, function (err, result) {
            db.query("INSERT INTO messages VALUES (" + decoded.username + ", " + result[0] + "," + data.message + + "," + data.time + ")");
        });
    });
});

server.listen(3000, '0.0.0.0', () => {
    console.log('listening on :3000');
});
