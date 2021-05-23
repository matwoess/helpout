import 'package:helpout/model/region.dart';

enum Gender { FEMALE, MALE, UNKNOWN }

extension ParseToString on Gender {
  String toShortString() {
    if (this == Gender.UNKNOWN) {
      return 'unknown gender';
    }
    return this.toString().split('.').last.toLowerCase();
  }
}

class User {
  final String username;
  String name;
  final Gender gender;
  final Region region;
  int price;
  String description;
  final String assetURI;
  final int since;

  int level = 1;

  User(
    this.username,
    this.name,
    this.gender,
    this.region,
    this.price,
    this.description,
    this.assetURI,
    this.since,
  );

  User.loading()
      : this('', '...', Gender.UNKNOWN, Region.unknown, 0, '...',
            'assets/images/empty.png', DateTime.now().millisecondsSinceEpoch);

  bool get isLoading => name == '...';
}
