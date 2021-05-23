import 'package:flutter/material.dart';
import 'package:helpout/home.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/pages/assistpeople.dart';
import 'package:helpout/pages/login.dart';
import 'package:helpout/pages/prelogin.dart';
import 'package:helpout/pages/requesthelp.dart';
import 'package:helpout/pages/signup.dart';
import 'package:helpout/pages/welcome.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void refreshUI() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    AppState.getInstance().addCallback(refreshUI);
  }

  ThemeData get theme {
    switch (AppState.getInstance().darkTheme) {
      case true:
        return ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          accentColor: Colors.amberAccent
        );
      case false:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigo,
          accentColor: Colors.pinkAccent,
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
        '/': (context) => HomeScreen(),
        '/request': (context) => RequestHelpPage(),
        '/assist': (context) => AssistPeoplePage(),
        '/prelogin': (context) => PreLoginPage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LogInPage(),
        '/signup/welcome': (context) => WelcomePage('Welcome!'),
        '/login/welcome': (context) => WelcomePage('Login successful!'),
      },
    );
  }
}
