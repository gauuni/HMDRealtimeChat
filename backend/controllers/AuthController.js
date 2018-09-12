var express = require('express');
var router = express.Router();
var bodyParser = require('body-parser');
router.use(bodyParser.urlencoded({ extended: false }));
router.use(bodyParser.json());
var User = require('../schemas/User');
var Utils = require('../utils');
var bcrypt = require('bcryptjs');

router.get('/', (req, res)=>{
    Utils.sendResponseDataWith(res,200,"success",null)
})

// register
router.post('/register', (req, res)=>{
    var hashedPassword = bcrypt.hashSync(req.body.password, 8)

    User.create({
        name: req.body.name,
        email: req.body.email,
        password: hashedPassword
    },

    (err, user)=>{
        if (err){
            return sendResponseDataWith(res, 500, "There was a problem registering the user")
        }
        // create a token
        var token = createToken(user._id)
        
        sendResponseDataWith(res, 200, null, {token: token})
    })
})

router.get('/me', (req, res, next)=>{
    var token = req.headers['x-access-token']
    if (!token){
        return Utils.sendResponseDataWith(res, 401, "No token provided.")
    }

    Utils.verifyToken(token, (err, decoded)=>{
        if (err){
            return Utils.sendResponseDataWith(res, 500, "Failed to authenticate token.")
        }

        //get user
        User.findById(decoded.id,
             {password:0},
             (err, user)=>{
            if (err){
                return Utils.sendResponseDataWith(res, 500, "There was a problem finding the user.")
            }

            if(!user){
                return Utils.sendResponseDataWith(res, 404, "No user found.")
            }

            Utils.sendResponseDataWith(res, 200, null, user)
            // next(user)
        })
    })
})

router.post("/login", (req, res)=>{
    User.findOne({email: req.body.email},
         (err, user)=>{
            if (err) {
                return Utils.sendResponseDataWith(res, 500, "Error on the server.")
            }

            if (!user){
                return sendResponseDataWith(res, 200, "Not found user with this email.")
            }

            // check valid password
            var passwordIsValid = bcrypt.compareSync(req.body.password, user.password)
            if (!passwordIsValid){
                return Utils.sendResponseDataWith(res, 401, "Wrong email or password.")
            }

            var token = Utils.createToken(user._id)
            Utils.sendResponseDataWith(res, 200, null, {token: token})
            
    })
})


module.exports = router