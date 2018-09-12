var app = require('./app')
var port = process.env.PORT || 5000
var cluster = require('cluster')
var numCPUs = require('os').cpus().length // Count the machine's CPUs


// Thanks to: https://rowanmanning.com/posts/node-cluster-and-express/

// // Code to run if we're in the master process
// if (cluster.isMaster){

//     // Create a worker for each CPU
//     for (var i = 0; i < numCPUs; i += 1) {
//         cluster.fork();
//     }

//     cluster.on('exit', (worker, code, signal) => {
//         console.log(`worker ${worker.process.pid} died`);
//       });

// }else{ // Code to run if we're in a worker process
    

    
    
// }

var server = app.listen(port, ()=>{
    console.log(" is running on port " + server.address().port)
})