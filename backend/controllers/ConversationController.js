var express = require('express');
var router = express.Router()
var bodyParser = require('body-parser')
router.use(bodyParser.urlencoded({ extended: false }))
router.use(bodyParser.json())
var User = require('../schemas/User')
var Utils = require('../utils')
var Channels = require('../socketChannels')
var uniqid = require('uniqid')

var userChannels = []
var users = []

module.exports = (app, io) => {

    // here is being used a socketio middleware to validate
    // the token that has been sent
    // and if the token is valid, then the io.on(connection, ..) statement below is executed
    // thus the socket is connected to the websocket server.
    // io.use(require('socketio-jwt').authorize({
    //     secret: "abc",
    //     handshake: true
    // }));

    // but if the token is not valid, an error is triggered to the client
    // the socket won't be connected to the websocket server.
    io.on('connection', function (socket) {

        socket.on(Channels.online, username => {
            users.push(username)
            console.log(username + " is active")
            io.emit(Channels.online, username)
        })

        socket.on(Channels.offline, username => {
            users.pop(username)
            console.log(username + " is leaving")
            io.emit(Channels.offline, username)
        })

    });


    router.get('/', (req, res) =>{

        Utils.sendResponseDataWith(res, 200, null, null)

    })
    
    router.post('/publish', (req, res) =>{
        var channelId = req.body.channelId
        var sender = req.body.sender
        var receiver = req.body.receiver
        var message = req.body.message
        io.emit(channelId, sender, receiver, message)
        Utils.sendResponseDataWith(res, 200, null, null)
    })

    router.post('/channels', (req, res)=>{
        var sender = req.body.sender
        var receiver = req.body.receiver
        var channelId = uniqid('socketio-')
        io.emit(Channels.channelGenerated, sender, receiver, channelId)
        Utils.sendResponseDataWith(res, 200, null, channelId)
    })

    router.get('/users', (req, res) =>{
        Utils.sendResponseDataWith(res, 200, null, [users])
    })

    app.use('/api/conversation', router)

    
}
