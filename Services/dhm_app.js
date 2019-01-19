
var express = require('express');
var app = express();
var bodyParser    = require("body-parser");
var multer  =   require('multer');

var pn_services  =   require('./routes/pn_services');



app.setMaxListeners(0);


app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

var user = require('./routes/user');
app.use('/user', user);

var upload = require('./routes/upload');
app.use('/upload', upload);

var book = require('./routes/book');
app.use('/book', book);

var book_24 = require('./routes/book_24');
app.use('/book_24', book_24);

var notification = require('./routes/notification');
app.use('/notification', notification);

var category = require('./routes/category');
app.use('/category', category);

var contact = require('./routes/contact');
app.use('/contact', contact);

var application = require('./routes/application');
app.use('/application', application);

var device = require('./routes/device');
app.use('/device', device);

var author = require('./routes/author');
app.use('/author', author);

var feeling = require('./routes/feeling');
app.use('/feeling', feeling);

var admin = require('./routes/admin');
app.use('/admin', admin);

var university = require('./routes/university');
app.use('/university', university);

var order = require('./routes/order');
app.use('/order', order);

var address = require('./routes/address');
app.use('/address', address);



app.listen(9886);











