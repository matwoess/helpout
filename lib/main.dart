import 'package:flutter/material.dart';
import 'package:helpout/peopleinneed.dart';
import 'package:helpout/searchhelpers.dart';
import 'package:helpout/signup.dart';

import 'greeting.dart';

void main() {
  runApp(MainApp());
}

enum AppPart { GREETING, LOGIN, FIND, HELP }

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AppPart _shownPart = AppPart.GREETING;

  void setPartToShow(AppPart part) {
    _shownPart = part;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Help out',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.yellow,
        ),
        home: getWidgetToShow());
  }

  Widget getWidgetToShow() {
    switch (_shownPart) {
      case AppPart.GREETING:
        return GreetingPage(title: 'Help out', callback: setPartToShow);
      case AppPart.LOGIN:
        return SignUpApp();
      case AppPart.FIND:
        return SearchHelpersPage(title: 'Finding helpers in your vicinity');
      case AppPart.HELP:
        return PeopleInNeedPage(title: 'Help out people in need');
      default:
        return null;
    }
  }
}
