var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');







router.post('/update/version',function(req,res)
{
    var user_id = req.param('user_id');
    var version = req.param('version');
    var version = req.param('revision');


    connection.query("CALL  device_update_version(?,?,?) ;",[user_id,version, revision],function(err,rows)
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

router.post('/update/location',function(req,res)
{
    var latitude = req.param('latitude');
    var longitude = req.param('longitude');
    var user_id = req.param('user_id');


    connection.query("CALL  device_update_location(?,?,?) ;",[user_id,latitude,longitude],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));

            //res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});


router.post('/update/token',function(req,res)
{
    var token = req.param('token');
    var user_id = req.param('user_id');


    connection.query("CALL  device_update_token(?,?) ;",[user_id,token],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));

            //res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});


router.post('/update',function(req,res)
{
    var user_id = req.param('user_id');
    var token = req.param('token');
    var operation = req.param('operation');
    var version = req.param('version');
    var revision = req.param('revision');
    var name = req.param('name');
    var device_id = req.param('device_id');
    var device_type = req.param('device_type');

    connection.query("CALL  device_update(?,?,?,?,?,?,?,?) ;",[user_id,token,operation,version,revision,name,device_id,device_type],function(err,rows)
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
