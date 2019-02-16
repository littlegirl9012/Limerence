var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');










/*
INSERT INTO book
(book.title,book.author,book.tiki_id,book.tiki_link,book.user_id,book.book_type,book.cat_name)
VALUES
(title,author,tiki_id,tiki_link,1,16,cat_name)*/




router.post('/book/tiki/insert',function(req,res)
{
    var title = req.param('title');
  	var author = req.param('author');
    var tiki_id = req.param('tiki_id');
    var tiki_link = req.param('tiki_link');
    var cat_name = req.param('cat_name');
    var image = req.param('image');
    var price = req.param('price');

    connection.query("CALL  administrator_book_tiki_insert(?,?,?,?,?,?,?) ;",[title,author,tiki_id,tiki_link,cat_name,image,price],function(err,rows)
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


router.post('/tiki/list',function(req,res)
{
    connection.query("CALL  tiki_list();",[],function(err,rows)
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


router.post('/tiki/update/sellprice',function(req,res)
{
    var id = req.param('tiki_id');
        var sell_price = req.param('sell_price');

    connection.query("CALL  tiki_update_sell_price(?,?);",[id,sell_price],function(err,rows)
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


router.post('/book/fahasa/insert',function(req,res)
{

    var keyInsert = "(temp";
    var valueInsert = "(?";
    var recordInsert = [];
    recordInsert.push(1);

    for (const key in req.body)
    {
        var temValue = req.body[key];
        if(temValue.length == 0)
        {
            continue ;
        }
        keyInsert = keyInsert + "," + key;
        valueInsert = valueInsert + "," + "?" ;
    recordInsert.push(temValue);

    }

    keyInsert = keyInsert + ")";
    valueInsert = valueInsert + ")";

    var query = "insert INTO book_store" + " " + keyInsert + " VALUES " + valueInsert ;
    console.log(query,recordInsert) ;


    connection.query(query,recordInsert,function(err,rows)
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
