import 'package:helpout/model/region.dart';

enum Gender { FEMALE, MALE, UNKNOWN }
enum UserType { REQUEST, ASSIST }

extension ParseToGenderString on Gender {
  String toShortString() {
    switch (this) {
      case Gender.FEMALE:
        return 'Female';
      case Gender.MALE:
        return 'Male';
      case Gender.UNKNOWN:
      default:
        return 'Other';
    }
  }
}

extension ParseToUserTypeString on UserType {
  String toShortString() {
    switch (this) {
      case UserType.REQUEST:
        return 'Request help from people';
      case UserType.ASSIST:
      default:
        return 'Assist people in need';
    }
  }
}

class User {
  static final User loading = User('', '', 'Loading...', Gender.UNKNOWN, Region.unknown, 0, 'Loading...',
      'assets/images/empty.png', UserType.ASSIST);

  final String username;
  final String password;
  String name;
  final Gender gender;
  final Region region;
  int price;
  String description;
  final String assetURI;
  UserType userType;

  int level = 1;

  User(
    this.username,
    this.password,
    this.name,
    this.gender,
    this.region,
    this.price,
    this.description,
    this.assetURI,
    this.userType,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is User && runtimeType == other.runtimeType && username == other.username;

  @override
  int get hashCode => username.hashCode;

  bool get isLoading => name == '...';
}
