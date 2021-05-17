import 'package:flutter/material.dart';
import 'package:helpout/model/person.dart';
import 'package:helpout/pages/personcard.dart';

import '../misc/demodata.dart';
import '../model/appstate.dart';
import 'detailsdialog.dart';

class RequestHelpPage extends StatefulWidget {
  RequestHelpPage();

  @override
  _RequestHelpState createState() => _RequestHelpState();
}

class _RequestHelpState extends State<RequestHelpPage> {
  List<Person> persons;

  @override
  void initState() {
    super.initState();
    persons = DemoData.getDemoPersonsByRegion(AppState.getInstance().region);
  }

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
    if (!AppState.getInstance().loggedIn)
      Navigator.pushNamed(context, '/prelogin');
    else
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailsDialog(person, startChat);
        },
        routeSettings: RouteSettings(name: '/detailview'),
      );
  }

  void startChat(Person person) {
    Navigator.of(context).pop();
    print('starting chat with ${person.name}');
  }
}
