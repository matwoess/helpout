import 'package:flutter/material.dart';

class PreLoginPage extends StatelessWidget {
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/login'),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/signup'),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
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
