import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/chat.dart';
import 'package:helpout/model/message.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/misc/constants.dart';
import 'package:helpout/util/converter.dart';
import 'package:helpout/util/scorer.dart';
import 'package:postgrest/postgrest.dart';

class DBManager {
  /*static final _availableRegions = [
    Region('4020', 'Linz'),
    Region('4030', 'Linz'),
    Region('4040', 'Linz'),
    Region('4050', 'Traun'),
    Region('4221', 'Steyregg'),
    Region('4600', 'Wels'),
  ];

  static final _users = [
    {
      "username": "joe.hinter",
      "name": "Johannes Hinterberger",
      "gender": Gender.MALE,
      "description": "I am a helpful person.",
      "region": _availableRegions[0],
      "price": 0,
      "asset": "assets/avatars/male1.png",
    },
    {
      "username": "briggite.s",
      "name": "Brigitte Seitenschläger",
      "gender": Gender.FEMALE,
      "description": "I love animals.",
      "region": _availableRegions[2],
      "price": 5,
      "asset": "assets/avatars/female1.png",
    },
    {
      "username": "eddom",
      "name": "Eduardo Domingo",
      "gender": Gender.MALE,
      "description": "Several years of experience as a pet-sitter.",
      "region": _availableRegions[1],
      "price": 7,
      "asset": "assets/avatars/male2.png",
    },
    {
      "username": "m.hauer",
      "name": "Manuel Hauer",
      "gender": Gender.MALE,
      "description": "I have a lot of free time.",
      "region": _availableRegions[5],
      "price": 15,
      "asset": "assets/avatars/male3.png",
    },
    {
      "username": "tanja.gruber",
      "name": "Tanja Gruber",
      "gender": Gender.FEMALE,
      "description": "I love animals.",
      "region": _availableRegions[4],
      "price": 8,
      "asset": "assets/avatars/female2.png",
    },
    {
      "username": "tbb",
      "name": "Thomas Braunberger",
      "gender": Gender.MALE,
      "description":
          "Male, 35 years old, education from FH Hagenberg, like to read, have 3 sisters and 1 brother. More information about me can be found on my website at http://person.me.com",
      "region": _availableRegions[3],
      "price": 10,
      "asset": "assets/avatars/male3.png",
    },
    {
      "username": "usr123",
      "name": "Anonymous",
      "gender": Gender.UNKNOWN,
      "description": "(no description)",
      "region": _availableRegions[4],
      "price": 9,
      "asset": "assets/images/empty.png",
    },
    {
      "username": "augernst",
      "name": "Augustine Ernst",
      "gender": Gender.FEMALE,
      "description": "I can help out anytime.",
      "region": _availableRegions[1],
      "price": 13,
      "asset": "assets/avatars/female3.png",
    },
    {
      "username": "anna96",
      "name": "Anna Steiner",
      "gender": Gender.FEMALE,
      "description": "Recommend me to your friends!",
      "region": _availableRegions[5],
      "price": 6,
      "asset": "assets/avatars/female4.png",
    },
  ]; */

  static Future<User> getMyAccount() async{
    return userByUsername('my_username');
  }

  static Future<User> userByUsername(String username) async{
        PostgrestResponse result =  await AppState.getInstance().connection.from('user')
                  .select(Constants.userTableData)
                  .filter('username', 'eq', username)
                  .execute();
    var user = result.toJson()['data'][0];
    return User(user['username'],
      user['firstname'],
      Converter.convertToGender(user['gender']['name']),
      Region(user['zipcode'].toString(), user['region']['name']),
      user['price'],
      user['description'],
      user['asset'],
      DateTime.now().millisecondsSinceEpoch);
  }

  static Future<List<User>> getDemoUsers() async{
    PostgrestResponse result = await AppState.getInstance().connection.from('user')
                    .select(Constants.userTableData)
                    .filter('username', 'neq', 'my_username')
                    .execute();
    List<User> users = [];
    for (final user in result.toJson()['data']){
      users.add(User(user['username'],
      user['firstname'],
      Converter.convertToGender(user['gender']['name']),
      Region(user['zipcode'].toString(), user['region']['name']),
      user['price'],
      user['description'],
      user['asset'],
      DateTime.now().millisecondsSinceEpoch));
    }
    return users;
  }

