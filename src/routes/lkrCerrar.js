const { Router, json } = require('express');
const router = Router();
const sql = require("mssql");

var dbconfig = {
    user: "user",
    password: "1234",
    server: "DESKTOP-RN5UUKR",
    database: "ProyectoI"
}

router.lock('/lkrCerrar', (req, res) =>{
    //console.log(req.body);
    const { ID } = req.body;
    obtenerEstado(ID, (ans) =>{
        res.json({"Estatus": `${ans}`});
    });
});

async function obtenerEstado(id, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Locker WHERE ID_Locker = '${id}'`);
    
    //console.log(result.recordset[0].ID_Orden);

    if(result.recordset[0]){
        callback(result.recordset[0].Estatus);
    }else{
        callback("No encontrado");
    }
}

module.exports = router;