var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');





router.post('/list',function(req,res)
{
    var UserID = req.param('user_id');
    connection.query("CALL  address_list(?) ;",[UserID],function(err,rows)
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


router.post('/node',function(req,res)
{
    connection.query("CALL  address_node() ;",[],function(err,rows)
    {
        if(!err)
        {

            var node = {} ;
            node.province = rows[0];
            node.district = rows[1];

            res.status(200).send(Mi.responseProcess(err, node));
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi hệ thống", rows[0]));
        }
    });
});


router.post('/delete',function(req,res)
{
     var ID = req.param('address_id');
    connection.query("CALL  address_delete(?) ;",[ID],function(err,rows)
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

router.post('/info',function(req,res)
{

});

router.post('/insert',function(req,res)
{


    var UserID = req.param('user_id');
    var DistrictID = req.param('district_id');
    var ProvinceID = req.param('province_id');
    var Name = req.param('name');
    var Address = req.param('address');
    var Phone = req.param('phone');


    connection.query("CALL  address_insert(?,?,?,?,?,?) ;",[UserID,Name,Phone,ProvinceID, DistrictID,Address],function(err,rows)
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

router.post('/update',function(req,res)
{
    var ID = req.param('ID');
    var DistrictID = req.param('DistrictID');
    var ProvinceID = req.param('ProvinceID');
    var Name = req.param('Name');
    var Address = req.param('Address');
    var Phone = req.param('Phone');


    connection.query("CALL  address_update(?,?,?,?,?,?) ;",[ID,Name,Phone,ProvinceID, DistrictID,Address],function(err,rows)
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




/*
customer_address.create
customer_address.delete
customer_address.info
customer_address.list
customer_address.update
*/