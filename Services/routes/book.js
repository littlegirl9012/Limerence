var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');
var pn_services  =   require('../routes/pn_services');


router.post('/insert',function(req,res)
{
    var user_id = req.param('user_id');
    var title = req.param('title');
    var content = req.param('content');
    var price = req.param('price');
    var author = req.param('author');
    var status = req.param('status');
    var images = req.param('images');
    var book_type = req.param('book_type');
    var lend_id = req.param('lend_id');


    var categories = req.param('category_id');
    var feature_image = "";

    if(!status)
    {
        status = 0;
    }


    if(images.length > 0)
    {
        feature_image =  images[0];
    }

    if(!author)
    {
        author = "";
    }

    if(!content)
    {
        content = "";
    }



    var public_year = req.param('public_year');
    var note = req.param('note');
    var isbn = req.param('isbn');
    var code = req.param('code');
    var page_number = req.param('page_number');
    var author_id = req.param('author_id');
    var feeling = req.param('feeling');
    var rate = req.param('rate');



    if(!public_year)
    {
        public_year = "";
    }

    if(!note)
    {
        note = "";
    }

    if(!code)
    {
        code = "";
    }


    if(!isbn)
    {
        isbn = "";
    }



    if(!page_number)
    {
        page_number = "";
    }


    if(!author_id)
    {
        author_id = -1;
    }

    if(!feeling)
    {
        feeling = "";
    }


    if(!rate)
    {
        rate  = 5 ;;
    }




    connection.query("CALL  book_insert(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[user_id,title,feature_image,content,price,author,status,book_type,public_year,note,isbn,code,page_number,author_id,feeling, rate],function(err,rows)
    {
        if(!err)
        {
            var book_id = rows[0][0].id;

            if((lend_id )&& (lend_id != -1))
            {
                connection.query("CALL  lend_insert(?,?) ;",[lend_id,book_id],function(err,rows)
                {
                });
            }

            if(images.length > 0)
            {

                var records = [] ;

                for (var i in images) 
                {
                    var unit = images[i];
                    records.push([book_id,unit]) ;
                }
                var query = "INSERT INTO book_image(book_id,image) VALUES ?";

                connection.query(query, [records], function(err2, result) {
                });

            }


            if(categories.length > 0)
            {

                var records = [] ;

                for (var i in categories) 
                {
                    var unit = categories[i];
                    records.push([book_id,unit]) ;
                }
                var query = "INSERT INTO book_category(book_id,category_id) VALUES ?";

                connection.query(query, [records], function(err2, result) {
                });

            }

            res.status(200).send(Mi.responseProcess(err, rows[0]));
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
    var book_id = req.param('book_id');
    var title = req.param('title');
    var content = req.param('content');
    var price = req.param('price');
    var author = req.param('author');
    var status = req.param('status');
    var images = req.param('images');
    var book_type = req.param('book_type');
    var lend_id = req.param('lend_id');


    var categories = req.param('category_id');

    if(!status)
    {
        status = 0;
    }

    var feature_image = "";

    if(images.length > 0)
    {
        feature_image =  images[0];
    }

    if(!author)
    {
        author = "";
    }


    connection.query("CALL  book_update(?,?,?,?,?,?,?,?);",[book_id,title,feature_image,content,price,author,status,book_type],function(err,rows)
    {
        if(!err)
        {

            if(lend_id || (lend_id != -1))
            {
                connection.query("CALL  lend_insert(?,?) ;",[lend_id,book_id],function(err,rows)
                {
                });
            }
            else
            {
                connection.query("CALL  lend_delete(?) ;",[book_id],function(err,rows)
                {
                });

            }

            if(images.length > 0)
            {

                var records = [] ;

                for (var i in images) 
                {
                    var unit = images[i];
                    records.push([book_id,unit]) ;
                }
                // res.status(200).send(Mi.responseProcess(err, records));

                var query = "INSERT INTO book_image(book_id,image) VALUES ?";

                connection.query(query, [records], function(err2, result) {

                });

                // connection.query("CALL  book_image_delete(?) ;",[book_id],function(err,rows)
                // {
                // });
            }


            if(categories.length > 0)
            {

                var records = [] ;

                for (var i in categories) 
                {
                    var unit = categories[i];
                    records.push([book_id,unit]) ;
                }
                var query = "INSERT INTO book_category(book_id,category_id) VALUES ?";

                connection.query("CALL  book_category_delete(?) ;",[book_id],function(err,rows)
                {
                    connection.query(query, [records], function(err2, result) {
                    });
                });

            }

            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });
});


router.post('/delete',function(req,res)
{
    var book_id = req.param('book_id');
    connection.query("CALL  book_delete(?) ;",[book_id],function(err,rows)
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


router.post('/take',function(req,res)
{
    var book_id = req.param('book_id');
    var user_id = req.param('user_id');

    connection.query("CALL  book_take(?,?) ;",[user_id,book_id],function(err,rows)
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



router.post('/comment/list',function(req,res)
{
    var target_id = req.param('target_id');

    connection.query("CALL  comment_list(?,?) ;",[target_id,1],function(err,rows)
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

router.post('/comment/insert',function(req,res)
{
    var user_id = req.param('user_id');
    var target_id = req.param('target_id');
    var content = req.param('content');

    connection.query("CALL  comment_insert(?,?,?,?,?) ;",[user_id,target_id,-1,content,1],function(err,rows)
    {
        pn_services.commentPush(target_id,user_id);
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




router.post('/user/select',function(req,res)
{
    var user_id = req.param('user_id');

    connection.query("CALL  book_user_select(?) ;",[user_id],function(err,rows)
    {
        pn_services.commentPush(target_id,user_id);
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
    connection.query("CALL  book_search_engine(?) ;",[keyword],function(err,rows)
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

router.post('/search/all',function(req,res)
{
    var keyword = req.param('keyword');
    connection.query("CALL  news_search_engine(?) ;",[keyword],function(err,rows)
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





router.post('/location',function(req,res)
{
    console.log("------Log");
    var user_id = req.param('user_id');
    var latitude = req.param('latitude');
    var longitude = req.param('longitude');
    var distance = req.param('distance');

    connection.query("CALL  book_location(?,?,?,?) ;",[user_id,latitude,longitude,distance],function(err,rows)
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

    var user_id = req.param('user_id');
    var book_id = req.param('book_id');
    var is_like = req.param('is_like');

    connection.query("CALL  book_like(?,?,?) ;",[user_id,book_id,is_like],function(err,rows)
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


router.post('/report',function(req,res)
{

    var user_id = req.param('user_id');
    var book_id = req.param('book_id');
    var content = req.param('content');

    connection.query("CALL  book_report(?,?,?) ;",[user_id,book_id,content],function(err,rows)
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

router.post('/trading',function(req,res)
{

    var load_type = req.param('load_type');
    var last_date = req.param('last_date');

    connection.query("CALL  book_trading(?,?) ;",[load_type,last_date],function(err,rows)
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

router.post('/feed',function(req,res)
{

    var load_type = req.param('load_type');
    var last_date = req.param('last_date');
    var user_id = req.param('user_id');
    console.log("last_date : %s \n,load_type : %s",last_date,load_type);


    connection.query("CALL  relation_id(?) ;",[user_id],function(err,rows)
    {
        if(!err)
        {
            var query = "" ;
            var response = rows[0];
            var user_id_arr = [];
            var book_type =  [4,9,2,3];
            user_id_arr.push(user_id);

            if(last_date.length == 0)
            {
                query = "SELECT  book.user_id ,book.date, book.id ,book.title,book.book_type,user.avatar,book.content,book.author,book.image,book.date,user.aliasname FROM book  LEFT JOIN user ON (user.id = book.user_id) where (book.user_id in (?)) AND ( book.book_type  IN (?)) OR (? =  'A') ORDER BY book.date DESC LIMIT 0,6";
                                console.log("%s","0");

            }
            else if (load_type == 0)
            {

            query = "SELECT  book.user_id,book.date , book.id ,book.title,book.book_type,user.avatar,book.content,book.author,book.image,book.date,user.aliasname FROM book  LEFT JOIN user ON (user.id = book.user_id) where (book.user_id in (?)) AND ( book.book_type  IN (?)) AND (book.date > DATE_FORMAT(?, '%Y-%m-%dT%TZ'))  ORDER BY book.date DESC LIMIT 0,6";
                                console.log("%s","1");


            }
            else
            {

                query = "SELECT  book.user_id,book.date , book.id ,book.title,book.book_type,user.avatar,book.content,book.author,book.image,book.date,user.aliasname FROM book  LEFT JOIN user ON (user.id = book.user_id) where (book.user_id in (?)) AND ( book.book_type  IN (?)) AND (book.date < DATE_FORMAT(?, '%Y-%m-%dT%TZ')) ORDER BY book.date DESC LIMIT 0,6";
                                console.log("%s","2");
            }


                console.log("%s",query);


                for (var i in response) 
                {
                    var unit = response[i].user_id;
                    user_id_arr.push(unit) ;
                }


            connection.query(query,[user_id_arr,book_type,last_date],function(err2,response2)
            {
                if(!err)
                {
                    res.status(200).send(Mi.responseProcess(err2, response2));
                }
                else
                {
                    res.status(200).send(Mi.responseProcess(err2, err2));
                }
            });

        }
        else
        {
            res.status(200).send(Mi.responseProcess("Error 1", response[0]));
        }
    });



});


router.post('/library',function(req,res)
{

    var user_id = req.param('user_id');
    var last_id = req.param('last_id');
    var category_id = req.param('category_id');
    var load_type =  req.param('load_type');



    var query = "";
    if(category_id == -1)
    {
        //load all
        if(load_type == 0)
        {
            query = "call book_library(?,?);"
        }
        else
        {
            query = "call book_library_more(?,?);"
        }

    }
    else
    {
        if(load_type == 0)
        {
            query = "call book_library_cat(?,?);"
        }
        else
        {
            query = "call book_library_cat_more(?,?);"
        }
    }
    console.log(query);
    console.log("last_id : %s",last_id);
    console.log("category_id : %s",category_id);

    connection.query(query,[last_id,category_id],function(err,rows)
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


router.post('/latest',function(req,res)
{
    var last_id =  req.param('last_id');
    var load_type =  req.param('load_type');
    var user_id =  req.param('user_id');


    if(!user_id)
    {
        user_id = -1;
    }
    var query = "";

    if(load_type == 0)
    {
        query =   " CALL book_latest(?,?) ;" 
    }
    else
    {
         query =   " CALL book_latest_more(?,?) ;" 
    }

    connection.query(query,[user_id,last_id],function(err,rows)
    {
        if(!err){

        
            var books = rows[0];
            var uniqueBook = [];
            for (var i in books) 
            {
                var unit = books[i];

                if(uniqueBook.length == 0)
                {
                    uniqueBook.push(unit)
                }
                else
                {
                    var isExist = false ;
                    for( j in uniqueBook)
                    {
                        var uniqueUnit = uniqueBook[j];
                        if(unit.id == uniqueUnit.id)
                        {
                            isExist = true;
                            break;
                        }

                    }

                    if(isExist == false)
                    {
                        uniqueBook.push(unit);
                    }

                }
            }

            for (i in uniqueBook)
            {
                var uniqueUnit = uniqueBook[i];
                var images = [];

                for (j in books)
                {
                    var unit = books[j];
                    if(uniqueUnit.id == unit.id)
                    {
                        if(unit.image.length > 0)
                        {
                            images.push(unit.image);
                        }
                    }
                }
                 uniqueUnit.images = images;
            }

            res.status(200).send(Mi.responseProcess("", uniqueBook));

        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi hệ thống", rows[0]));
        }
    });
});


router.post('/bf_book_latest',function(req,res)
{
    var last_id =  req.param('last_id');
    var load_type =  req.param('load_type');
    var user_id =  req.param('user_id');


    if(!user_id)
    {
        user_id = -1;
    }
    var query = "";

    if(load_type == 0)
    {
        query =   " CALL bf_book_latest(?,?) ;" 
    }
    else
    {
         query =   " CALL book_latest_more(?,?) ;" 
    }

    connection.query(query,[user_id,last_id],function(err,rows)
    {
        if(!err){

        
            var books = rows[0];
            var uniqueBook = [];
            for (var i in books) 
            {
                var unit = books[i];

                if(uniqueBook.length == 0)
                {
                    uniqueBook.push(unit)
                }
                else
                {
                    var isExist = false ;
                    for( j in uniqueBook)
                    {
                        var uniqueUnit = uniqueBook[j];
                        if(unit.id == uniqueUnit.id)
                        {
                            isExist = true;
                            break;
                        }

                    }

                    if(isExist == false)
                    {
                        uniqueBook.push(unit);
                    }

                }
            }

            for (i in uniqueBook)
            {
                var uniqueUnit = uniqueBook[i];
                var images = [];

                for (j in books)
                {
                    var unit = books[j];
                    if(uniqueUnit.id == unit.id)
                    {
                        if(unit.image.length > 0)
                        {
                            images.push(unit.image);
                        }
                    }
                }
                 uniqueUnit.images = images;
            }

            res.status(200).send(Mi.responseProcess("", uniqueBook));

        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi hệ thống", rows[0]));
        }
    });
});




router.post('/detail',function(req,res)
{
    var book_id =  req.param('book_id');

    connection.query("CALL  book_detail(?) ;",[book_id],function(err,rows)
    {
        if(!err)
        {

            var bookDetail = rows[0][0];
            var comment = rows[1];
            var media = rows[2];
            var category = rows[3];
            var lend  = rows[4];

            bookDetail.comment = comment;
            bookDetail.category = category;

            var images = [];

            for (var i in media)
            {
                images.push(media[i].image);
            }

            bookDetail.images = images;
            bookDetail.lend = lend;

            res.status(200).send(Mi.responseProcess("", bookDetail));

        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi hệ thống", rows));
        }
    });
});


router.post('/user/all',function(req,res)
{
    var user_id = req.param('user_id');
    var last_id = req.param('last_id');


    if(!last_id)
    {
        last_id = 0 ;
    }

    connection.query("CALL  book_user_all(?,?) ;",[user_id,last_id],function(err,rows)
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

router.post('/user/list',function(req,res)
{
    var book_id = req.param('book_id');
    connection.query("CALL  book_user_list(?) ;",[book_id],function(err,rows)
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

router.post('/user/',function(req,res)
{
    var user_id = req.param('user_id');
    var last_id = req.param('last_id');
    var book_type = req.param('book_type');


    if(!last_id)
    {
        last_id = 0 ;
    }

    connection.query("CALL  book_user(?,?,?) ;",[user_id,book_type,last_id],function(err,rows)
    {
        if(!err){

        
            var books = rows[0];
            var uniqueBook = [];
            for (var i in books) 
            {
                var unit = books[i];

                if(uniqueBook.length == 0)
                {
                    uniqueBook.push(unit)
                }
                else
                {
                    var isExist = false ;
                    for( j in uniqueBook)
                    {
                        var uniqueUnit = uniqueBook[j];
                        if(unit.id == uniqueUnit.id)
                        {
                            isExist = true;
                            break;
                        }

                    }

                    if(isExist == false)
                    {
                        uniqueBook.push(unit);
                    }

                }
            }

            for (i in uniqueBook)
            {
                var uniqueUnit = uniqueBook[i];
                var images = [];

                for (j in books)
                {
                    var unit = books[j];
                    if(uniqueUnit.id == unit.id)
                    {
                        if(unit.image.length > 0)
                        {
                            images.push(unit.image);
                        }
                    }
                }
                 uniqueUnit.images = images;
            }

            res.status(200).send(Mi.responseProcess("", uniqueBook));

        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi hệ thống", rows[0]));
        }
    });
});




module.exports = router;