  static Future<List<User>> getDemoUsersByRegion(Region region) async{
    if (region == null) {
      return getDemoUsers();
    }
    PostgrestResponse result = await AppState.getInstance().connection.from('user')
                    .select(Constants.userTableData)
                    .filter('zipcode', 'eq', region.postcode)
                    .execute();
    List<User> users = [];
    for (final user in result.toJson()['data']){
      users.add(User(user['username'],
      user['firstname'],
      Converter.convertToGender(user['gender']['name']),
      region,
      user['price'],
      user['description'],
      user['asset'],
      DateTime.now().millisecondsSinceEpoch));
    }
    return users;
  }

  static Future<List<Region>> getAvailableRegions() async{
    PostgrestResponse result = await AppState.getInstance().connection.from('city')
                    .select()
                    .execute();
    List<Region> regions = [];
    for (final region in result.toJson()['data']){
      regions.add(Region(region['zipcode'].toString(), region['name']));
    }
    return regions;
  }

  static Future<List<Chat>> getUserChats(String username) async {
    PostgrestResponse result = await AppState.getInstance().connection.from('chat')
                    .select()
                    .or('username1.eq.'+ username +',username2.eq.'+ username)
                    .execute();
    List<Chat> chats = [];
    for (final chat in result.toJson()['data']){
      chats.add(Chat(chat['chatid'], chat['username1'], chat['username2'], chat['isread']));
    }
    return chats;
  }

  static Future<List<Message>> getChatHistory(Chat chat) async{
    PostgrestResponse result = await AppState.getInstance().connection.from('message')
                    .select()
                    .filter('chatid', 'eq', chat.chatId)
                    .execute();
    List<Message> messages = [];
    if (result.toJson()['data'] != null) {
          for (final message in result.toJson()['data']){
            messages.add(Message(message['msgid'],
                message['username'],
                message['chatid'],
                Converter.convertToChatText(message['content']),
                DateTime.now().millisecondsSinceEpoch));
          }
    }
    return messages;
  }

  static Future<int> getCurrMsgId(int chatId) async {
    PostgrestResponse result = await AppState.getInstance().connection.from('message')
                    .select('msgid')
                    .filter('chatid', 'eq', chatId)
                    .execute();
    if (result.toJson()['data'].isEmpty) return 0;
    return result.toJson()['data'].last['msgid'] + 1;
  }

  // inserts

  static void insertMessage(int chatId, String username, String text) async {
        await AppState.getInstance().connection.from('message')
            .insert(
              [{'chatid': chatId,
               'username': username,
               'content': text,
               'timestamp': Converter.convertToTimeStamp(DateTime.now().millisecondsSinceEpoch),
               'msgid' : await getCurrMsgId(chatId)}]
            ).execute();
  }

  static void updateUser(String username, String name, String desc) async {
    String firstname = name.split(" ")[0];
    String lastname = name.split(" ").length == 2 ? name.split(" ")[1] : "";
    await AppState.getInstance().connection.from('user')
                                .update({
                                  "firstname" : firstname,
                                  "lastname" : lastname,
                                  "description" : desc
                                })
                                .eq("username", username)
                                .execute();
  }

  static Future<int> getScore(String userId) async {
    PostgrestResponse result = await AppState.getInstance().connection.from('user')
                    .select('score')
                    .filter('userid', 'eq', userId)
                    .execute();
    return result.toJson()['data'].first['score'];
  }

  static Future<int> getLevel(String userId) async {
    PostgrestResponse result = await AppState.getInstance().connection.from('user')
                    .select('level')
                    .filter('userid', 'eq', userId)
                    .execute();
    return result.toJson()['data'].first['level'];
  }

  void updateScore(String userId, Scorer scorer) async {
    await AppState.getInstance().connection.from('user')
                                .update({
                                  "score" : scorer.calculateResult.toInt()
                                })
                                .eq("username", userId)
                                .execute();
  }

  void updateLevel(String userId, Scorer scorer) async {
    await AppState.getInstance().connection.from('user')
                                .update({
                                  "level" : scorer.calculateResult.toInt()
                                })
                                .eq("username", userId)
                                .execute();
  }

  static void markAsRead(Chat chat) async {
    // TODO: implement database command
    print('TODO: mark chat with id ${chat.chatId} as read');
  }
}