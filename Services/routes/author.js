var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');






router.post('/list',function(req,res)
{
    connection.query("CALL  author_list() ;",[],function(err,rows)
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


router.post('/search',function(req,res)
{
    var keyword = req.param('keyword');
    connection.query("CALL  author_search_engine(?) ;",[keyword],function(err,rows)
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
