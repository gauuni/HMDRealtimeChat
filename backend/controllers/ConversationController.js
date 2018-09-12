var express = require('express');
var router = express.Router()
var bodyParser = require('body-parser')
router.use(bodyParser.urlencoded({ extended: false }))
router.use(bodyParser.json())
var User = require('../schemas/User')
var Utils = require('../utils')
var Channels = require('../socketChannels')

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

        socket.on(Channels.connectUser, username => {

            console.log(username + " is online")
        })

        
    });


    router.get('/', (req, res) =>{

        Utils.sendResponseDataWith(res, 200, null, null)

    })
    
    router.post('/publish', (req, res) =>{
        var topic = req.body.topic
        var message = req.body.message
        io.emit(topic, message)
        Utils.sendResponseDataWith(res, 200, null, null)
    })


    app.use('/api/conversation', router)

    
}
