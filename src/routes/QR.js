const { Router } = require('express');
const router = Router();
const sql = require("mssql");

var dbconfig = {
    user: "user",
    password: "1234",
    server: "DESKTOP-RN5UUKR",
    database: "ProyectoI"
}

router.get('/QR', (req, res) =>{
    //console.log(req.body);
    const { ID_Cliente, ID_Orden } = req.body;
    if(ID_Cliente >= 0){
        obtenerQR(ID_Orden, ID_Cliente, (pedidos) =>{
            res.json(pedidos);
        });
    }else{
        res.json({"Error": "Invalid Token"});
    }
});

/*async function autenticar(token, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var date = new Date();
    date.setDate(date.getDate() + 2);
    date = date.toISOString().slice(0, 19).replace('T', ' ');
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Tokens WHERE token = '${token}' AND Fecha_Exp >= '${date}'`);
    
    if(result.recordset[0]){
        callback(result.recordset[0].ID_Usuario);
    }else{
        callback(-1);
    }

}*/

async function obtenerQR(id, user, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Orden WHERE ID_Cliente = '${user}' AND ID_Orden = '${id}'`);
    
    if(result.recordset[0]){
        callback({"QR": `${result.recordset[0].QR}`});
    }else{
        callback({"Error": "Pedido no encontrado"});
    }
}

module.exports = router;