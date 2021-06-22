import 'package:flutter/material.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/pages/usercard.dart';

import '../misc/dbmanager.dart';
import '../model/appstate.dart';
import 'detailsdialog.dart';

class RequestHelpPage extends StatefulWidget {
  RequestHelpPage();

  @override
  _RequestHelpState createState() => _RequestHelpState();
}

class _RequestHelpState extends State<RequestHelpPage> {
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
        title: Text("Request help"),
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemBuilder: (context, position) {
                  return UserCard(User.loading, null);
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

  void startChat(User user) async {
    Navigator.of(context).pop();
    print('setting ${user.username} as auto-open chat user');
    await DBManager.createChatIfNeeded(user);
    AppState.getInstance().chatUser = user;
    while(Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  static Future<List<User>> getUsers() async {
    List<User> users = await DBManager.getDemoUsersByRegion(AppState.getInstance().region);
    return users;
  }
}
