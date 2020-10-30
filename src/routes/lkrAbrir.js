const { Router } = require('express');
const router = Router();
const sql = require("mssql");

var dbconfig = {
    user: "user",
    password: "1234",
    server: "DESKTOP-RN5UUKR",
    database: "ProyectoI"
}

router.unlock('/lkrAbrir', (req, res) =>{
    //console.log(req.body);
    const { ID, QR } = req.body;
    obtenerOrden(ID, QR, (orden, QR) =>{
        if(orden >= 0){
            verificarQR(orden, QR, (ver) =>{
                if(ver == 1){
                    res.json({"Acceptado": "Accesso Permitido"});
                }else{
                    res.json({"Error": "QR Incorrecto"});
                }
            });
        }else{
            res.json({"Error": "Locker libre"});
        }
    });
});

async function obtenerOrden(id, qr, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Locker WHERE ID_Locker = '${id}'`);
    
    //console.log(result.recordset[0].ID_Orden);

    if(result.recordset[0] && result.recordset[0].ID_Orden){
        callback(result.recordset[0].ID_Orden, qr);
    }else{
        callback(-1, qr);
    }
}

async function verificarQR(id, code, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Orden WHERE ID_Orden = '${id}'`);
    
    if(result.recordset[0] && result.recordset[0].QR == code){
        callback(1);
    }else{
        callback(0);
    }
}


module.exports = router;