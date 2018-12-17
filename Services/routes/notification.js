var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');


router.post('/book',function(req,res)
{
    var UserID = req.param('user_id');

    connection.query("CALL  notification_book(?);",[UserID],function(err,rows)
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
    var UserID = req.param('user_id');

    connection.query("CALL  notification_list(?);",[UserID],function(err,rows)
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

router.post('/delete',function(req,res)
{
    var notification_id = req.param('notification_id');

    connection.query("CALL  notification_delete(?);",[notification_id],function(err,rows)
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


router.post('/subscribe',function(req,res)
{
    var subscribe = req.param('subscribe');

    connection.query("CALL  notification_subscribe(?);",[subscribe],function(err,rows)
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



router.get('/post',function(req,res)
{

    connection.query("CALL  notification_wp_post();",[],function(err,rows)
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
