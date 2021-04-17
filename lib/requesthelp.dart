import 'package:flutter/material.dart';
import 'package:helpout/person.dart';
import 'package:helpout/personcard.dart';

import 'demodata.dart';

class RequestHelpPage extends StatefulWidget {

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

  showDetails() {
  }
}
