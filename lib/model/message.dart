class Message {
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

  Message.now(username, chatId, content) {
    this.msgId = 0; // TODO: new MSG-ID
    this.username = username;
    this.chatId = chatId;
    this.content = content;
    this.timeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  //TODO: extend all classes with equals methods!
}
