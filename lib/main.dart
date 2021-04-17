import 'package:flutter/material.dart';
import 'package:helpout/greeting.dart';
import 'package:helpout/login.dart';
import 'package:helpout/assistpeople.dart';
import 'package:helpout/prelogin.dart';
import 'package:helpout/requesthelp.dart';
import 'package:helpout/signup.dart';
import 'package:helpout/welcome.dart';

void main() {
  runApp(MainApp());
}

enum AppPart { GREETING, LOGIN, FIND, HELP }

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Help out',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.pinkAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GreetingPage(),
        '/request': (context) => RequestHelpPage(),
        '/assist': (context) => AssistPeoplePage(),
        '/prelogin': (context) => PreLoginPage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LogInPage(),
        '/signup/welcome': (context) => WelcomePage("Welcome!"),
        '/login/welcome': (context) => WelcomePage('Login successful!'),
      },
    );
  }
}
