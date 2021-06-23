import 'package:helpout/model/user.dart';
import 'package:intl/intl.dart';

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

  static String convertToTimeStamp(int millisecsSinceEpoch){
    var format = new DateFormat('yyyy-MM-dd hh:mm:ss');
     var date = new DateTime.fromMillisecondsSinceEpoch(millisecsSinceEpoch);
    return format.format(date);
  }

  static int convertToMillisecondsSinceEpoch(String timestamp){
    //print('TODO: toMillisecondsSinceEpoch: ' + DateTime.parse(timestamp).millisecondsSinceEpoch.toString());
    return DateTime.parse(timestamp).millisecondsSinceEpoch;
  }
}