
var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');

router.post('/',function(req,res)
{

    connection.query("CALL  app_config() ;",[],function(err,rows)
    {
        if(!err)
        {
            var dict = {}; // create an empty array
            dict.app_info = rows[0];
            dict.html_template = rows[1];
            dict.design_templace = rows[2];
            res.status(200).send(Mi.responseProcess(err, dict));
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi hệ thống", rows[0]));
        }
    });
});







module.exports = router;
