import 'package:helpout/model/person.dart';
import 'package:helpout/model/region.dart';

class DemoData {
  static final _availableRegions = [
    Region('4020', 'Linz'),
    Region('4030', 'Linz'),
    Region('4040', 'Linz'),
    Region('4050', 'Traun'),
    Region('4221', 'Steyregg'),
    Region('4600', 'Wels'),
  ];

  static final _people = [
    {
      "name": "Johannes Hinterberger",
      "gender": Gender.MALE,
      "description": "I am a helpful person.",
      "region": _availableRegions[0],
      "price": 0,
      "asset": "assets/avatars/male1.png",
    },
    {
      "name": "Brigitte Seitenschläger",
      "gender": Gender.FEMALE,
      "description": "I love animals.",
      "region": _availableRegions[2],
      "price": 5,
      "asset": "assets/avatars/female1.png",
    },
    {
      "name": "Eduardo Domingo",
      "gender": Gender.MALE,
      "description": "Several years of experience as a pet-sitter.",
      "region": _availableRegions[1],
      "price": 7,
      "asset": "assets/avatars/male2.png",
    },
    {
      "name": "Manuel Hauer",
      "gender": Gender.MALE,
      "description": "I have a lot of free time.",
      "region": _availableRegions[5],
      "price": 15,
      "asset": "assets/avatars/male3.png",
    },
    {
      "name": "Tanja Gruber",
      "gender": Gender.FEMALE,
      "description": "I love animals.",
      "region": _availableRegions[4],
      "price": 8,
      "asset": "assets/avatars/female2.png",
    },
    {
      "name": "Thomas Braunberger",
      "gender": Gender.MALE,
      "description":
          "Male, 35 years old, education from FH Hagenberg, like to read, have 3 sisters and 1 brother. More information about me can be found on my website at http://person.me.com",
      "region": _availableRegions[3],
      "price": 10,
      "asset": "assets/avatars/male3.png",
    },
    {
      "name": "Anonymous",
      "gender": Gender.UNKNOWN,
      "description": "(no description)",
      "region": _availableRegions[4],
      "price": 9,
      "asset": "assets/images/empty.png",
    },
    {
      "name": "Augustine Ernst",
      "gender": Gender.FEMALE,
      "description": "I can help out anytime.",
      "region": _availableRegions[1],
      "price": 13,
      "asset": "assets/avatars/female3.png",
    },
    {
      "name": "Anna Steiner",
      "gender": Gender.FEMALE,
      "description": "Recommend me to your friends!",
      "region": _availableRegions[5],
      "price": 6,
      "asset": "assets/avatars/female4.png",
    },
  ];

  static List<Person> getDemoPersons() {
    return _people
        .map((person) => Person(
              person['name'],
              person['gender'],
              person['region'],
              person['price'],
              person['description'],
              person['asset'],
            ))
        .toList();
  }

  static List<Person> getDemoPersonsByRegion(Region region) {
    if (region == null) {
      return getDemoPersons();
    }
    return _people
        .where((person) => person['region'] == region)
        .map((person) => Person(
              person['name'],
              person['gender'],
              person['region'],
              person['price'],
              person['description'],
              person['asset'],
            ))
        .toList();
  }

  static List<Region> getAvailableRegions() {
    return _availableRegions;
  }

  static List<String> getChatHistory(Person person) {
    return [
      'Hello ${person.name}!',
      'I require assistance with something.\nCould you help?',

    ];
  }
}
