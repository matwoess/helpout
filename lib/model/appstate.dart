import 'package:geolocator/geolocator.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/model/user.dart';
import 'package:postgrest/postgrest.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SearchType { REQUEST, ASSIST }

class AppState {
  static final AppState _instance = AppState(
    null,
    null,
    false,
    null,
  );

  static AppState getInstance() {
    return _instance;
  }

  List<Function> _callbacks = <Function>[];
  User _accountData;
  Region _region;
  bool _darkTheme;
  User _chatUser;
  PostgrestClient _connection = PostgrestClient("http://localhost:3000");

  AppState(this._accountData, this._region, this._darkTheme, this._chatUser) {
    retrievePreviousUserCredentials().then((user) => {if (user != null) accountData = user});
    restoreTheme().then((dark) => {if (dark != null && dark != _darkTheme) _darkTheme = dark});
  }

  User get accountData => _accountData;

  set accountData(User accountData) {
    _accountData = accountData;
    SharedPreferences.getInstance().then((prefs) => {
          if (accountData == null) {prefs.remove('username')} else {prefs.setString('username', accountData.username)}
        });
    triggerCallbacks();
  }

  Future<User> retrievePreviousUserCredentials() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('username'))
        .then((username) => username == null ? null : DBManager.getUserByUsername(username));
  }

  bool get loggedIn => _accountData != null;

  Region get region => _region;

  set region(Region region) {
    _region = region;
    triggerCallbacks();
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(bool darkTheme) {
    _darkTheme = darkTheme;
    SharedPreferences.getInstance().then((prefs) => {prefs.setBool('darkTheme', darkTheme)});
    triggerCallbacks();
  }

  Future<bool> restoreTheme() async {
    return SharedPreferences.getInstance().then((prefs) => prefs.getBool('darkTheme'));
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

  PostgrestClient get connection => _connection;
}
