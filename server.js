var http = require("http");
var fs = require('fs');
var port = 8080;
var serverUrl = "0.0.0.0";
var counter = 0;

var server = http.createServer(function(req, res) {

  counter++;
  console.log("Request: " + req.url + " (" + counter + ")");

  if(req.url == "/sample.html") {

    fs.readFile("sample.html", function(err, text){
      res.setHeader("Content-Type", "text/html");
      res.end(text);
    });
    return;

  }

  res.setHeader("Content-Type", "text/html");
  res.end("<p>Test task for Chumachenko Volodymyr (PDFfiller) 07/29/2021.    Request counter: " + counter + ".</p>");

});

console.log("Starting web server at " + serverUrl + ":" + port);
server.listen(port, serverUrl);

