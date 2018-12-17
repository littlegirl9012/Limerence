var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');






router.post('/list',function(req,res)
{

    connection.query("CALL  product_list() ;",[],function(err,rows)
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

router.post('/detail',function(req,res)
{
    var ProductID = req.param('product_id');
    var UserID = req.param('user_id');



    connection.query("CALL  product_detail(?,?) ;",[UserID,ProductID],function(err,rows)
    {
        if(!err)
        {

            var response = {};
            response.Info = rows[0];
            response.Images = rows[1];
            response.Comment = rows[2];

            var isLike =  rows[3][0].IsLike;
            if(isLike == 0)
            {
                response.IsLike = false;
            }
            else
            {
                response.IsLike = true;
            }

            res.status(200).send(Mi.responseProcess(err, response));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});

router.post('/likelist',function(req,res)
{

    var UserID = req.param('user_id');

    connection.query("CALL  product_like_list(?) ;",[UserID],function(err,rows)
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

router.post('/category',function(req,res)
{

    var ID = req.param('category_id');

    connection.query("CALL  product_category(?) ;",[ID],function(err,rows)
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
    var IsLike = req.param('is_like');
    var UserID = req.param('user_id');
    var ProductID = req.param('product_id');

    if(IsLike == true)
    {
        connection.query("CALL  product_like(?,?) ;",[UserID,ProductID],function(err,rows)
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
        connection.query("CALL  product_unlike(?,?) ;",[UserID,ProductID],function(err,rows)
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
