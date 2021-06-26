import 'package:flutter/material.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/user.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User accountData = AppState.getInstance().accountData;
  bool edit = false;
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  void toggleEdit() {
    setState(() {
      if (edit) {
        accountData.name = _nameTextController.text;
        accountData.description = _descriptionTextController.text;
        DBManager.updateUser(accountData.username, _nameTextController.text, _descriptionTextController.text);
      } else {
        _nameTextController.text = accountData.name;
        _descriptionTextController.text = accountData.description;
      }
      edit = !edit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            color: Theme.of(context).backgroundColor,
            child: Container(
              width: double.infinity,
              height: 400.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      child: Image(image: AssetImage(accountData.assetURI)),
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    edit
                        ? SizedBox(
                            width: 250.0,
                            child: TextField(
                              controller: _nameTextController,
                              decoration:
                                  InputDecoration(hintText: 'Your name'),
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            accountData.name,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '@' + accountData.username,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      accountData.gender.toShortString(),
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Level',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    accountData.level.toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  edit
                                      ? DropdownButton<int>(
                                          value: accountData.price,
                                          //decoration: InputDecoration(hintText: 'My price'),
                                          onChanged: (int newValue) {
                                            setState(() {
                                              accountData.price = newValue;
                                            });
                                          },
                                          underline: Container(
                                            height: 2,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          items: Iterable<int>.generate(15 + 1)
                                              .map<DropdownMenuItem<int>>(
                                                  (int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(value.toString()),
                                            );
                                          }).toList(),
                                        )
                                      : Text(
                                          accountData.price.toString() + '€',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Registered',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  /*Text(
                                    DateFormat('MMMM d, yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            accountData.since)),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  )*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Description:',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 28.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                edit
                    ? TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: _descriptionTextController,
                        decoration:
                            InputDecoration(hintText: 'Tell us about yourself'),
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      )
                    : Text(
                        accountData.description,
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 0),
          child: ElevatedButton(
            onPressed: toggleEdit,
            child: Container(
              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                edit ? 'Apply' : 'Edit Profile',
                style: TextStyle(fontSize: 26.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
