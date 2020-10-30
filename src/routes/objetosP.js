const { Router } = require('express');
const router = Router();
const sql = require("mssql");

var dbconfig = {
    user: "user",
    password: "1234",
    server: "DESKTOP-RN5UUKR",
    database: "ProyectoI"
}

router.get('/objetosP', (req, res) =>{
    //console.log(req.body);
    const { ID_Cliente, ID_Orden } = req.body;
    if(ID_Cliente >= 0){
        authPedido(ID_Orden, ID_Cliente, (pedido) => {
            if(pedido >= 0){
                getObjects(pedido, (respuesta) => {
                    res.json(respuesta);
                });
            }else{
                res.json({"Error": "Invalid Token"});
            }
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

async function authPedido(id, user, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Orden WHERE ID_Cliente = '${user}' AND ID_Orden = '${id}'`);
    
    if(result.recordset[0]){
        callback(id);
    }else{
        callback(-1);
    }
}

async function getObjects(id, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var result, list, prod = [];

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Orden_Producto WHERE ID_Orden = '${id}'`);
    
    if(result.recordset[0]){
        list = result.recordset;
        
        for(i = 0; i < list.length; i++){
            temp = await getProduct(list[i].ID_Producto);
            prod.push(temp);
        }

        callback(prod);
    }else{
        callback({"Error": "El pedido no tiene objetos asociados"});
    }
}

async function getProduct(id){
    var conn = new sql.ConnectionPool(dbconfig);
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Producto WHERE ID = '${id}'`);
    
    if(result.recordset[0]){
        return result.recordset[0];
    }else{
        return {"Error": "El producto no existe"};
    }
}

module.exports = router;