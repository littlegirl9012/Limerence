var express = require('express');
var app = express();
var server = require("http").createServer(app);
var io = require("socket.io").listen(server);
var fs = require("fs");
var Mi = require('./model/mi');
var connection = require('./config/db');
var pn_services  =   require('./routes/pn_services');


// var bodyParser    = require("body-parser");
// var multer  =   require('multer');
// app.use(bodyParser.urlencoded({ extended: false }));
// app.use(bodyParser.json());
// fs = require('fs');

server.listen(process.env.PORT || 9802);
io.sockets.setMaxListeners(0);
server.setMaxListeners(0);
app.setMaxListeners(0);
io.setMaxListeners(0);


io.sockets.on('connection',function(socket)
{
	var user_id =  socket.handshake.query['user_id'];
	var SocketID = socket.id ;

	socket.emit('UserLoginSuccess',{UserID : user_id});


	connection.query("CALL  device_update_socket(?,?);",[user_id,SocketID],function(err,rows)
	{
		socket.emit('UserLoginSuccess',{socket_id : SocketID});


	});


	connection.query("CALL  conversation_list(?);",[user_id],function(err,rows)
	{

		if(!err)
        {
			socket.emit('ConversationReceive',rows[0]);
        }
        else
        {
			socket.emit('ConversationReceive',[]);
        }

	});

	connection.query("CALL  contact_list(?);",[user_id],function(err,rows)
	{
		socket.emit('ContactReceive',rows[0]);
	});


	connection.query("CALL  contact_socket_id(?);",[user_id],function(err,rows)
	{

		var socketList = rows[0];
        for (var i in socketList) 
        {
        	var unitSocketId = socketList[i].socket_id;

			if (io.sockets.connected[unitSocketId]) 
			{ 
				io.to(unitSocketId).emit('ContactOnline',user_id);
			}
        }
	});


	socket.on('disconnect', function()
	{
		connection.query("CALL  contact_socket_id(?);",[user_id],function(err,rows)
		{
			var socketList = rows[0];
	        for (var i in socketList) 
	        {
	        	var unitSocketId = socketList[i].socket_id;

				if (io.sockets.connected[unitSocketId]) 
				{ 
					io.to(unitSocketId).emit('ContactOffline',user_id);
				}
	        }
		});		
	});





	socket.on('SearchEngine', function(data)
	{
	
		var keyword = data.keyword ;
		var last_id = 0 ;
		connection.query("CALL  search_engine(?);",[keyword,last_id],function(err,rows)
		{
			socket.emit('SearchEngine',rows[0]);

		});

	});

	socket.on('BookSearch', function(data)
	{
	
		var keyword = data.keyword ;
		connection.query("CALL  book_search_engine(?);",[keyword],function(err,rows)
		{
			socket.emit('BookSearch',rows[0]);

		});

	});


	socket.on('NewsSearch', function(data)
	{
	
		var keyword = data.keyword ;
		connection.query("CALL  news_search_engine(?);",[keyword],function(err,rows)
		{
			socket.emit('NewsSearch',rows[0]);
		});
	});


	socket.on('UserSearch', function(data)
	{
	
		var keyword = data.keyword ;
		connection.query("CALL  user_search_engine(?);",[keyword],function(err,rows)
		{
			if(!err)
	        {
				socket.emit('UserSearch',rows[0]);
	        }
	        else
	        {
				socket.emit('UserSearch',[]);
	        }


		});

	});


	socket.on('AuthorSearch', function(data)
	{
	
		var keyword = data.keyword ;
		connection.query("CALL  author_search_engine(?);",[keyword],function(err,rows)
		{
			socket.emit('AuthorSearch',rows[0]);

		});

	});

	socket.on('ConversationReceive', function(data)
	{
	
		var user_id = data.user_id ;

		connection.query("CALL  conversation_list(?);",[user_id],function(err,rows)
		{
			if(!err)
	        {
				socket.emit('ConversationReceive',rows[0]);
	        }
	        else
	        {
				socket.emit('ConversationReceive',[]);
	        }
		});
	});

	socket.on('ConversationMarkRead', function(data)
	{
	
		var user_id = data.user_id ;
		var target_user_id = data.target_user_id ;

		connection.query("CALL  conversation_mark_read(?,?);",[user_id,target_user_id],function(err,rows)
		{
			
		});

	});






	socket.on('MessageSend', function(data)
	{
	
		var user_id = data.user_id ;
		var target_user_id =  data.target_user_id ;
		var content = data.content ;
		var message_type = 1;

		if(data.message_type)
		{
			message_type = data.message_type;
		}


//function limerencePush(pn_type,from_id, to_id, target_id)

		connection.query("CALL  message_insert(?,?,?,?);",[user_id,target_user_id,content,message_type],function(err,rows)
		{
			pn_services.limerencePush(1,user_id,target_user_id,1,content);

			console.log("0");

			if(rows.length >2)
			{
				console.log("1");
				var messageDetail = rows[0];
				var deviceTarget = rows[1];
				if(deviceTarget.length > 0)
				{
					console.log("2");

					var userTarget = deviceTarget[0];

					if(messageDetail.length > 0)
					{
						console.log("3");



						var conversation_id =  messageDetail[0].conversation_id ;

          				console.log('conversaionID  : %s', conversation_id);


						//updae conversation cho nguoi gui
						connection.query("CALL  conversation_detail(?,?);",[user_id,conversation_id],function(err,conversation_row)
						{

							if(!err)
							{
								var conversation =  conversation_row[0] ;
								socket.emit('ConversationUpdateItem',conversation);
								socket.emit('MessageReceive',messageDetail[0]);
							}
						});

						//update conversation cho nguoi nhan
						connection.query("CALL  conversation_detail(?,?);",[target_user_id,conversation_id],function(err,conversation_row)
						{
							if(!err)
							{
								var conversation =  conversation_row[0] ;
								io.to(userTarget.socket_id).emit('ConversationUpdateItem',conversation);
								io.to(userTarget.socket_id).emit('MessageReceive',messageDetail[0]);

							}

						});
					}
				}
			}
		});

	});

	socket.on('MessageLatest', function(data)
	{
	
		var user_id = data.user_id ;
		var target_user_id =  data.target_user_id ;
		var message_id =  data.message_id ;

		if(!message_id)
		{
			message_id = 0;
		}

		connection.query("CALL  message_latest(?,?,?);",[user_id,target_user_id,message_id],function(err,rows)
		{
			if(!err)
	        {
	        	var messageList = rows[0]
	        	if(messageList.length > 0)
	        	{
	        		socket.emit('MessageLatest',messageList.reverse());
	        	}
	        	else
	        	{
	        		
	        	}

	        }
	        else
	        {
				//socket.emit('MessageLatest',[]);
	        }
		});

	});

	socket.on('MessageHistory', function(data)
	{
	
		var message_id = data.message_id ;
		var target_user_id =  data.target_user_id ;
		connection.query("CALL  message_history(?);",[message_id],function(err,rows)
		{
			socket.emit('MessageHistory',rows[0].reverse());
		});

	});

	socket.on('MessageReceive', function(data)
	{
	
		var user_id = data.user_id ;
		var target_user_id =  data.target_user_id ;
		connection.query("CALL  message_inset(?,?);",[user_id,target_user_id,content],function(err,rows)
		{

			var messageDetail = rows[0];
			var deviceTarget = rows[1];

			socket.emit('LatestMessage',messageDetail);


			io.to(item.SocketID).emit('RefreshNotify',{ConversationHasNewMessage : notifyCountData[0].length})


		});


	});

	
	socket.on('MessageRead', function(data)
	{
	
		var user_id = data.user_id ;
		var target_user_id =  data.target_user_id ;
		connection.query("CALL  message_inset(?,?);",[user_id,target_user_id,content],function(err,rows)
		{
			socket.emit('LatestMessage',{result : rows[0]});
		});


	});


	socket.on('MessageAfter', function(data)
	{
	
		var user_id = data.user_id ;
		var target_user_id =  data.target_user_id ;
		connection.query("CALL  message_inset(?,?);",[user_id,target_user_id,content],function(err,rows)
		{
			socket.emit('LatestMessage',{result : rows[0]});
		});

	});






//-----------------------------------------------------------CONTACT

	socket.on('ContactCancel', function(data)
	{
		var contact_id = data.contact_id ;
		var user_id = data.user_id ;
		var target_user_id = data.target_user_id ;
		connection.query("CALL  contact_delete(?,?,?);",[user_id,target_user_id,contact_id],function(err,rows)
		{
			contactInfo(user_id,target_user_id);
		});
	});



	socket.on('ContactDeny', function(data)
	{
		var contact_id = data.contact_id ;
		var user_id = data.user_id ;
		var target_user_id = data.target_user_id ;
		connection.query("CALL  contact_delete(?,?,?);",[user_id,target_user_id,contact_id],function(err,rows)
		{
			contactInfo(user_id,target_user_id);
		});

	});

	socket.on('ContactAccept', function(data)
	{
	
		var contact_id = data.contact_id ;
		var user_id = data.user_id ;
		var target_user_id = data.target_user_id ;

		connection.query("CALL  contact_accept(?,?,?);",[user_id,target_user_id,contact_id],function(err,rows)
		{
			contactInfo(user_id,target_user_id);
		});

	});


	socket.on('ContactAdd', function(data)
	{
	
		var user_id = data.user_id ;
		var target_user_id = data.target_user_id ;

		connection.query("CALL  contact_insert(?,?);",[user_id,target_user_id],function(err,rows)
		{
			contactInfo(user_id,target_user_id);
		});

	});

	function contactInfo(use_id, target_user_id)
	{
		connection.query("CALL  contact_info(?,?);",[user_id,target_user_id],function(err,rows)
		{
			var userInfo = rows[0][0];
			var userSocket = rows[1][0].socket_id;

			var targetInfo = rows[2][0]; 
			var targetSocket = rows[3][0].socket_id;

			if (io.sockets.connected[userSocket]) 
			{ 
				io.to(userSocket).emit('ContactInfo',userInfo);
			}
			if (io.sockets.connected[targetSocket]) 
			{ 
				io.to(targetSocket).emit('ContactInfo',targetInfo);
			}
		});
	}

	/*
	Hàm này trả về contact list, bao gồm những người là bạn bè, đã gửi yêu cầu kết bạn, hoặc nhận được yêu cầu kết bạn
	*/

	socket.on('ContactList', function(data)
	{

	
		var user_id = data.user_id ;
		connection.query("CALL  contact_list(?);",[user_id],function(err,rows)
		{
			socket.emit('ContactReceive',rows[0]);
		});

	});



	/*
	Hàm này trả về node contact, và trạng thái kết bạn
	*/
	socket.on('ContactInfo', function(data)
	{
		var user_id = data.user_id ;
		var target_user_id = data.target_user_id ;

		connection.query("CALL  user_info(?,?);",[user_id,target_user_id],function(err,rows)
		{

	        if(!err)
	        {
	            let response = rows[0] ;
	            if(response.length > 0)
	            {
					socket.emit('ContactInfo',response[0]);
	            }
	        }
		});

	});



	socket.on('ConversationLastMessage', function(data)
	{
		var user_id = data.conversation_id ;
		connection.query("CALL  contact_list(?);",[user_id],function(err,rows)
		{
			socket.emit('ContactReceive',rows[0]);
		});
	});


})


