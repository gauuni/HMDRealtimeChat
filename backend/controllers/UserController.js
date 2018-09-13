var express = require('express');
var router = express.Router()
var bodyParser = require('body-parser')
router.use(bodyParser.urlencoded({ extended: false }))
router.use(bodyParser.json())
var User = require('../schemas/User')
var Utils = require('../utils')

router.get('/channels', (req, res) =>{
    var userId = req.query.id
    User.findById(userId, (err, user) =>{
        if (err){
            Utils.sendResponseDataWith(res, 501, null, err)
            return
        }

        if (user){
            Utils.sendResponseDataWith(res, 501, null, user.channel)
        }
        
    })
})

module.exports = router