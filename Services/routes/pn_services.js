var express = require('express');
var router  = express.Router();
var Mi = require('../model/mi');
var connection = require('../config/db');
var apn = require('apn');


var options = {
    token: {
      key: "/home/dephoanmy.vn/public_html/DHMServices/config/PSKey.p8",
      keyId: "NT365X9UB6",
      teamId: "9MP9PYH84M"
    },
    production: true
  };

  var apnProvider = new apn.Provider(options);




function limerencePush(pn_type,from_id, to_id, target_id,content)
{


  //function ps_services_confernce(token,title,from_id,content)

    connection.query("CALL  pn_services_conference_info(?,?,?,?);",[pn_type,from_id,to_id,target_id],function(err,rows)
    {
        if(!err)
        {
          var name = rows[0][0].aliasname;
          var token = rows[1][0].token;
          console.log('From : %s ------Token : %s', name,token);
          ps_services_confernce(token,name,from_id,"Đã đã gửi cho bạn 1 tin nhắn");
        }
        else
        {
            res.status(200).send(Mi.responseProcess(err, err));
        }
    });



  // var options = {
  //   token: {
  //     key: "/home/dephoanmy.vn/public_html/DHMServices/config/PSKey.p8",
  //     keyId: "NT365X9UB6",
  //     teamId: "9MP9PYH84M"
  //   },
  //   production: false
  // };

  // var apnProvider = new apn.Provider(options);

  // Enter the device token from the Xcode console
  
};

function commentPush(target_id,user_id)
{



    connection.query("CALL  pn_services_comment_info(?,?);",[target_id,user_id],function(err,rows)
    {
        if(!err)
        {
          var name = rows[0][0].aliasname;
          var title = rows[1][0].title;
          var tokenList = rows[2];


          var records = [] ;

          for (var i in tokenList) 
          {
            var unit = tokenList[i].token;
            records.push(unit) ;
          }

          console.log("targetID  : %s",target_id);
          console.log("name  : %s",user_id);          
          console.log("name  : %s",rows[0].aliasname);

          console.log("token List : %s",records);

          var content = "Đã bình luận bài " + "\"" + title + "\"" 

          ps_services_confernce(records,name,user_id,content);
        }
        else
        {
        }
    });



  // var options = {
  //   token: {
  //     key: "/home/dephoanmy.vn/public_html/DHMServices/config/PSKey.p8",
  //     keyId: "NT365X9UB6",
  //     teamId: "9MP9PYH84M"
  //   },
  //   production: false
  // };

  // var apnProvider = new apn.Provider(options);

  // Enter the device token from the Xcode console
  
};


function ps_services_confernce(token,title,from_id,content)
{

  var deviceToken = token;

  console.log("call token :  %s",deviceToken);

var notification = new apn.Notification({
    aps: {
        "content-available" : 1
    }
});
  // Specify your iOS app's Bundle ID (accessible within the project editor)
  notification.topic = 'KieuVan.MiBooks';
  notification.expiry = Math.floor(Date.now() / 1000) + 3600;
  notification.badge = 1;
  notification.sound = 'ping.aiff';
  notification.title = title;
  notification.body =  content ;

  var pn_message  = {} ;
  pn_message['pn_message_type'] = 1;
  pn_message['user_id'] = from_id;
  pn_message['aliasname'] = title;

  var d = new Date();
  var n = d.toISOString();
  pn_message['date'] = n;

  console.log("Message :  %s",pn_message);


  // Send any extra payload data with the notification which will be accessible to your app in didReceiveRemoteNotification
  notification.payload = {
    message: pn_message
  };

  // Actually send the notification
  apnProvider.send(notification, deviceToken).then(function(result) {  
      // Check the result for any failed devices
          console.log("Error : %s",result.failed);

  });

}

function ISODateString(d) {
    function pad(n) {return n<10 ? '0'+n : n}
    return d.getUTCFullYear()+'-'
         + pad(d.getUTCMonth()+1)+'-'
         + pad(d.getUTCDate())+'T'
         + pad(d.getUTCHours())+':'
         + pad(d.getUTCMinutes())+':'
         + pad(d.getUTCSeconds())+'Z'
}



module.exports.limerencePush = limerencePush;  
module.exports.commentPush = commentPush;  


