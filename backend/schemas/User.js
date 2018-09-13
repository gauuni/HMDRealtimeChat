var mongoose = require('mongoose');  
var UserSchema = new mongoose.Schema({  
  name: String,
  email: String,
  password: String,
  avatar: String,
  channels: Array,
  socketId: String
});
mongoose.model('User', UserSchema);

module.exports = mongoose.model('User');