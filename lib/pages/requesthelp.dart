import 'package:flutter/material.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/pages/personcard.dart';

import '../misc/dbmanager.dart';
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
    Future<List<User>> users = DBManager.getDemoUsersByRegion(AppState.getInstance().region);
    users.then((value) => persons = value);
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
    AppState.getInstance().chatUser = user;
    while(Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
