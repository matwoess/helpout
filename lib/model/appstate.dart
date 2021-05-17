import 'package:geolocator/geolocator.dart';
import 'package:helpout/model/person.dart';
import 'package:helpout/model/region.dart';

enum SearchType { REQUEST, ASSIST }

class AppState {
  static final AppState _instance = AppState(
    true,
    //TODO: set to false
    SearchType.ASSIST,
    null,
    false,
    null,
  );

  static AppState getInstance() {
    return _instance;
  }

  List<Function> _callbacks = <Function>[];
  bool _loggedIn;
  SearchType _searchType;
  Region _region;
  bool _darkTheme;
  Position _currentPosition;
  Person _chatPerson;

  AppState(this._loggedIn, this._searchType, this._region, this._darkTheme,
      this._chatPerson);

  bool get loggedIn => _loggedIn;

  set loggedIn(bool loggedIn) {
    _loggedIn = loggedIn;
    triggerCallbacks();
  }

  SearchType get searchType => _searchType;

  set searchType(SearchType searchType) {
    _searchType = searchType;
    triggerCallbacks();
  }

  Region get region => _region;

  set region(Region region) {
    _region = region;
    triggerCallbacks();
  }

  Position get currentPosition => _currentPosition;

  set currentPosition(Position currentPosition) {
    _currentPosition = currentPosition;
    triggerCallbacks();
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(bool darkTheme) {
    _darkTheme = darkTheme;
    triggerCallbacks();
  }

  Person get chatPerson => _chatPerson;

  set chatPerson(Person chatPerson) {
    _chatPerson = chatPerson;
    triggerCallbacks();
  }

  void triggerCallbacks() {
    for (Function callback in _callbacks) {
      callback();
    }
  }

  void addCallback(Function cb) {
    _callbacks.add(cb);
  }

  void removeCallback(Function cb) {
    if (_callbacks.contains(cb)) {
      _callbacks.remove(cb);
    }
  }
}
