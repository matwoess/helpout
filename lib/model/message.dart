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

  Message.empty() {
    this.msgId = 0;
    this.username = '';
    this.chatId = 0;
    this.content = 'demo content';
    this.timeStamp = DateTime.now().millisecondsSinceEpoch;
  }
}
