import 'package:flutter/material.dart';
import 'package:helpout/person.dart';
import 'package:helpout/personcard.dart';

import 'demodata.dart';

class SearchHelpersPage extends StatefulWidget {

  @override
  _SearchHelpersState createState() => _SearchHelpersState();
}

class _SearchHelpersState extends State<SearchHelpersPage> {
  List<Person> persons = DemoData().getDemoPersons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finding helpers in your vicinity"),
      ),
      body: ListView.builder(
          itemBuilder: (context, position) {
            return PersonCard(persons[position]);
          },
          itemCount: persons.length),
    );
  }
}
