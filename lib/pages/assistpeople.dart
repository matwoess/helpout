import 'package:flutter/material.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/person.dart';
import 'package:helpout/pages/detailsdialog.dart';
import 'package:helpout/pages/personcard.dart';

import '../misc/demodata.dart';
import '../model/appstate.dart';

class AssistPeoplePage extends StatefulWidget {
  AssistPeoplePage();

  @override
  _AssistPeopleState createState() => _AssistPeopleState();
}

class _AssistPeopleState extends State<AssistPeoplePage> {
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
      routeSettings: RouteSettings(name: '/detailview'),
    );
  }

  void startChat(Person person) {
    if (!AppState.getInstance().loggedIn)
      Navigator.pushNamed(context, '/prelogin');
    else {
      print('starting chat with ${person.name}');
      AppState.getInstance().chatPerson = person;
      while(Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      //Navigator.pushNamed(context, '/');
    }
  }
}
