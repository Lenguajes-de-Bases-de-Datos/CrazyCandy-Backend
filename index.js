const bcrypt = require("bcryptjs");
const {mysql,con}=require("./database/connection");
const express=require("express");
const app=express();
const body_parser=require("body-parser");
const cors = require("cors");
const configs = require("./config/configs");
app.use(cors());


app.use(body_parser.urlencoded({ extended:false}));
app.use(body_parser.json());
app.use(require('./routes/routes'))
// Primero vamos a hashear la contraseña
const palabraSecretaTextoPlano = "hola";
const palabraSecretaProporcionadaPorUsuario="hol";
// Entre más rondas, mejor protección, pero más consumo de recursos. 10 está bien
const rondasDeSal = 10;



app.listen(3000, function() {
    console.log('Servidor corriendo en el puerto 3000!');
  });
 