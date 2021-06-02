import 'package:postgres/postgres.dart';
import 'package:helpout/model/user.dart';

class Converter {
  static dynamic convertResult(PostgreSQLResult row, int rowno, int colno) {
    return row.elementAt(rowno).elementAt(colno);
  }

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
}