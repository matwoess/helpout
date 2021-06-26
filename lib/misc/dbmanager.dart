import 'package:helpout/misc/constants.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/chat.dart';
import 'package:helpout/model/message.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/util/converter.dart';
import 'package:helpout/util/scorer.dart';
import 'package:postgrest/postgrest.dart';

class DBManager {
  // TODO: remove
  static Future<User> getMyAccount() async {
    return getUserByUsername('my_username');
  }

  static Future<User> getUserByUsername(String username) async {
    PostgrestResponse result = await AppState.getInstance()
        .connection
        .from('user')
        .select(Constants.userTableData)
        .filter('username', 'eq', username)
        .execute();
    if (result.toJson()['data'].length == 0) {
      return null;
    }
    var user = result.toJson()['data'][0];
    return User(
        user['username'],
        user['password'],
        user['firstname'] + ' ' + user['lastname'],
        Converter.convertToGender(user['gender']['name']),
        Region(user['zipcode'].toString(), user['region']['name']),
        user['price'],
        user['description'],
        user['asset']);
  }

  static Future<List<User>> getOtherUsers() async {
    PostgrestResponse result = await AppState.getInstance()
        .connection
        .from('user')
        .select(Constants.userTableData)
        .filter('username', 'neq', 'my_username')
        .execute();
    List<User> users = [];
    for (final user in result.toJson()['data']) {
      users.add(User(
          user['username'],
          user['password'],
          user['firstname'] + ' ' + user['lastname'],
          Converter.convertToGender(user['gender']['name']),
          Region(user['zipcode'].toString(), user['region']['name']),
          user['price'],
          user['description'],
          user['asset']));
    }
    return users;
  }

  static Future<List<User>> getUsersByRegion(Region region) async {
    if (region == null) {
      return getOtherUsers();
    }
    PostgrestResponse result = await AppState.getInstance()
        .connection
        .from('user')
        .select(Constants.userTableData)
        .filter('zipcode', 'eq', region.postcode)
        .execute();
    List<User> users = [];
    for (final user in result.toJson()['data']) {
      users.add(User(
          user['username'],
          user['password'],
          user['firstname'] + ' ' + user['lastname'],
          Converter.convertToGender(user['gender']['name']),
          region,
          user['price'],
          user['description'],
          user['asset']));
    }
    return users;
  }

  static Future<List<Region>> getAvailableRegions() async {
    PostgrestResponse result = await AppState.getInstance().connection.from('city').select().execute();
    List<Region> regions = [];
    for (final region in result.toJson()['data']) {
      regions.add(Region(region['zipcode'].toString(), region['name']));
    }
    return regions;
  }

  static Future<List<Chat>> getUserChats(String username) async {
    PostgrestResponse result = await AppState.getInstance()
        .connection
        .from('chat')
        .select()
        .or('username1.eq.' + username + ',username2.eq.' + username)
        .execute();
    List<Chat> chats = [];
    for (final chat in result.toJson()['data']) {
      var mode;
      if (username == chat['username1'])
        mode = 'isread1';
      else
        mode = 'isread2';
      chats.add(Chat(chat['chatid'], chat['username1'], chat['username2'], chat[mode]));
    }
    return chats;
  }

  static Future<List<Message>> getChatHistory(Chat chat) async {
    PostgrestResponse result =
        await AppState.getInstance().connection.from('message').select().filter('chatid', 'eq', chat.chatId).execute();
    List<Message> messages = [];
    if (result.toJson()['data'] != null) {
      for (final message in result.toJson()['data']) {
        messages.add(Message(
            message['msgid'],
            message['username'],
            message['chatid'],
            Converter.convertToChatText(message['content']),
            Converter.convertToMillisecondsSinceEpoch(message['timestamp'])));
      }
    }
    return messages;
  }

  static Future<int> getNextMsgId(int chatId) async {
    PostgrestResponse result = await AppState.getInstance()
        .connection
        .from('message')
        .select('msgid')
        .filter('chatid', 'eq', chatId)
        .execute();
    if (result.toJson()['data'].isEmpty) return 0;
    return result.toJson()['data'].last['msgid'] + 1;
  }

  // inserts

