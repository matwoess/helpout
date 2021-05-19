import 'package:geolocator/geolocator.dart';
import 'package:helpout/misc/demodata.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/model/region.dart';

enum SearchType { REQUEST, ASSIST }

class AppState {
  static final AppState _instance = AppState(
    DemoData.getMyAccount(), // (auto-login) TODO: set to null
    SearchType.ASSIST,
    null,
    false,
    null,
  );

  static AppState getInstance() {
    return _instance;
  }

  List<Function> _callbacks = <Function>[];
  User _accountData;
  SearchType _searchType;
  Region _region;
  bool _darkTheme;
  Position _currentPosition;
  User _chatUser;

  AppState(this._accountData, this._searchType, this._region, this._darkTheme,
      this._chatUser);


  User get accountData => _accountData;

  set accountData(User accountData) {
    _accountData = accountData;
    triggerCallbacks();
  }

  bool get loggedIn => _accountData != null;

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

  User get chatUser => _chatUser;

  set chatUser(User chatUser) {
    _chatUser = chatUser;
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
