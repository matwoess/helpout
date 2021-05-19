import 'package:flutter/material.dart';
import 'package:helpout/model/user.dart';
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
  List<User> persons;

  @override
  void initState() {
    super.initState();
    persons = DemoData.getDemoUsersByRegion(AppState.getInstance().region);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request help"),
      ),
      body: ListView.builder(
          itemBuilder: (context, position) {
            return UserCard(persons[position], showDetails);
          },
          itemCount: persons.length),
    );
  }

  showDetails(User user) {
    if (!AppState.getInstance().loggedIn)
      Navigator.pushNamed(context, '/prelogin');
    else
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailsDialog(user, startChat);
        },
        routeSettings: RouteSettings(name: '/detailview'),
      );
  }

  void startChat(User user) {
    Navigator.of(context).pop();
    print('starting chat with ${user.name}');
  }
}
