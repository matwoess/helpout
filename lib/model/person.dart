import 'package:helpout/model/region.dart';

enum Gender { FEMALE, MALE, UNKNOWN }

class Person {
  final Region region;
  final Gender gender;
  final String name;
  final int price;
  final String description;
  final String assetURI;

  Person(
    this.name,
    this.gender,
    this.region,
    this.price,
    this.description,
    this.assetURI,
  );

  Person.loading()
      : this('...', Gender.UNKNOWN, Region.unknown, 0, '...',
            'assets/images/empty.png');

  bool get isLoading => name == '...';
}
