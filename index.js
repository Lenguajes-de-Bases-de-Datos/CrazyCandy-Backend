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
// Primero vamos a hashear la contraseña|| no se usa||
const palabraSecretaTextoPlano = "hola";
const palabraSecretaProporcionadaPorUsuario="hol";
// Entre más rondas, mejor protección, pero más consumo de recursos. 10 está bien||no se usa
const rondasDeSal = 10;

var messages = [
  
];
var sa_avisos = [];

io.on("connection", function (socket) {
  
  let {room} = socket.handshake.query;
  if(!room){
    console.log("query vacio...")
  }else{
    room = JSON.parse(room);
    //si room es 0 se trata de un superadmin y el debe tener contacto con todas las sucursales...
    if(room==0){
     
    }else{
      
      socket.join(`room_${room}`);
    }
    socket.join('general');
    //console.log("usuario unido a room_"+room);
    let j = messages.findIndex(p => p.room == `room_${room}`);
    if(j!=-1){
      
      io.to(socket.id).emit('messages',messages[j].msgs.concat(sa_avisos));
    }
    //io.to(socket.id).emit('messages',sa_avisos);
    //console.log("j: "+j);
    
  }
  //console.log("Un cliente se ha conectado"+room);
  //socket.join();
  socket.on("msg",(res)=>{
    let aux = res;
    //console.log("msg:"+ JSON.stringify(res));
    
    let i = messages.findIndex(p => p.room == `room_${res.room}` );
    if(res.room == 0){
      sa_avisos.push({
        author:aux.author,
        text:aux.text,
        header:aux.header
        
      });
      io.to(`general`).emit('notification',res);
    }else{
      if(i!=-1){
        messages[i].msgs.push({
          author: aux.author,
          text: aux.text,
          header:aux.header
          
        });
      }else{
        messages.push(
          { 
            room:`room_${res.room}`,
            msgs:[{
            author: aux.author,
            text: aux.text,
            header:aux.header
          
          }]
        }
        );
      }
      io.to(`room_${res.room}`).emit('notification',res);
  }
    //socket.broadcast.in(`room_${res.room}`).emit('notification',res);
    
    //socket.broadcast.emit('notification',res);
    });
});


server.listen(3000, function() {
    console.log('Servidor corriendo en el puerto 3000!');
  });
 