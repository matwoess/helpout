import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/chat.dart';
import 'package:helpout/model/message.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/model/user.dart';
import 'package:postgres/postgres.dart';
import 'package:helpout/misc/constants.dart';
import 'package:helpout/util/converter.dart';
import 'package:postgrest/postgrest.dart';

class DemoData {
  static final _availableRegions = [
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
  ];

  static Future<User> getMyAccount() async{
    PostgrestResponse result =  await AppState.getInstance().connection.from('user')
                  .select('username, firstname, lastname, gender:gid(name), zipcode, region:zipcode(name),price, description, asset')
                  .filter('username', 'eq', 'my_username')
                  .execute();
    var ret;
    var user = result.toJson()['data'][0];
    return User(user['username'],
      user['firstname'],
      Converter.convertToGender(user['gender']['name']),
      Region(user['zipcode'].toString(), user['region']['name']),
      user['price'],
      user['description'],
      user['asset'],
      DateTime.now().millisecondsSinceEpoch);
    /*return User(
      'my_username',
      'My Name',
      Gender.FEMALE,
      _availableRegions[0],
      5,
      'This is my profile! Here I will tell about myself and give you a good impression.\n' +
          'For more information please contact me.',
      'assets/avatars/female4.png',
      DateTime.now().millisecondsSinceEpoch,
    );*/
  }

  static User userByUsername(String username) {
    return _users
        .where((u) => u['username'] == username)
        .map((person) => User(
              person['username'],
              person['name'],
              person['gender'],
              person['region'],
              person['price'],
              person['description'],
              person['asset'],
              DateTime.now().millisecondsSinceEpoch,
            ))
        .first;
  }

  static List<User> getDemoUsers() {
    return _users
        .map((person) => User(
              person['username'],
              person['name'],
              person['gender'],
              person['region'],
              person['price'],
              person['description'],
              person['asset'],
              DateTime.now().millisecondsSinceEpoch,
            ))
        .toList();
  }

  static List<User> getDemoUsersByRegion(Region region) {
    if (region == null) {
      return getDemoUsers();
    }
    return _users
        .where((person) => person['region'] == region)
        .map((person) => User(
              person['username'],
              person['name'],
              person['gender'],
              person['region'],
              person['price'],
              person['description'],
              person['asset'],
              DateTime.now().millisecondsSinceEpoch,
            ))
        .toList();
  }

  static List<Region> getAvailableRegions() {
    return _availableRegions;
  }

  static List<Chat> getUserChats() {
    return [
      Chat(0, 'joe.hinter', 'my_username', false),
      Chat(1, 'my_username', 'briggite.s', true),
      Chat(2, 'eddom', 'my_username', true),
      Chat(3, 'my_username', 'm.hauer', false),
      Chat(4, 'tanja.gruber', 'my_username', true),
      Chat(5, 'my_username', 'tbb', true),
      Chat(6, 'usr123', 'my_username', true),
      Chat(7, 'my_username', 'augernst', true),
      Chat(443, 'anna96', 'my_username', true),
    ];
  }

  static List<Message> getChatHistory(Chat chat) {
    User me = AppState.getInstance().accountData;
    User other = userByUsername(chat.otherUsername);
    return [
      Message(0, me.username, chat.chatId, 'Hello ${other.name}!',
          DateTime.now().millisecondsSinceEpoch),
      Message(
          1,
          me.username,
          chat.chatId,
          'I require assistance with something.\nCould you help?',
          DateTime.now().millisecondsSinceEpoch),
      Message(2, other.username, chat.chatId, 'Yes, sure! :)',
          DateTime.now().millisecondsSinceEpoch),
      Message(2, other.username, chat.chatId, 'What seems to be the problem?',
          DateTime.now().millisecondsSinceEpoch),
      Message(
          2,
          me.username,
          chat.chatId,
          'I need help with <thing>?\nWhen do you have time?',
          DateTime.now().millisecondsSinceEpoch),
    ];
  }
}
