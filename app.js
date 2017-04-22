#!/usr/bin/env node

var express = require('express')
var app = express()

/*
app.get('/', function (req, res) {
  res.send('Hello World!')
})
*/

app.use(express.static(__dirname + '/static'))

app.listen(3000, function () {
  console.log('Example app listening on http://localhost:3000')
})