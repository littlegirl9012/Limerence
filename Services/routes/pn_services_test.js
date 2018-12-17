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
    production: false
  };

  var apnProvider = new apn.Provider(options);




router.post('/push',function(req,res)
{
    var token = req.param('token');
    var title = req.param('title');
    var name = req.param('name');

          console.log('From : %s ------Token : %s', name,token);

    request_push(token,title,name,"Đã đã gửi cho bạn 1 tin nhắn");


});


function request_push(token,title,from_id,content)
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


