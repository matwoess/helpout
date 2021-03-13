import 'package:flutter/material.dart';

class PreLoginPage extends StatelessWidget {
  final Function callback;

  PreLoginPage({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login / Sign up"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'You need an account to use our service.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(padding: EdgeInsets.only(top: 48.0)),
                Text(
                  'Sign in or create a new account?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Navigator.popAndPushNamed(context, '/login'),
                          child: Text('Login')),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Navigator.popAndPushNamed(context, '/signup'),
                          child: Text('Sign up')),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
