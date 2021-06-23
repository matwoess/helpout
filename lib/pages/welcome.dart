import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final _text;

  WelcomePage(this._text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_text, style: Theme.of(context).textTheme.headline3),
            Padding(padding: EdgeInsets.only(top: 16.0)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                width: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Go back',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (Route<dynamic> route) {
                      return !route.willHandlePopInternally &&
                          route is ModalRoute &&
                          (route.settings.name == '/detailview' || route.settings.name == '/');
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
