import 'package:flutter/material.dart';
import 'package:helpout/person.dart';
import 'package:helpout/personcard.dart';

import 'demodata.dart';

class PeopleInNeedPage extends StatefulWidget {
  @override
  _PeopleInNeedState createState() => _PeopleInNeedState();
}

class _PeopleInNeedState extends State<PeopleInNeedPage> {
  List<Person> persons = DemoData().getDemoPersons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help out people in need"),
      ),
      body: ListView.builder(
          itemBuilder: (context, position) {
            return PersonCard(persons[position]);
          },
          itemCount: persons.length),
    );
  }
}