  static Future<Message> insertMessage(Chat chat, String username, String text) async {
    int newId = await getNextMsgId(chat.chatId);
    var mode;
    if (AppState.getInstance().accountData.username == chat.username1)
      mode = "isread2";
    else
      mode = "isread1";
    await AppState.getInstance().connection.from('chat').update({mode: false}).eq("chatid", chat.chatId).execute();
    Message newMsg = Message.now(newId, username, chat.chatId, text);
    await AppState.getInstance().connection.from('message').insert([
      {
        'chatid': chat.chatId,
        'username': username,
        'content': text,
        'timestamp': Converter.convertToTimeStamp(newMsg.timeStamp),
        'msgid': newMsg.msgId
      }
    ]).execute();
    return newMsg;
  }

  static void updateUser(String username, String name, String desc) async {
    String firstname = name.split(" ")[0];
    String lastname = name.split(" ").length == 2 ? name.split(" ")[1] : "";
    await AppState.getInstance()
        .connection
        .from('user')
        .update({"firstname": firstname, "lastname": lastname, "description": desc})
        .eq("username", username)
        .execute();
  }

  static Future<int> getScore(String userId) async {
    PostgrestResponse result =
        await AppState.getInstance().connection.from('user').select('score').filter('userid', 'eq', userId).execute();
    return result.toJson()['data'].first['score'];
  }

  static Future<int> getLevel(String userId) async {
    PostgrestResponse result =
        await AppState.getInstance().connection.from('user').select('level').filter('userid', 'eq', userId).execute();
    return result.toJson()['data'].first['level'];
  }

  void updateScore(String userId, Scorer scorer) async {
    await AppState.getInstance()
        .connection
        .from('user')
        .update({"score": scorer.calculateResult.toInt()})
        .eq("username", userId)
        .execute();
  }

  void updateLevel(String userId, Scorer scorer) async {
    await AppState.getInstance()
        .connection
        .from('user')
        .update({"level": scorer.calculateResult.toInt()})
        .eq("username", userId)
        .execute();
  }

  static void markAsRead(Chat chat) async {
    var mode;
    if (AppState.getInstance().accountData.username == chat.username1)
      mode = "isread1";
    else
      mode = "isread2";
    await AppState.getInstance().connection.from('chat').update({mode: true}).eq("chatid", chat.chatId).execute();
  }

  static void deleteChat(Chat chat) async {
    await AppState.getInstance().connection.from('chat').delete().eq("chatid", chat.chatId).execute();
  }

  static createChatIfNeeded(User user) async {
    print('checking for existing chats with ${user.username}');
    List<Chat> chatHistory = await DBManager.getUserChats(AppState.getInstance().accountData.username);
    for (Chat c in chatHistory) {
      if (c.otherUsername == user.username) {
        print('existing chat found.');
        return;
      }
    }
    print('no chat yet with ${user.username} yet. creating..');
    await DBManager.createChatWithUser(user);
  }

  static createChatWithUser(User user) async {
    var response = await AppState.getInstance().connection.from('chat').insert([
      {
        'chatid': await getNextChatId(),
        'isread1': false,
        'isread2': false,
        'username1': AppState.getInstance().accountData.username,
        'username2': user.username
      }
    ]).execute();
  }

  static Future<int> getNextChatId() async {
    PostgrestResponse result =
        await AppState.getInstance().connection.from('chat').select('chatid').order('chatid').execute();
    if (result.toJson()['data'].isEmpty) return 0;
    return result.toJson()['data'].first['chatid'] + 1;
  }

  static Future<User> createUser(String firstname, String lastname, String username, String password, Region region,
      Gender gender, String assetURI, int price) async {
    User createdUser = new User(username, password, firstname + ' ' + lastname, gender, region, price, "", assetURI);
    checkRegion(region);
    PostgrestResponse result = await AppState.getInstance().connection.from('user').insert({
      "firstname": firstname,
      "lastname": lastname,
      "description": "",
      "username": username,
      "price": price,
      "asset": assetURI,
      "zipcode": int.parse(region.postcode),
      "gid": 2,
      "level": 1,
      "score": 0,
      "password": password
    }).execute();
    return createdUser;
  }

  static void checkRegion(Region region) async {
    PostgrestResponse result = await AppState.getInstance()
        .connection
        .from('city')
        .select('zipcode')
        .eq('zipcode', int.parse(region.postcode))
        .execute();
    if (result.toJson()['data'].isEmpty) {
      print('creating region: ' + region.toString());
      await AppState.getInstance()
          .connection
          .from('city')
          .insert({"zipcode": int.parse(region.postcode), "name": region.city}).execute();
    }
  }
}
