import 'package:flutter/material.dart';
import 'package:helpout/person.dart';
import 'package:helpout/personcard.dart';

import 'appstate.dart';
import 'demodata.dart';
import 'detailsdialog.dart';

class RequestHelpPage extends StatefulWidget {
  final AppState _appState;

  RequestHelpPage(this._appState);

  @override
  _RequestHelpState createState() => _RequestHelpState();
}

class _RequestHelpState extends State<RequestHelpPage> {
  List<Person> persons = DemoData.getDemoPersons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request help"),
      ),
      body: ListView.builder(
          itemBuilder: (context, position) {
            return PersonCard(persons[position], showDetails);
          },
          itemCount: persons.length),
    );
  }

  showDetails(Person person) {
    if (!widget._appState.loggedIn)
      Navigator.pushNamed(context, '/prelogin');
    else
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailsDialog(person, startChat);
        },
      );
  }

  void startChat(Person person) {
    Navigator.of(context).pop();
    print('starting chat with ${person.name}');
  }
}
