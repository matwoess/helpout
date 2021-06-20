import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/message.dart';

class Chat {
  static final Chat loading = Chat(-1, '', '', true);

  final int chatId;
  final String username1;
  final String username2;
  bool isRead;

  Future<Message> lastMessage() async {
    if (this == loading) {
      return Future.value(Message.loadingMyself);
    }
    List<Message> msgs = await DBManager.getChatHistory(this);
    if (msgs.isEmpty)
      return Message.now(0, otherUsername, chatId, 'Write the first Message!');
    else
      return msgs.last;
  }

  Chat(this.chatId, this.username1, this.username2, this.isRead);

  String get otherUsername {
    String myUsername = AppState.getInstance().accountData.username;
    if (this.username1 == myUsername) {
      return this.username2;
    } else if (this.username2 == myUsername) {
      return this.username1;
    } else {
      return 'ERROR: this is not my chat!';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Chat && runtimeType == other.runtimeType && chatId == other.chatId;

  @override
  int get hashCode => chatId.hashCode;
}
