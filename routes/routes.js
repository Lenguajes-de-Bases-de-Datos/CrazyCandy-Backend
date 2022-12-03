const express = require('express');
const app = express();
const router = express.Router();
var redis = require('redis');
var JWTR = require('jwt-redis').default;
var fs = require("fs");
var multipart = require('connect-multiparty');
const dir = '../ProyectoFinal-Front-end-/src/assets/productos';
var multipartMiddleware = multipart({
  uploadDir:`${dir}`
});

 var jwt=require("jsonwebtoken");

const configs = require('../config/configs');
const query = require('../database/querys');
//middleware
const rutasProtegidas = express.Router(); 
rutasProtegidas.use((req, res, next) => {
    // const token = req.headers['access-token'];

  let tokenHeaderKey = 'crazys';
  let mykey = configs.llave;

  const token = req.headers['crazys'];
  if(token){
    jwt.verify(token,mykey,(err,decoded)=>{
      //console.log("Rutas protegidas: ");
      if (err) {
        //console.log("SI: ");
        res.status(401).json({ mensaje: 'Token inválida '+err });       
      } else {
        //console.log("NOP: ");
        req.decoded = decoded;    
        next();
         
      }
    });
  }else {
    console.log("Token np: ");
      res.send({ 
          mensaje: 'Token no proveída.' 
      });
    }


    // if (token) {
    //   jwt.verify(token, app.get('llave'), (err, decoded) => {      
    //     if (err) {
    //       return res.json({ mensaje: 'Token inválida' });    
    //     } else {
    //       req.decoded = decoded;    
    //       next();
    //     }
    //   });
    // } else {
    //   res.send.json({ 
    //       mensaje: 'Token no proveída.' 
    //   });
    // }


 });



router.post('/login', async(req, res)=> {
    // console.log(req.body);
    // res.send('Hola Mundo!');
    try{
      var user = req.body;
      var resp = await query.query(`SELECT * FROM usuario WHERE email='${user.nombre}' and password=sha2('${user.password}',256)`);
      if(resp.length>0){//significa que se autentica correctamente...
        //generamos el token...
        
        json = JSON.stringify(resp); 
        //console.log(json);
        parse=JSON.parse(json)
       
        mykey = configs.llave;
        let payload = {
          user:parse[0].email,
          id:parse[0].ID,
          privilegios:parse[0].privilegios,
          sucursal:parse[0].ID_sucursal,
          time:Date()
        };
        let datos = parse[0];
        // const token = jwt.sign(payload,mykey,{
        //   expiresIn:'30s'
        // });
       
        var token = jwt.sign(payload,mykey,{
             expiresIn:'10m'
          })
  

        //console.log("tok: "+token)
        res.send({
          msg:token,
          datos:datos
        });
        //generamos el token...
      

        
      }else{
        res.send({
          msg:undefined
        });
      }
    }catch(err){console.log("err2")}
    //  if(result){
  //   console.log(result);

  //  }else{
  //   console.log("datos erroneos")
  //  } 
   
});
router.post('/generate',(req,res)=>{
  mykey = configs.llave;
  let payload = {
    user:'cris',
    id:1,
    time:Date()
  };
  // const token = jwt.sign(payload,mykey,{

  // });

  const token = jwt.sign(payload,mykey).then((token)=>{

  },)
  .catch((err)=>{});

  res.send({
    mytoken:token
  });
});
router.get('/validate',(req,res,next)=>{
  let tokenHeaderKey = 'crazys';
  let mykey = configs.llave;

  const token = req.headers['crazys'];
  if(token){
    jwt.verify(token,mykey,(err,decoded)=>{
      
      if (err) {
        return res.status(401).json({ mensaje: 'Token inválida '+err });    
      } else {
        req.decoded = decoded;    
        //console.log("decoded: "+decoded.time);
        // next();
        return res.send({mensaje:"successfully"});
      }
    });
  }else {
      res.send({ 
          mensaje: 'Token no proveída.' 
      });
    }

});

/* router.post('/logout',(req,res)=>{
      
    }else{
      res.send({
        msg:undefined
      });
    }
  }catch(err){console.log("err2")}
}); */

router.post('/insertUser',rutasProtegidas,(req,res)=>{
  params = req.params;
  console.log("body"+req.body)
  let sql = `INSERT INTO usuario (ID,ID_sucursal,password,nombre,appat,apmat,privilegios,des,email,telefono)
  VALUES(ID,${req.body.ID_sucursal},sha2('${req.body.password}',256),'${req.body.nombre}','${req.body.appat}',
  '${req.body.apmat}','${req.body.privilegios}','${req.body.des}','${req.body.email}','${req.body.telefono}')`;
  query.query(sql).then((resp)=>{
    console.log("1 record insert successfully");
    res.send({band:true});
  }).catch((err)=>{
    console.log(err);
  })
});

router.post('/accion',(req,res)=>{
  console.log(req.body.sql);
  query.query(req.body.sql).then((resp)=>{
    console.log("1 record insert successfully");
    res.send({band:true});
  }).catch((err)=>{
    console.log(err);
    res.send({band:false,errno:err.errno});
  });


});
router.get('/consultas',(req,res)=>{

  let sql = req.query.sql;
  query.query(sql).then((resp)=>{
    let results = JSON.stringify(resp); 
    //console.log(results);
    res.send(results);
  }).catch((err)=>{
    console.log(err);
  });
});

////SUBIR IMAGEN A PRODUCTO
router.post('/api/subir', multipartMiddleware,(req, res)=>{
  let archivos=req.files.uploads;
  //se trae el array de archivos
  for (let i=0; i<archivos.length;++i){
      // Reescribe el archivo
      fs.rename(archivos[i].path, `${dir}/${archivos[i].name}`, () => { 
          console.log("\nFile Renamed!\n"); 
      }); 
  }
  res.json({
      'message':'Fichero subido correctamente!',
      'archivo':req.files
  });

  console.log(req.files);
});
//Borrar la imagen del producto porque se actualizo
router.post('/api/borrar', (req, res)=>{
  let nombre = req.body.nombre;
  //Elimina el archvio que se ele indico 
  let band=true;
  fs.unlink(`${dir}/${nombre}`, (error)=>{
    if(error){
      band=false;
    }
  });
  console.log(req.body);
  res.send({
    band:band
  });
});

module.exports=router;