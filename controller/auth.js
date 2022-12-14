const {login, register, isLoggedIn, logout} = require('../models/auth');

const Login = function(req, res){
    login(req, (err, data) => {
        res.send({result: data, error: err});
    });
};

const Register = function(req,res){
    register(req, (err,data) => {
        res.send({result: data, error: err});
    });
};

const IsLoggedIn = function(req,res){
    isLoggedIn(req, (err,data) => {
        res.send({result: data, error: err});
    });
};

const Logout = function(req,res){
    logout(req, (err,data) => {
        res.send({result: data, error: err});
    });
};

module.exports = {Login, Register, IsLoggedIn, Logout}
