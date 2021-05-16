import 'package:geolocator/geolocator.dart';
import 'package:helpout/model/region.dart';

enum SearchType { REQUEST, ASSIST }

class AppState {
  bool loggedIn;
  SearchType searchType;
  Region region;
  bool darkTheme;
  Position currentPosition;

  AppState({
    this.loggedIn,
    this.searchType,
    this.region,
    this.darkTheme,
  });
}
