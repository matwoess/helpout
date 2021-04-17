import 'package:flutter/material.dart';
import 'package:helpout/person.dart';
import 'package:helpout/personcard.dart';

import 'demodata.dart';

class AssistPeoplePage extends StatefulWidget {
  @override
  _AssistPeopleState createState() => _AssistPeopleState();
}

class _AssistPeopleState extends State<AssistPeoplePage> {
  List<Person> persons = DemoData().getDemoPersons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assist people in need"),
      ),
      body: ListView.builder(
          itemBuilder: (context, position) {
            return PersonCard(persons[position]);
          },
          itemCount: persons.length),
    );
  }
}
