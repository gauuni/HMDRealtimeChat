var jwt = require('jsonwebtoken');
var config = require('./config');

exports.sendResponseDataWith = function(response, code, message, data){
    var status = code == 200 ? true : false
    var message = message
    if (!message) message = "Success"
    var responseData = {status: status, message: message, data: data } 
    response.status(code).send(responseData)
}

exports.createToken = function(id, interval=15*60){
    return jwt.sign({ id: id }, 
        config.secret,
        { expiresIn: interval})
}

exports.verifyToken = function(token, callback){
    jwt.verify(token, config.secret, callback)
}