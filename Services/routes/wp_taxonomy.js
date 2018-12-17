
var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');

router.post('/meta',function(req,res)
{
    connection.query("CALL  NEWSCAT_List();",[],function(err,rows)
    {

        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi hệ thống", rows[0]));
        }
    });
});

module.exports = router;