import 'package:flutter/material.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/user.dart';
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
  List<User> users;

  @override
  void initState() {
    super.initState();
    users = DemoData.getDemoUsersByRegion(AppState.getInstance().region);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assist people in need"),
      ),
      body: ListView.builder(
          itemBuilder: (context, position) {
            return UserCard(users[position], showDetails);
          },
          itemCount: users.length),
    );
  }

  showDetails(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailsDialog(user, startChat);
      },
      routeSettings: RouteSettings(name: '/detailview'),
    );
  }

  void startChat(User user) {
    if (!AppState.getInstance().loggedIn)
      Navigator.pushNamed(context, '/prelogin');
    else {
      print('starting chat with ${user.name}');
      AppState.getInstance().chatUser = user;
      while(Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      //Navigator.pushNamed(context, '/');
    }
  }
}
