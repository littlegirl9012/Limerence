var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');



router.post('/insert',function(req,res)
{
    var user_id = req.param('user_id');
    var book_id = req.param('book_id');
    var content = req.param('content');
    var note = req.param('note');
    var images = req.param('images');
    var rate = req.param('rate');
    var intro = req.param('intro');

	var image = "";

    if(images.length > 0)
    {
		var image = images[0];
    }




    connection.query("CALL  book_feeling_insert(?,?,?,?,?,?,?);",[user_id,book_id,content,note,image,rate,intro],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});

router.post('/list',function(req,res)
{
    var book_id = req.param('book_id');
    connection.query("CALL  book_feeling_list(?);",[book_id],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});




module.exports = router;