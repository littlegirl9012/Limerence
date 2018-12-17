var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');


router.post('/likelist',function(req,res)
{
    var UserID = req.param('user_id');

    connection.query("CALL  news_like_list(?);",[UserID],function(err,rows)
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


router.post('/like/id',function(req,res)
{
    var UserID = req.param('user_id');

    connection.query("CALL      news_like_id_list(?);",[UserID],function(err,rows)
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






router.post('/like',function(req,res)
{
    var UserID = req.param('user_id');
    var PostID = req.param('news_id');
    var IsLike = req.param('is_like');


    if(IsLike)
    {
        connection.query("CALL  news_like(?,?);",[UserID,PostID],function(err,rows)
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

    }
    else
    {
        connection.query("CALL  news_unlike(?,?);",[UserID,PostID],function(err,rows)
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
    }
});


module.exports = router;
