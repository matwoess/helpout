import 'package:flutter/material.dart';
import 'package:helpout/misc/demodata.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/chat.dart';
import 'package:helpout/model/message.dart';
import 'package:helpout/model/user.dart';
import 'package:intl/intl.dart';

import 'messages.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage();

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  Future<List<Chat>> _userChats;

  @override
  void initState() {
    super.initState();
    _userChats = getChats();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => startChatWithPreDefinedUser());
  }

  void startChatWithPreDefinedUser() {
    User chatUser = AppState.getInstance().chatUser;
    if (chatUser == null) {
      return;
    }
    Chat chat;
    _userChats.then((value) => chat = value.where((c) => c.otherUsername == chatUser.username).first);
    if (chat == null) {
      return;
    }
   User other;
    Future<User> user = DemoData.userByUsername(chat.otherUsername);
    user.then((user) => other = user);
    if (other == null) {
      return;
    }
    AppState.getInstance().chatUser = null;
    chat.isRead = true;
    setState(() {});
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MessagesPage(chat, other);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chat>>(future: _userChats,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading data...');
          } else {
                return Container(
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return ChatItem(snapshot.data[position]);
                    },
                    itemCount: snapshot.data.length,
                  ),
                );
          }
      });
  }

    
  static Future<List<Chat>> getChats() async {
    List<Chat> chats = await DemoData.getUserChats('my_username');
    return chats;
  }
}

class ChatItem extends StatefulWidget {
  final Chat chat;

  ChatItem(this.chat);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  Future<User> withUser;
  Future<Message> lastMsg;

  @override
  initState() {
    super.initState();
    withUser = getUser(widget.chat.otherUsername);
    lastMsg = widget.chat.lastMessage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: withUser, 
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading data...');
        } else {
          return GestureDetector(
            onTap: () {
              widget.chat.isRead = true;
              setState(() {});
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MessagesPage(widget.chat, snapshot.data);
              }));
            },
            child:  Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Image(image: AssetImage(snapshot.data.assetURI)),
                          maxRadius: 30,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data.name,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                FutureBuilder(future: lastMsg, 
                                  builder: (BuildContext context, AsyncSnapshot<Message> snapshotMsg) {
                                    if (snapshotMsg.connectionState == ConnectionState.waiting) {
                                      return Text('Loading data...');
                                    } else {
                                    return Text(
                                      snapshotMsg.data != null ? snapshotMsg.data.content : 'Error loading Message!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: widget.chat.isRead
                                              ? FontWeight.normal
                                              : FontWeight.bold)
                                );}})
                              ],
                            ),
                          )
                        ) 
                      ],
                    ),
                  ),
                  FutureBuilder(future: lastMsg, 
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshotMsg) {
                            if (snapshotMsg.connectionState == ConnectionState.waiting) {
                               return Text('Loading data...');
                            } else {
                               return Text(
                                 snapshotMsg.data != null ? DateFormat('MMMM d').format(DateTime.fromMillisecondsSinceEpoch(
                                      snapshotMsg.data.timeStamp)) : 'Invalid Date',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          widget.chat.isRead ? FontWeight.normal : FontWeight.bold),
                                );
                            }})
                ],
              )));
              }
      });
  }

  static Future<User> getUser(String username) {
    Future<User> user = DemoData.userByUsername(username);
    return user;
  }
}
