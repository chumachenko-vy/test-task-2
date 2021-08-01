var express = require('express')
var fs = require('fs')
var morgan = require('morgan')
var path = require('path')

var app = express()

var counter = 0;

// log all requests to access.log
app.use(morgan(':method :url :status :res[content-length] - :response-time ms', {
  stream: fs.createWriteStream(path.join(__dirname, 'access.log'), { flags: 'a' })
}))

app.get('/', function (req, res) {
    counter++;
    console.log("Request: " + req.url + " (" + counter + ")");

    if(req.url == "/sample.html") {

      fs.readFile("sample.html", function(err, text){
        res.setHeader("Content-Type", "text/html");
        res.end(text)
      });
      return;
    }

    res.setHeader("Content-Type", "text/html");
    res.end("<p>Test task for Chumachenko Volodymyr 01/08/2021.    Request counter: " + counter + ".</p>");
   fs.appendFile('counter.log',+counter+'\n', () => {});
})

app.listen(parseInt(process.env.PORT) || 8080)
