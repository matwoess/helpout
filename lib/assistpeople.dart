import 'package:flutter/material.dart';
import 'package:helpout/appstate.dart';
import 'package:helpout/detailsdialog.dart';
import 'package:helpout/person.dart';
import 'package:helpout/personcard.dart';

import 'appstate.dart';
import 'demodata.dart';

class AssistPeoplePage extends StatefulWidget {
  final AppState _appState;
  AssistPeoplePage(this._appState);
  @override
  _AssistPeopleState createState() => _AssistPeopleState();
}

class _AssistPeopleState extends State<AssistPeoplePage> {
  List<Person> persons = DemoData.getDemoPersons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assist people in need"),
      ),
      body: ListView.builder(
          itemBuilder: (context, position) {
            return PersonCard(persons[position], showDetails);
          },
          itemCount: persons.length),
    );
  }

  showDetails(Person person) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailsDialog(person, startChat);
        },
        routeSettings: RouteSettings(name: '/detailview'));
  }

  void startChat(Person person) {
    if (!widget._appState.loggedIn)
      Navigator.pushNamed(context, '/prelogin');
    else {
      Navigator.of(context).pop();
      print('starting chat with ${person.name}');
    }
  }
}
