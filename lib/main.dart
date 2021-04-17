import 'package:flutter/material.dart';
import 'package:helpout/appstate.dart';
import 'package:helpout/assistpeople.dart';
import 'package:helpout/greeting.dart';
import 'package:helpout/login.dart';
import 'package:helpout/prelogin.dart';
import 'package:helpout/requesthelp.dart';
import 'package:helpout/signup.dart';
import 'package:helpout/welcome.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AppState _appState = AppState(
    loggedIn: true,
    searchType: SearchType.ASSIST,
    region: null,
    darkTheme: false,
  );

  void _stateUpdater(AppState value) {
    setState(() {
      _appState = value;
    });
  }

  ThemeData get theme {
    switch (_appState.darkTheme) {
      case true:
        return ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
        );
      case false:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Help out',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => GreetingPage(_appState, _stateUpdater),
        '/request': (context) => RequestHelpPage(_appState),
        '/assist': (context) => AssistPeoplePage(_appState),
        '/prelogin': (context) => PreLoginPage(),
        '/signup': (context) => SignUpPage(_appState, _stateUpdater),
        '/login': (context) => LogInPage(_appState, _stateUpdater),
        '/signup/welcome': (context) => WelcomePage(_appState, "Welcome!"),
        '/login/welcome': (context) => WelcomePage(_appState, 'Login successful!'),
      },
    );
  }
}
