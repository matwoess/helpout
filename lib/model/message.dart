import 'package:helpout/model/appstate.dart';

class Message {
  static final Message loadingOther = Message(-2, '', -1, 'Loading...', 0);

  int msgId;
  String username;
  int chatId;
  String content;
  int timeStamp;

  Message(msgId, username, chatId, content, timestamp) {
    this.msgId = msgId;
    this.username = username;
    this.chatId = chatId;
    this.content = content;
    this.timeStamp = timestamp;
  }

  Message.now(msgId, username, chatId, content) {
    this.msgId = msgId;
    this.username = username;
    this.chatId = chatId;
    this.content = content;
    this.timeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  Message.loadingMyself() {
    this.msgId = -1;
    this.username = AppState.getInstance().accountData.username;
    this.chatId = -1;
    this.content = 'Loading...';
    this.timeStamp = 0;
  }

  Message.sending() {
    this.msgId = -3;
    this.username = AppState.getInstance().accountData.username;
    this.chatId = -1;
    this.content = 'Sending...';
    this.timeStamp = 0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message && runtimeType == other.runtimeType && msgId == other.msgId && chatId == other.chatId;

  @override
  int get hashCode => msgId.hashCode ^ chatId.hashCode;
}
