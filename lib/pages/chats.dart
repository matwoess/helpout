import 'package:flutter/material.dart';
import 'package:helpout/misc/demodata.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/chat.dart';
import 'package:helpout/model/user.dart';
import 'package:intl/intl.dart';

import 'messages.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage();

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List<Chat> _userChats;

  @override
  void initState() {
    super.initState();
    _userChats = DemoData.getUserChats();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => startChatWithPreDefinedUser());
  }

  void startChatWithPreDefinedUser() {
    User chatUser = AppState.getInstance().chatUser;
    if (chatUser == null) {
      return;
    }
    Chat chat =
        _userChats.where((c) => c.otherUsername == chatUser.username).first;
    if (chat == null) {
      return;
    }
    User other = DemoData.userByUsername(chat.otherUsername);
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
    return Container(
      child: ListView.builder(
        itemBuilder: (context, position) {
          return ChatItem(_userChats[position]);
        },
        itemCount: _userChats.length,
      ),
    );
  }
}

class ChatItem extends StatefulWidget {
  final Chat chat;

  ChatItem(this.chat);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  User withUser;

  @override
  initState() {
    super.initState();
    withUser = DemoData.userByUsername(widget.chat.otherUsername);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.chat.isRead = true;
        setState(() {});
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MessagesPage(widget.chat, withUser);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Image(image: AssetImage(withUser.assetURI)),
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
                            withUser.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.chat.lastMessage.content,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: widget.chat.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              DateFormat('MMMM d').format(DateTime.fromMillisecondsSinceEpoch(
                  widget.chat.lastMessage.timeStamp)),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      widget.chat.isRead ? FontWeight.normal : FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
