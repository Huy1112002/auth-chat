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

const login = async (req, res) => {
    try {
        const { username, password } = req.body;
        if (!username || !password) {
            return res.status(400).sendFile(__dirname + "/login.html", {
                message: "Please Provide an user name and password"
            })
        }
        db.query('SELECT * FROM employee WHERE username = ?', [username], async (err, results) => {
            //console.log(res);
            if (!results || !await bcrypt.compare(password, results[0].password)) {
                res.status(401).sendFile(__dirname + "/login.html", {
                    message: 'Username or password is incorrect'
                })
            } else {
                const id = results[0].id;

                const token = jwt.sign({ id }, process.env.JWT_SECRET, {
                    expiresIn: process.env.JWT_EXPIRES_IN
                });

                const cookieOptions = {
                    expires: new Date(
                        Date.now() + process.env.JWT_COOKIE_EXPIRES * 24 * 60 * 60 * 1000
                    ),
                    httpOnly: true
                }
                res.cookie('userSave', token, cookieOptions);
                res.status(200).redirect("/home");
            }
        })
    } catch (err) {
        console.log(err);
    }
}
const register = async (req, res) => {
    const {username , password , name , role , status , email , phone_num} = req;

    db.query('SELECT username from employee WHERE username = ?', [username], async (err, results) => {
        if (err) {
            console.log(err);
        } else {
            if (results.length > 0) {
                return res.sendFile(__dirname + "/register.html", {
                    message: 'Username is already in use'
                })
            }
        }

        let hashedPassword = await bcrypt.hash(password, 8);

        db.query('INSERT INTO employee SET ?', {username : username, password : hashedPassword, name : name, role : role, status : status, email : email, phone_num : phone_num}, (err, results) => {
            if (err) {
                console.log(err);
            } else {
                return results.sendFile(__dirname + "/register.html", {
                    message: 'User registered'
                });
            }
        })
    })
    res.send("Form submitted");
}

const isLoggedIn = async (req, res, next) => {
    if (req.cookies.userSave) {
        try {
            const decoded = await promisify(jwt.verify)( req.cookies.userSave,
                process.env.JWT_SECRET
            );
            console.log(decoded);
            
            db.query('SELECT * FROM employee WHERE username = ?', [decoded.username], (err, results) => {
                if (!results) {
                    return next();
                }
                req.user = results[0];
                return next();
            });
        } catch (err) {
            console.log(err)
            return next();
        }
    } else {
        next();
    }
}

const logout = async (req, res) => {
    const decoded = await promisify(jwt.verify)(req.cookies.userSave,
        process.env.JWT_SECRET
    );
    db.query("UPDATE users SET socket_id = " + null + "FROM user_chat WHERE username = " + decoded.username);
    res.cookie('userSave', 'logout', {
        expires: new Date(Date.now() + 2 * 1000),
        httpOnly: true
    });
    res.status(200).redirect("/");
}

module.exports = {login, register, isLoggedIn, logout}