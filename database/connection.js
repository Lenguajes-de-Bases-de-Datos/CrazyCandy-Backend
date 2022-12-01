var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "0408",
  database: "crazycandy",
  port: 3309
});
var band=false;
  con.connect(function(err) {
    if (err){ band=false;throw err;}
    band=true;console.log("Connected!");
  });
  

module.exports={mysql,con};