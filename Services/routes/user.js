var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');
var liConnection = require('../config/lidb');


router.post('/login',function(req,res)
{

    var phone = req.param('username');
    var password = req.param('password');
    connection.query("CALL  user_login(?,?);",[phone,password],function(err,rows)
    {
        if(!err)
        {

            if(rows[0])
            {
                res.status(200).send(Mi.responseProcess(err, rows[0]));

            }
            else
            {
                 res.status(200).send(Mi.responseProcess("Sai tên đăng nhập hoặc mật khẩu",""));
            }
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err));
        }
    });
});

router.post('/near',function(req,res)
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

router.post('/friends',function(req,res)
{

    var ID = req.param('user_id');
    connection.query("CALL  UserFriends(?);",[ID],function(err,rows)
    {
        if(!err)
        {
            if(rows[0].length != 0)
            {
                 res.status(200).send(Mi.responseProcess(err, rows[0]));
            }
            else
            {
                 res.status(200).send(Mi.responseProcess(err,""));
            }
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err));
        }
    });
});


router.post('/update/aa',function(req,res)
{

    var user_id = req.param('user_id');
    var aliasname = req.param('aliasname');
    var avatar = req.param('avatar');

    connection.query("CALL  user_update_aa(?,?,?);",[user_id,avatar,aliasname],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err));
        }
    });
});


router.post('/update/token',function(req,res)
{

    var user_id = req.param('user_id');
    var token = req.param('token');

    connection.query("CALL  user_update_token(?,?);",[user_id,token],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err));
        }
    });
});





router.post('/update/avatar',function(req,res)
{

    var user_id = req.param('user_id');
    var avatar = req.param('avatar');

    connection.query("CALL  user_update_avatar(?,?);",[user_id,avatar],function(err,rows)
    {
        if(!err)
        {
            if(rows[0].length != 0)
            {
                 res.status(200).send(Mi.responseProcess(err, rows[0]));
            }
            else
            {
                 res.status(200).send(Mi.responseProcess(err,""));
            }
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err));
        }
    });
});

router.post('/update/caption',function(req,res)
{

    var user_id = req.param('user_id');
    var caption = req.param('caption');

    connection.query("CALL  user_update_caption(?,?);",[user_id,caption],function(err,rows)
    {
        if(!err)
        {
            if(rows[0].length != 0)
            {
                 res.status(200).send(Mi.responseProcess(err, rows[0]));
            }
            else
            {
                 res.status(200).send(Mi.responseProcess(err,""));
            }
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err));
        }
    });
});



router.post('/contact',function(req,res)
{

    var user_id = req.param('user_id');
    connection.query("CALL  contact_list(?);",[user_id],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, ""));
        }
    });
});



router.post('/detail',function(req,res)
{

    var user_id = req.param('user_id');
    connection.query("CALL  user_detail(?);",[user_id],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, ""));
        }
    });
});

router.post('/permission',function(req,res)
{

    var permission_id = req.param('permission_id');
    connection.query("CALL  user_permission(?);",[permission_id],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, ""));
        }
    });
});




router.post('/consultant',function(req,res)
{

    var consultant_id = req.param('consultant_id');
    connection.query("CALL  user_consultant(?);",[consultant_id],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, ""));
        }
    });
});


router.post('/login/facebook',function(req,res)
{

    var username = req.param('username');
    connection.query("CALL  user_login_facebook(?);",[username],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, ""));
        }
    });
});





router.post('/register',function(req,res)
{

    var username = req.param('username');
    var password = req.param('password');

    connection.query("CALL  user_register(?,?);",[username,password],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Tên đăng nhập đã tồn tại", ""));
        }
    });
});

// router.post('/search',function(req,res)
// {

//     var user_id = req.param('user_id');
//     var phone = req.param('phone');

//     connection.query("CALL  user_search(?,?);",[user_id,phone],function(err,rows)
//     {
//         if(!err)
//         {
//             res.status(200).send(Mi.responseProcess(err, rows[0]));
//         }
//         else
//         {
//             res.status(200).send(Mi.responseProcess(err, ""));
//         }
//     });
// });



router.post('/changepass',function(req,res)
{

    var Username = req.param('user_id');
    var oldpass = req.param('old_password');
    var newpass = req.param('new_password');

    connection.query("CALL  USER_Change_Pass(?,?,?);",[Username,oldpass,newpass],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Tên đăng nhập đã tồn tại", ""));
        }
    });
});


router.post('/update/info',function(req,res)
{



    var user_id = req.param('user_id');
    var aliasname = req.param('aliasname');
    var phone = req.param('phone');
    var dob = req.param('dob');
    var gender = req.param('gender');
    var university_id = req.param('university_id');

    var province_id = req.param('province_id');
    var district_id = req.param('district_id');


    if(!province_id)
    {
        province_id = -1;
    }

    if(!district_id)
    {
        district_id = -1;
    }



    if(!university_id)
    {
        university_id = -1;
    }

    connection.query("CALL  user_update_info(?,?,?,?,?,?,?,?);",[user_id,aliasname,phone,dob,gender,university_id,province_id,district_id],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi không xác định, vui lòng thử lại sau", rows[0]));
        }
    });
});


router.post('/search',function(req,res)
{

    var keyword = req.param('keyword');

    connection.query("CALL  user_search_engine(?);",[keyword],function(err,rows)
    {
        if(!err)
        {
            res.status(200).send(Mi.responseProcess(err, rows[0]));
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi không xác định, vui lòng thử lại sau", rows[0]));
        }
    });
});


router.post('/info',function(req,res)
{
    var user_id = req.param('user_id');
    var target_user_id = req.param('target_user_id');
    connection.query("CALL  user_info(?,?);",[user_id,target_user_id],function(err,rows)
    {
        if(!err)
        {
            let response = rows[0] ;
            if(response.length > 0)
            {
                res.status(200).send(Mi.responseProcess(err, response[0]));
            }
            else
            {
                res.status(200).send(Mi.responseProcess("Lỗi không xác định, vui lòng thử lại sau", rows[0]));
            }
        }
        else
        {
            res.status(200).send(Mi.responseProcess("Lỗi không xác định, vui lòng thử lại sau", rows[0]));
        }
    });
});






module.exports = router;


// /*