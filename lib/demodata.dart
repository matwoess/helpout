import 'package:helpout/person.dart';
import 'package:helpout/region.dart';

class DemoData {
  static final _people = [
    {
      "name": "Johannes Hinterberger",
      "gender": Gender.MALE,
      "description": "I am a helpful person.",
      "region": "4020, Linz",
      "price": 0,
      "asset": "assets/avatars/male1.png",
    },
    {
      "name": "Brigitte Seitenschläger",
      "gender": Gender.FEMALE,
      "description": "I love animals.",
      "region": "4040, Linz",
      "price": 5,
      "asset": "assets/avatars/female1.png",
    },
    {
      "name": "Eduardo Domingo",
      "gender": Gender.MALE,
      "description": "Several years of experience as a pet-sitter.",
      "region": "4030, Linz",
      "price": 7,
      "asset": "assets/avatars/male2.png",
    },
    {
      "name": "Manuel Hauer",
      "gender": Gender.MALE,
      "description": "I have a lot of free time.",
      "region": "4600, Wels",
      "price": 15,
      "asset": "assets/avatars/male3.png",
    },
    {
      "name": "Tanja Gruber",
      "gender": Gender.FEMALE,
      "description": "I love animals.",
      "region": "4221, Steyregg",
      "price": 8,
      "asset": "assets/avatars/female2.png",
    },
    {
      "name": "Thomas Braunberger",
      "gender": Gender.MALE,
      "description":
          "Male, 35 years old, education from FH Hagenberg, like to read, have 3 sisters and 1 brother. More information about me can be found on my website at http://person.me.com",
      "region": "4050, Traun",
      "price": 10,
      "asset": "assets/avatars/male3.png",
    },
    {
      "name": "Anonymous",
      "gender": Gender.UNKNOWN,
      "description": "(no description)",
      "region": "4040, Linz",
      "price": 9,
      "asset": "assets/images/empty.png",
    },
    {
      "name": "Augustine Ernst",
      "gender": Gender.FEMALE,
      "description": "I can help out anytime.",
      "region": "4030, Linz",
      "price": 13,
      "asset": "assets/avatars/female3.png",
    },
    {
      "name": "Anna Steiner",
      "gender": Gender.FEMALE,
      "description": "Recommend me to your friends!",
      "region": "4600, Wels",
      "price": 6,
      "asset": "assets/avatars/female4.png",
    },
  ];

  static List<Person> getDemoPersons() {
    return _people
        .map((person) => Person(
              person['name'],
              person['gender'],
              Region.withoutLocation(person['region']),
              person['price'],
              person['description'],
              person['asset'],
            ))
        .toList();
  }

  static List<String> getAvailableRegions() {
    return [
      '4020, Linz',
      '4030, Linz',
      '4040, Linz',
      '4050, Traun',
      '4221, Steyregg',
      '4600, Wels',
    ];
  }
}
