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


router.post('/detail',function(req,res)
{
    var OrderID =  req.param('order_id');
    connection.query("CALL  orders_detail(?);",[OrderID],function(err,rows)
    {
        if(!err)
        {
            var result = {}
            result.Order =  rows[0][0];
            result.Product =  rows[1];

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

    var product = req.param('product');
    var UserID = req.param('user_id');
    var Name = req.param('name');
    var ProvinceID = req.param('province_id');
    var DistrictID = req.param('district_id');
    var Phone = req.param('phone');
    var Address = req.param('address');
    var CouponID = req.param('coupon_id');

    var ProductPrice = 1;
    var ShippingPrice = 20;

    for (var i in product) 
    {
        var unit = product[i];
        ProductPrice = ProductPrice + unit.price ;
    }

    var TotalPrice = ProductPrice + ShippingPrice ;


    if(!CouponID)
    {
        CouponID = -1;
    }

    if(!UserID)
    {
        UserID = -1 ;
    }





    connection.query("CALL  orders_insert(?,?,?,?,?,?,?,?,?,?);",[UserID,Name,Phone,ProvinceID,DistrictID,Address,CouponID,ProductPrice,ShippingPrice,TotalPrice],function(err,rows)
    {
        if(!err)
        {
            var orderID = rows[0][0].id;
            var records = [] ;
            for (var i in product) 
            {
                var unit = product[i];
            records.push([orderID,unit.id,unit.price,unit.quantity]) ;

            }


            var query = "INSERT INTO orders_product(orders_id,product_id, price, quantity) VALUES ?";

            connection.query(query, [records], function(err2, result) {

                if(!err2)
                {
                    res.status(200).send(Mi.responseProcess(err2,orderID));
                }
                else
                {
                    res.status(200).send(Mi.responseProcess(records));
                }
            });

         }
        else
        {
            res.status(200).send(Mi.responseProcess(err, "err"));
        }
    });

});

module.exports = router;