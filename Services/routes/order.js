var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');




router.post('/list',function(req,res)
{
    var UserID = req.param('user_id');

    connection.query("CALL  orders_list(?);",[UserID],function(err,rows)
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



router.post('/change',function(req,res)
{
    var order_id = req.param('order_id');
    var user_id = req.param('user_id');
    var status = req.param('status');
    connection.query("CALL  orders_change_status(?,?,?);",[order_id,status,user_id],function(err,rows)
    {
        if(!err)
        {
            var result = {}
            result.order =  rows[0][0];
            result.product =  rows[1];

            res.status(200).send(Mi.responseProcess(err, result));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});


router.post('/detail',function(req,res)
{
    var order_id =  req.param('order_id');      
    var user_id =  req.param('user_id');

    connection.query("CALL  orders_detail(?,?);",[user_id,order_id],function(err,rows)
    {
        if(!err)
        {
            var result = {}
            result.order =  rows[0][0];
            result.product =  rows[1];

            res.status(200).send(Mi.responseProcess(err, result));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});




router.post('/insert',function(req,res)
{

    var user_id = req.param('user_id');
    var phone = req.param('phone');
    var address = req.param('address');
    var orders =  req.param('orders') ;

    'use strict';
    for (let i in orders)
    {
        let orderItem = orders[i];
        let product_price = 0;

        for (let j in orderItem.products)
        {
            product_price = product_price + orderItem.products[j].price ;
        }

        connection.query("CALL orders_insert (?,?,?,?,?)", [user_id,orderItem.user_id,phone,address,product_price], function(err2, result) {
        

            if(!err2)
            {
                let order_id = result[0][0].id;
                let records = [] ;
                let product_list = orderItem.products ;
                for( let j in product_list)
                {
                    let product_id = product_list[j].id;
                    let product_price = product_list[j].price;
                    records.push([order_id,product_id,product_price]) ;
                }

                let query = "INSERT INTO orders_product(orders_id,product_id,price) VALUES ?";

                connection.query(query, [records], function(err3, result3) {


                });
            }
            else
            {
               if(i == orders.length - 1)
                {

                }
            }

        });

    }
    res.status(200).send(Mi.responseProcess("",1));

});

module.exports = router;