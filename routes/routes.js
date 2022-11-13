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
      console.log("Rutas protegidas: ");
      if (err) {
        console.log("SI: ");
        res.status(401).json({ mensaje: 'Token inválida '+err });       
      } else {
        console.log("NOP: ");
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
        console.log(json);
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
             expiresIn:'1m'
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
router.post('/extender',async (req,res)=>{
  try{
    var user = req.body;
    var resp = await query.query(`SELECT * FROM usuario WHERE email='${user.nombre}' and password='${user.password}'`);
    if(resp.length>0){//significa que se autentica correctamente...
      //generamos el token...
      
      json = JSON.stringify(resp); 
      console.log(json);
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
});
router.post('/logout',(req,res)=>{


});
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
router.get('/readSucursal',rutasProtegidas,(req,res)=>{
   let sql = `SELECT b.id,a.estado,a.ciudad,a.colonia,b.calle,b.numero FROM ubicacion a,sucursal b WHERE a.id=b.id_ubicacion`; 
   query.query(sql).then((resp)=>{
    let results = JSON.stringify(resp); 
    
    res.send(results);
  }).catch((err)=>{
    console.log(err);
  });
});
//##################################################
//################################################
///parte de categoria....
router.post('/insertar-categoria',rutasProtegidas,(req,res)=>{
  let sql = `INSERT INTO categoria(id,ncategoria,pasilloInicio,pasilloFin) VALUES 
  (id,'${req.body.nombre}',${req.body.pasilloInicio},${req.body.pasilloFin})`;
  query.query(sql).then((resp)=>{
    console.log("1 record insert successfully");
    res.send({band:true});
  }).catch((err)=>{
    console.log(err);
  });

});
router.get('/consultar-categorias',rutasProtegidas,(req,res)=>{
  let sql = `SELECT * FROM categoria`;
  query.query(sql).then((resp)=>{
    let results = JSON.stringify(resp); 
    console.log(results);
    res.send(results);
  }).catch((err)=>{
    console.log(err);
  });

});

router.post('/consulta-uncategoria',rutasProtegidas,(req,res)=>{

  let sql = `SELECT * FROM categoria WHERE id=${req.body.id}`;
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
    console.log(results);
    res.send(results);
  }).catch((err)=>{
    console.log(err);
  });
});

module.exports=router;