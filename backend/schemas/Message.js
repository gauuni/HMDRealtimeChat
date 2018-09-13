var mongoose = require('mongoose');  
var MessageSchema = new mongoose.Schema({  
  senderId: String,
  recieverId: String,
  channelId: String,
  content: String,
});
mongoose.model('Message', MessageSchema);

module.exports = mongoose.model('Message');