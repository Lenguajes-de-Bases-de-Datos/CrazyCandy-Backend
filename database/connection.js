var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "0408",
  database: "crazycandy",
  port: 3309
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});
module.exports={mysql,con};