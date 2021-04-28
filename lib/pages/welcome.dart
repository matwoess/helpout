import 'package:flutter/material.dart';
import 'package:helpout/misc/appstate.dart';

class WelcomePage extends StatelessWidget {
  final AppState _appState;
  final _text;

  WelcomePage(this._appState, this._text);

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
            Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Go back'),
                onPressed: () {
                  if (_appState.searchType == SearchType.ASSIST)
                     Navigator.popUntil(
                        context, ModalRoute.withName('/detailview'));
                  else
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
