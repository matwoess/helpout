class Message {
  static final Message loadingMyself = Message(-1, 'my_username', -1, 'Loading...', 0);
  static final Message loadingOther = Message(-2, '', -1, 'Loading...', 0);
  static final Message sending = Message(-3, 'my_username', -1, 'Sending...', 0);

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message && runtimeType == other.runtimeType && msgId == other.msgId && chatId == other.chatId;

  @override
  int get hashCode => msgId.hashCode ^ chatId.hashCode;
}
