var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "1234",
  database: "crazycandy",
  port: "3308"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});
module.exports={mysql,con};