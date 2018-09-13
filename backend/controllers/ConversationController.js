var express = require('express');
var router = express.Router()
var bodyParser = require('body-parser')
router.use(bodyParser.urlencoded({ extended: false }))
router.use(bodyParser.json())
var User = require('../schemas/User')
var Channel = require('../schemas/Channel')
var Message = require('../schemas/Message')
var Utils = require('../utils')
var config = require('../config')
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

        socket.on(config.channelOnline, userId => {
            User.findById(userId, (err, user) =>{
                if (user){
                    user.set({socketId: socket.id})
                    user.save()
                    console.log(user.name + "-" + socket.id + " is active")
                    io.emit(config.channelOnline, user)
                }
            })
        })

        socket.on('disconnect', () =>{

            User.findOne({socketId: socket.id}, (err, user) =>{
                if (user){
                    user.set({socketId: null})
                    user.save()
                    console.log(user.name + " is leaving")
                    io.emit(config.channelOffline, user)
                }
            })

            users.splice(users.indexOf(users), 1 );
        })

    });


    router.get('/', (req, res) =>{

        Utils.sendResponseDataWith(res, 200, null, null)

    })
    
    router.post('/publish', (req, res) =>{
        var channelId = req.body.channelId
        var senderId = req.body.sender
        var receiverId = req.body.receiver
        var content = req.body.content

        Message.create({
            senderId: senderId,
            recieverId: receiverId,
            channelId: channelId,
            content: content
        }, (err, message) =>{

            io.emit(receiverId, message)
            io.emit(channelId, message) 

        })

        Utils.sendResponseDataWith(res, 200, null, null)
       
    })

    router.post('/channels', (req, res)=>{
        var senderId = req.body.sender
        var receiverId = req.body.receiver

        // check if channel is exsisted
        Channel.findOne({users: [senderId, receiverId]}, (err, channel) =>{

            if (channel) { 
                User.update({ _id: senderId }, { $push: { channels: channel }}).exec();
                Utils.sendResponseDataWith(res, 200, null, channel.id)
                return
            }
        
            // create a new one
            Channel.create({
                users: [senderId, receiverId]
            }, (err, channel) =>{
                if (channel) {
                    User.update({ _id: senderId }, { $push: { channels: channel }}).exec();
                    Utils.sendResponseDataWith(res, 200, null, channel.id)
                }
            })

        })

        
        
    })

    router.post('/join', (req, res) =>{
        var channelId = req.body.channelId
        var userId = req.body.channelId

        User.findById(userId, (err, user)=>{
            if (user){
                var found = user.channels.some(el=>{
                    return el.id = channelId
                })

                if (!found){
                    Channel.findById(channelId, (err, channel) =>{
                        if (channel){
                            user.push({ channels: channel})
                        }
                    })
                }

            }
        })

        Utils.sendResponseDataWith(res, 200, null, null)
    })

    router.get('/users', (req, res) =>{
        
        User.find({socketId: {$ne : null}}, (err, users)=>{
            if (err){
                Utils.sendResponseDataWith(res, 500, null, err)
                return
            }

            Utils.sendResponseDataWith(res, 200, null, users)
        })

    })

    app.use('/api/conversation', router)

    
}
