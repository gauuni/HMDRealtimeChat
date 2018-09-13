var mongoose = require('mongoose');  
var ChannelSchema = new mongoose.Schema({  
  name: String,
  image: String,
  users: Array,
  messages: Array
});
mongoose.model('Channel', ChannelSchema);

module.exports = mongoose.model('Channel');