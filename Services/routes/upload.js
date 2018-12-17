

var express = require('express');
var router  = express.Router();
var multer  =   require('multer');
var path = require('path');
var Mi = require('../model/mi');
var connection = require('../config/db');
var bodyParser = require('body-parser');

var app         =   express();
app.use(bodyParser.json());
var urlencodedParser = bodyParser.urlencoded({ extended: false })
app.use(multer);
app.use(bodyParser.json({ type: 'multipart/form-data' }))


var BookStore =   multer.diskStorage({

    destination: function (req, file, callback) {


        var brand = req.body.brand ;
        var user_id = req.body.user_id ;

        var fs = require('fs');
        var dir = './media/';

        if (!fs.existsSync(dir))
        {
            fs.mkdirSync(dir);
        }

        var user_dir = dir + user_id + "/"

        if (!fs.existsSync(user_dir))
        {
            fs.mkdirSync(user_dir);
        }

        var con_dir = user_dir + "conference" + "/"

        if (!fs.existsSync(con_dir))
        {
            fs.mkdirSync(con_dir);
        }

        var info_dir = user_dir + "info" + "/"

        if (!fs.existsSync(info_dir))
        {
            fs.mkdirSync(info_dir);
        }

        var book_dir = user_dir + "books" + "/"

        if (!fs.existsSync(book_dir))
        {
            fs.mkdirSync(book_dir);
        }

        if(brand == 1)
        {
             callback(null, info_dir);
        }

        if(brand == 2)
        {
             callback(null, book_dir);
        }

        if(brand == 3)
        {
             callback(null, con_dir);
        }


    },

  filename: function (req, file, callback) {

        callback(null,Date.now() + "-" + file.originalname);

      }
});
var book = multer({ storage : BookStore}).array('media');

router.post('/media', urlencodedParser,function(req,res){

    book(req,res,function(err) {
        if(err) 
        {
            res.status(200).send(Mi.responseProcess(err));
        }
        else
        {

            var output = req.files;

                var records = [] ;

                for (var i in output) 
                {
                    var unit = output[i];
                    unit.path = "http://dephoanmy.vn/DHMServices/" + unit.path ;
                    records.push(unit) ;
                }





            res.status(200).send(Mi.responseProcess(0,records));
        }

    });
});





//------------------------------------------------------------------
var UserStore =   multer.diskStorage({

    destination: function (req, file, callback) {
    var fs = require('fs');
    var dir = './media/'+"user";

    if (!fs.existsSync(dir))
    {
        fs.mkdirSync(dir);
    }
      callback(null, dir);
    },

  filename: function (req, file, callback) {

        callback(null,Date.now() + "-" + file.originalname);

      }
});
var user = multer({ storage : UserStore}).single('user');


router.post('/images', urlencodedParser,function(req,res){

    user(req,res,function(err) {
        if(err) 
        {
          res.status(200).send(Mi.responseProcess(err));
        }
        else
        {
            var UserID = req.body.UserID ;
            var mainPath = req.file.path ;

            connection.query("CALL UserUpdateImage(?,?);",[UserID,mainPath],function(err,rows)
            {
                if(err) 
                {
                    res.status(200).send(Mi.responseProcess(err));
                }
                else
                {
                    res.status(200).send(Mi.responseProcess(0,mainPath));
                }
             });

        }

    });
});

router.post('/cover', urlencodedParser,function(req,res){

    user(req,res,function(err) {
        if(err) 
        {
          res.status(200).send(Mi.responseProcess(err));
        }
        else
        {
            var UserID = req.body.UserID ;
            var mainPath = req.file.path ;

            connection.query("CALL UserUpdateCover(?,?);",[UserID,mainPath],function(err,rows)
            {
                if(err) 
                {
                    res.status(200).send(Mi.responseProcess(err));
                }
                else
                {
                    res.status(200).send(Mi.responseProcess(0,mainPath));
                }
             });

        }

    });
});


module.exports = router;



