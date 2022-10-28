const express = require('express');
const app = express();
const router = express.Router();
var redis = require('redis');
var JWTR = require('jwt-redis').default;

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
      console.log("token: "+token);
      if (err) {
        return res.json({ mensaje: 'Token inválida '+err });    
      } else {
        req.decoded = decoded;    
        next();
        return res.send("successfully");
      }
    });
  }else {
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
      var resp = await query.query(`SELECT * FROM usuario WHERE nombre='${user.nombre}' and password=sha2('${user.password}',256)`);
      if(resp.length>0){//significa que se autentica correctamente...
        //generamos el token...
        
        json = JSON.stringify(resp); 
        console.log(json);
        parse=JSON.parse(json)
       
        mykey = configs.llave;
        let payload = {
          user:parse[0].nombre,
          id:parse[0].ID,
          time:Date()
        };
        let datos = parse[0];
        // const token = jwt.sign(payload,mykey,{
        //   expiresIn:'30s'
        // });
       
        var token = jwt.sign(payload,mykey,{
             expiresIn:'10m'
          })
  

        console.log("tok: "+token)
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
        console.log("decoded: "+decoded.time);
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

router.post('/logout',(req,res)=>{


});
router.post('/insert',(req,res)=>{
  params = req.params;
  let sql = `INSERT INTO ${req.body.table} (ID,ID_sucursal,password,nombre,appat,apmat,privilegios,caja)
  VALUES(ID,'${req.body.ID_sucursal}','${req.body.password}','${req.body.nombre}','${req.body.appat}',
  '${req.body.apmat}','${req.body.privilegios}','${req.body.caja}')`;
});




module.exports=router;