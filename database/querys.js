// let sql = "INSERT INTO usuario(ID,nombre,password) VALUES(ID,'cris','"+palabraSecretaEncriptada+"')";
const bcrypt = require("bcryptjs");
const {mysql,con,con2}=require("./connection");
 function query(sql){

      return new Promise((resolve,reject)=>{
        con.query(sql
            , function (err, result,fields) {
            //console.log("1")
                if (err) reject(err);
                    resolve(result);
            }
        );
      }) 
    
 
    
}
function query2(sql){

    return new Promise((resolve,reject)=>{
      con2.query(sql
          , function (err, result,fields) {
          //console.log("1")
              if (err) reject(err);
                  resolve(result);
          }
      );
    }) 
  

  
}
// setInterval(()=>{
//     query("Select now() from dual");
// },15000);
function encrypt(secret){
   return bcrypt.hash(secret,10,(err,result)=>{
        if(err){
            console.log("Error provided: "+err);
        }else{
            return result;
        }
    });
}

function compare(input,password){
    return bcrypt.compare(input,password,(err,result)=>{
        if(err){
            console.log("Error provided: ",err);
        }else{
            return result;
        }
    });


}
module.exports={
    'compare':compare,
    'query':query,
    'query2':query2
};
//bycript
// const palabraSecretaHasheada=bcrypt.hash(palabraSecretaTextoPlano, rondasDeSal, (err, palabraSecretaEncriptada) => {
// 	if (err) {
// 		console.log("Error hasheando:", err);
// 	} else {
// 		console.log("Y hasheada es: " + palabraSecretaEncriptada);
        
//         bcrypt.compare(palabraSecretaProporcionadaPorUsuario, palabraSecretaEncriptada, (err, coinciden) => {
//             if (err) {
//                 console.log("Error comprobando:", err);
//             } else {
//                 console.log("¿La contraseña coincide?: " + coinciden);
//             }
//         });
// 	}
// });