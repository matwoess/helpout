import 'package:flutter/material.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/chat.dart';
import 'package:helpout/model/message.dart';
import 'package:helpout/model/user.dart';

class MessagesPage extends StatefulWidget {
  final Chat chat;
  final User withUser;

  MessagesPage(this.chat, this.withUser);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<MessagesPage> {
  Future<List<Message>> _chatHistory;
  User _accountData = AppState.getInstance().accountData;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatHistory = getHistory(widget.chat);
  }

  void sendMessage() async {
    DBManager.insertMessage(widget.chat.chatId, _accountData.username, _messageController.text);
    await setState(() {
      _chatHistory = getHistory(widget.chat);
      _messageController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _chatHistory, 
      builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading data...');
        } else {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 16,
                title: Container(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        child: Image(image: AssetImage(widget.withUser.assetURI)),
                        maxRadius: 20,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.withUser.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Online",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.info),
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
                        child: Align(
                          alignment:
                              (snapshot.data[index].username == _accountData.username
                                  ? Alignment.topRight
                                  : Alignment.topLeft),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            // TODO: replace with better colors
                            color:
                                snapshot.data[index].username == _accountData.username
                                    ? Theme.of(context).backgroundColor
                                    : Theme.of(context).secondaryHeaderColor,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                snapshot.data[index].content,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: FloatingActionButton(
                                heroTag: 'attach',
                                onPressed: () {},
                                child: Icon(Icons.add),
                                backgroundColor: Theme.of(context).accentColor,
                                elevation: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: "Write message...",
                                //border: InputBorder.none
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            heroTag: 'send',
                            onPressed: () {
                              sendMessage();
                            },
                            child: Icon(Icons.send),
                            backgroundColor: Theme.of(context).accentColor,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      });
  }

  static Future<List<Message>> getHistory(Chat chat) async {
    List<Message> mgs = await DBManager.getChatHistory(chat);
    return mgs;
  }
}


