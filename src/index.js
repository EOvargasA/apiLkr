express = require('express');
const app = express();
const morgan = require('morgan');

//settings
app.set('port', process.env.PORT || 3000);
app.set('json spaces', 2);

//middleware
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: false}));
app.use(express.json());

//routes
app.use(require('./routes/index'));
//modificar
app.use('/api/', require('./routes/auth'));
app.use('/api/', require('./routes/pedidos'));
app.use('/api/', require('./routes/objetosP'));
app.use('/api/', require('./routes/QR'));
app.use('/api/', require('./routes/lkrCerrar'));
app.use('/api/', require('./routes/lkrAbrir'));

//starting virtual server
app.listen(app.get('port'), () =>{
    console.log(`Server on port ${app.get('port')}`);
});

//a