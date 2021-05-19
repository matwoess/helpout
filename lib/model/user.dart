import 'package:helpout/model/region.dart';

enum Gender { FEMALE, MALE, UNKNOWN }

class User {
  final String username;
  final String name;
  final Gender gender;
  final Region region;
  final int price;
  final String description;
  final String assetURI;

  User(
    this.username,
    this.name,
    this.gender,
    this.region,
    this.price,
    this.description,
    this.assetURI,
  );

  User.loading()
      : this('',  '...', Gender.UNKNOWN, Region.unknown, 0, '...',
            'assets/images/empty.png');

  bool get isLoading => name == '...';
}
