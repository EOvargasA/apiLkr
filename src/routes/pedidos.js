const { Router } = require('express');
const router = Router();
const sql = require("mssql");

var dbconfig = {
    user: "user",
    password: "1234",
    server: "DESKTOP-RN5UUKR",
    database: "ProyectoI"
}

router.get('/pedidos', (req, res) =>{
    var ans = [], temp;
    //console.log(req.body);
    const { ID } = req.body;
    if(ID >= 0){
        obtenerPedidos(ID, (pedidos) =>{
            for (i = 0; i < pedidos.length; i++){
                temp = {'ID_Orden': `${pedidos[i].ID_Orden}`,
                        'Fecha_orden': `${pedidos[i].Fecha_orden}`,
                        'Ubicacion': `${pedidos[i].Ubicacion}`};
                ans.push(temp);
            }

            res.json(ans);
        });
    }else{
        res.json({"Error": "ID invalida"});
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

async function obtenerPedidos(id, callback){
    var conn = new sql.ConnectionPool(dbconfig);
    var result;

    await conn.connect();

    result = await conn.query(`SELECT * FROM dbo.Orden WHERE ID_Cliente = '${id}'`);
    
    callback(result.recordset);
}

module.exports = router;