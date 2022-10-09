const { compare } = require("../database/querys");

function createToken(){

    if(compare("","")){
        const payload = {
            check:  true
           };
           const token = jwt.sign(payload, app.get('llave'), {
            expiresIn: 5//minutes
           });
           res.json({
            mensaje: 'Autenticación correcta',
            token: token
           });
    }
}