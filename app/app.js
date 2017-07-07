var express = require('express');
var app = express();

/*
app.get('/hello', function (req, res) {
  res.send('[GET]Hello World...! from ' + require('os').hostname());
});

app.get('/p/:tagId', function(req, res) {
  res.send("tagId is set to " + req.params.tagId);
});
*/

app.get('/', function (req, res) {
  res.send('[GET]Hello World.!from ' + require('os').hostname());
});

app.post('/', function(req, res) {
    res.send('[POST]Hello World! from ' + require('os').hostname());
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
