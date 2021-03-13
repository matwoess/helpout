import 'package:flutter/material.dart';
import 'package:helpout/appstate.dart';
import 'package:helpout/greeting.dart';
import 'package:helpout/login.dart';
import 'package:helpout/peopleinneed.dart';
import 'package:helpout/prelogin.dart';
import 'package:helpout/searchhelpers.dart';
import 'package:helpout/signup.dart';
import 'package:helpout/welcome.dart';

void main() {
  runApp(MainApp());
}

enum AppPart { GREETING, LOGIN, FIND, HELP }

class MainApp extends StatefulWidget {
  static AppState state = AppState();

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help out',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.pinkAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GreetingPage(),
        '/prelogin': (context) => PreLoginPage(),
        '/findhelpers': (context) => SearchHelpersPage(),
        '/helpout': (context) => PeopleInNeedPage(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LogInScreen(),
        '/signup/welcome': (context) => WelcomeScreen("Welcome!"),
        '/login/welcome': (context) => WelcomeScreen('Login successful!'),
      },
    );
  }
}
