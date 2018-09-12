var http = require('http')
var express = require('express')
var app = express()
var db = require('./db')

var httpServer = http.createServer(app)
var io = require('socket.io').listen(httpServer)

var conversationController = require('./controllers/ConversationController')(app, io)


var authController = require('./controllers/AuthController')
app.use('/api/auth', authController)


module.exports = httpServer;


