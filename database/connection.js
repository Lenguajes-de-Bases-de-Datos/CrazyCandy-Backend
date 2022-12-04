var mysql = require('mysql');

var con = mysql.createPool({
     connectionLimit:1,
     host: "3.229.212.243",
     user: "candy",
     password: "cr4Z1",
     database: "crazycandy",
     port: 3306,
   });


// var con = mysql.createConnection({
//   host: "3.229.212.243",
//   user: "candy",
//   password: "cr4Z1",
//   database: "crazycandy",
//   port: 3306,
// });
// var con = mysql.createConnection({
//   host: "localhost",
//   user: "root",
//   password: "root",
//   database: "crazycandy",
//   port: 3306,
// });
var band=false;
// try{
//   con.connect(function(err) {
//     if (err){ band=false;throw err; c}
//     band=true;console.log("Connected!");
//   });
// }catch(err){
//   console.log("error en database")
// }

module.exports={mysql,con};