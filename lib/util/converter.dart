import 'package:postgres/postgres.dart';
import 'package:helpout/model/user.dart';

class Converter {
  static Gender convertToGender(dynamic value) {
    switch (value) {
      case 'FEMALE':
        return Gender.FEMALE;
        break;
      case 'MALE':
        return Gender.MALE;
        break;
      default:
        return Gender.UNKNOWN;
    }
  }

  static String convertToChatText(String dbString){
    return dbString.replaceAll("\\n", "\n");
  }
}