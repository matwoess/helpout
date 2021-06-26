import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpout/misc/dbmanager.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chat>>(
        future: getChats(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return ChatItemCard(Chat.loading, User.loading);
                },
                itemCount: 4,
              ),
            );
          } else {
            if (snapshot.data.length == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'You did not start any conversation yet.\nStart one by requesting or offering to help!',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return Container(
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return ChatItem(snapshot.data[position], deleteChat);
                  },
                  itemCount: snapshot.data.length,
                ),
              );
            }
          }
        });
  }

  static Future<List<Chat>> getChats() async {
    List<Chat> chats = await DBManager.getUserChats(AppState.getInstance().accountData.username);
    return chats;
  }

  deleteChat(Chat chat) {
    DBManager.deleteChat(chat);
    setState(() {});
  }
}

class ChatItem extends StatefulWidget {
  final Chat chat;
  final Function deleteChatCallback;

  ChatItem(this.chat, this.deleteChatCallback);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  Future<User> withUser;
  var _tapPosition;
  bool highlight = false;

  @override
  initState() {
    super.initState();
    withUser = getUser(widget.chat.otherUsername);
    withUser.then((user) => startChatWithPreDefinedUser(user));
  }

  void startChatWithPreDefinedUser(User user) {
    User chatUser = AppState.getInstance().chatUser;
    if (chatUser != null && user == chatUser) {
      print('now starting chat with: ' + chatUser.username);
      AppState.getInstance().chatUser = null;
      enterChat(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: withUser,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ChatItemCard(widget.chat, User.loading);
        } else {
          return GestureDetector(
            onTap: () => enterChat(snapshot.data),
            onTapDown: storeTapPosition,
            onLongPress: () => showChatItemMenu(widget.chat),
            child: Container(
              color: highlight ? Theme.of(context).backgroundColor : null,
              child: ChatItemCard(widget.chat, snapshot.data),
            ),
          );
        }
      },
    );
  }

  void enterChat(User user) {
    if (!widget.chat.isRead) {
      widget.chat.isRead = true;
      DBManager.markAsRead(widget.chat);
      setState(() {});
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MessagesPage(widget.chat, user);
    })).then(onReturn);
  }

  FutureOr onReturn(dynamic value) {
    setState(() {});
  }

  static Future<User> getUser(String username) {
    Future<User> user = DBManager.getUserByUsername(username);
    return user;
  }

  storeTapPosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  showChatItemMenu(Chat chat) {
    highlight = true;
    setState(() {});
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    RelativeRect rect = RelativeRect.fromRect(_tapPosition & const Size(40, 40), Offset.zero & overlay.size);
    List<PopupMenuItem<Function>> menuItems = [
      PopupMenuItem(
        value: markAsRead,
        child: Row(
          children: <Widget>[
            Icon(Icons.mark_chat_read_outlined),
            SizedBox(width: 5),
            Text("Mark as read"),
          ],
        ),
      ),
      PopupMenuItem(
        value: widget.deleteChatCallback,
        child: Row(
          children: <Widget>[
            Icon(Icons.delete_outline_outlined),
            SizedBox(width: 5),
            Text("Delete"),
          ],
        ),
      )
    ];
    if (chat.isRead) menuItems.removeAt(0); // don't show "Mark as read" if chat already is
    showMenu(
      context: context,
      position: rect,
      items: menuItems,
    ).then<void>((Function toExecute) {
      highlight = false;
      setState(() {});
      if (toExecute == null) return; // no selection
      setState(() {
        toExecute(widget.chat);
      });
    });
  }

  markAsRead(Chat chat) {
    chat.isRead = true;
    DBManager.markAsRead(widget.chat);
  }
}

class ChatItemCard extends StatelessWidget {
  final Chat chat;
  final User withUser;

  ChatItemCard(this.chat, this.withUser);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        FutureBuilder(
                            future: chat.lastMessage(),
                            builder: (BuildContext context, AsyncSnapshot<Message> snapshotMsg) {
                              if (snapshotMsg.connectionState == ConnectionState.waiting) {
                                return Text('Loading data...');
                              } else {
                                return Text(
                                    snapshotMsg.data != null ? snapshotMsg.data.content : 'Error loading Message!',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: chat.isRead ? FontWeight.normal : FontWeight.bold));
                              }
                            })
                      ],
                    ),
                  ))
                ],
              ),
            ),
            FutureBuilder(
                future: chat.lastMessage(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshotMsg) {
                  if (snapshotMsg.connectionState == ConnectionState.waiting) {
                    return Text('Loading data...');
                  } else {
                    return Text(
                      snapshotMsg.data != null
                          ? DateFormat('MMMM d').format(DateTime.fromMillisecondsSinceEpoch(snapshotMsg.data.timeStamp))
                          : 'Invalid Date',
                      style: TextStyle(fontSize: 16, fontWeight: chat.isRead ? FontWeight.normal : FontWeight.bold),
                    );
                  }
                })
          ],
        ));
  }
}
