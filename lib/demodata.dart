import 'package:helpout/person.dart';
import 'package:helpout/region.dart';

class DemoData {
  static final _people = [
    {
      "name": "Johannes Hinterberger",
      "description": "I am a helpful person.",
      "region": "4020, Linz",
      "price": 0,
    },
    {
      "name": "Brigitte Seitenschläger",
      "description": "I love animals.",
      "region": "4040, Linz",
      "price": 5,
    },
    {
      "name": "Eduardo Domingo",
      "description": "Several years of experience as a pet-sitter.",
      "region": "4030, Linz",
      "price": 7,
    },
    {
      "name": "Manuel Hauer",
      "description": "I have a lot of free time.",
      "region": "4600, Wels",
      "price": 15,
    },
    {
      "name": "Tanja Gruber",
      "description": "I love animals.",
      "region": "4221, Steyregg",
      "price": 8,
    },
    {
      "name": "Thomas Braunberger",
      "description":
          "Male, 35 years old, education from FH Hagenberg, like to read, have 3 sisters and 1 brother. More information about me can be found on my website at http://person.me.com",
      "region": "4050, Traun",
      "price": 10,
    },
    {
      "name": "Anonymous",
      "description": "(no description)",
      "region": "4040, Linz",
      "price": 9,
    },
  ];

  static List<Person> getDemoPersons() {
    return _people
        .map((person) => Person(
            person['name'],
            Region.withoutLocation(person['region']),
            person['price'],
            person['description']))
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
