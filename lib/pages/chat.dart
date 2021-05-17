import 'package:flutter/material.dart';
import 'package:helpout/misc/demodata.dart';
import 'package:helpout/model/appstate.dart';

class ChatPage extends StatefulWidget {
  ChatPage();

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> _chatHistory;

  @override
  void initState() {
    super.initState();
    _chatHistory = DemoData.getChatHistory(AppState.getInstance().chatPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (context, position) {
            return Text(_chatHistory[position]);
          },
          itemCount: _chatHistory.length),
    );
  }
}
