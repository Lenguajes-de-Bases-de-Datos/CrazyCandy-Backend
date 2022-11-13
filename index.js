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
app.use(require('./routes/routes'));
var server = require("http").Server(app);
var io = require("socket.io")(server);
// Primero vamos a hashear la contraseña
const palabraSecretaTextoPlano = "hola";
const palabraSecretaProporcionadaPorUsuario="hol";
// Entre más rondas, mejor protección, pero más consumo de recursos. 10 está bien
const rondasDeSal = 10;

var messages = [
  {
    author: "Carlos",
    text: "Hola! que tal?",
    cont:1
  },
  {
    author: "Pepe",
    text: "Muy bien! y tu??",
    cont:1
  },
  {
    author: "Paco",
    text: "Genial!",
    cont:1
  },
  {
    author: "Cris",
    text: "YAAA!!",
    cont:1
  },
];


io.on("connection", function (socket) {
  
  socket.emit("messages", messages);
  let {room} = socket.handshake.query;
  if(!room){
    console.log("query vacio...")
  }else{
    room = JSON.parse(room)
    socket.join(`room_${room}`);
    console.log("usuario unido a room_"+room);

  }
  console.log("Un cliente se ha conectado"+room);
  //socket.join();
  socket.on("msg",(res)=>{
    let aux = res;
    console.log("msg:"+ JSON.stringify(res));
    let obj = {
      author:aux.author,
      text:aux.text,
      count:1,
      room:aux.room
    };
    //socket.broadcast.in(`room_${res.room}`).emit('notification',res);
    io.to(`room_${res.room}`).emit('notification',res);
    //socket.broadcast.emit('notification',res);
    });
});


server.listen(3000, function() {
    console.log('Servidor corriendo en el puerto 3000!');
  });
 