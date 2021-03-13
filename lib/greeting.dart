import 'package:flutter/material.dart';
import 'package:helpout/main.dart';

class GreetingPage extends StatelessWidget {
  final String title;
  final Function callback;

  GreetingPage({Key key, this.title, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Welcome to an app to help out others in need!',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () => callback(AppPart.LOGIN),
                    child: Text('login'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
