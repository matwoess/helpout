import 'package:flutter/material.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/pages/detailsdialog.dart';
import 'package:helpout/pages/personcard.dart';

import '../misc/dbmanager.dart';
import '../model/appstate.dart';

class AssistPeoplePage extends StatefulWidget {
  AssistPeoplePage();

  @override
  _AssistPeopleState createState() => _AssistPeopleState();
}

class _AssistPeopleState extends State<AssistPeoplePage> {
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assist people in need"),
      ),
      body: FutureBuilder<List<User>>(
          future: users,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                  itemBuilder: (context, position) {
                    return UserCard(User.loading(), null);
                  },
                  itemCount: 4);
            } else {
              return ListView.builder(
                  itemBuilder: (context, position) {
                    return UserCard(snapshot.data[position], showDetails);
                  },
                  itemCount: snapshot.data.length);
            }
          },
      ),
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
      while (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      //Navigator.pushNamed(context, '/');
    }
  }

  static Future<List<User>> getUsers() async {
    List<User> users = await DBManager.getDemoUsersByRegion(AppState.getInstance().region);
    return users;
  }
}
