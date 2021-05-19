import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/message.dart';

class Chat {
  final int chatId;
  final String username1;
  final String username2;
  bool isRead;
  Message lastMessage;

  Chat(this.chatId, this.username1, this.username2, this.isRead,
      this.lastMessage);

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
}
