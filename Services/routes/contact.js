var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');


router.post('/list',function(req,res)
{
	var user_id = req.param('user_id');
    connection.query("CALL  contact_list(?);",[user_id],function(err,rows)
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

router.post('/accept',function(req,res)
{
    var user_id = req.param('user_id');
    connection.query("CALL  contact_list(?);",[user_id],function(err,rows)
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

router.post('/cancel',function(req,res)
{
    var user_id = req.param('user_id');
    connection.query("CALL  ContactCancel(?);",[user_id],function(err,rows)
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
