const { Router } = require('express');
const router = Router();
const sql = require("mssql");

var dbconfig = {
    user: "user",
    password: "1234",
    server: "DESKTOP-RN5UUKR",
    database: "ProyectoI"
}

router.unlock('/auth', (req, res) =>{
    //console.log(req.body);
    const { uname, password } = req.body;
    if(uname && password){
        auth(uname, password, (cred) =>{
            
            //console.log(cred);

            if(cred.ID_Cliente){
                res.json({"ID": `${cred.ID_Cliente}`});
                //res.json({"Token": "asa123"});
            }else{
                res.json({"Error": "Invalid user"});
            }

        });
    }else{
        res.json({"Error": "Wrong Object"});
    }
});

async function auth(name, pass, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var pepole = {"Error": "Invalid user"};

    await conn.connect();
    const result = await conn.query(`SELECT * FROM dbo.Cliente WHERE Usuario = '${name}' AND Contraseña = '${pass}'`);

    if(typeof result.recordset[0] !== 'undefined'){
        pepole = result.recordset[0];
    }

    callback(pepole);
}

/*async function token(length, id, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var found = false;
    var date = new Date();
    var tkn = "asa123", result;

    await conn.connect();

    do{
        tkn = makeid(length);

        result = await conn.query(`SELECT * FROM dbo.Tokens WHERE token = '${tkn}'`);
        //console.log(result);

        if(!result.recordset[0]){
            date.setDate(date.getDate() + 2);
            date = date.toISOString().slice(0, 19).replace('T', ' ');
            await conn.query(`INSERT INTO dbo.Tokens (token, ID_Usuario, Fecha_Exp) VALUES ('${tkn}', ${id} , '${date}')`);
            found = true;
        }

    }while(!found)

    callback(tkn);
}*/

/*function makeid(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }*/

module.exports = router;