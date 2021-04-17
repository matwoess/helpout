import 'dart:async';

import 'package:flutter/material.dart';

import 'appstate.dart';

class GreetingPage extends StatefulWidget {
  @override
  _GreetingPageState createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help out'),
        actions: <Widget>[
          Visibility(
            visible: AppState.loggedIn,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      AppState.loggedIn = false;
                    });
                  },
                  child: Text('Log out'),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !AppState.loggedIn,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      AppState.loggedIn = true;
                    });
                  },
                  child: Text(
                    'Log in',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Welcome to "Help out"!',
                style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'The site to help out people in need and maybe earn some money in the process, or find help from people in your neighborhood.',
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AssistHelpRadioCard(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RegionCard(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                child: Text('Search'),
                onPressed: () => {
                  if (AppState.searchType == SearchType.ASSIST)
                    Navigator.pushNamed(context, '/assist')
                  else if (AppState.searchType == SearchType.REQUEST)
                    if (AppState.loggedIn)
                      Navigator.pushNamed(context, '/request').then(onReturn)
                    else
                      Navigator.pushNamed(context, '/prelogin').then(onReturn)
                  else
                    {print('no/unknown search type selected')}
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureOr onReturn(dynamic value) {
    setState(() {});
  }
}

class AssistHelpRadioCard extends StatefulWidget {
  @override
  _AssistHelpRadioCardState createState() => _AssistHelpRadioCardState();
}

class _AssistHelpRadioCardState extends State<AssistHelpRadioCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'I want to:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            ListTile(
              title: const Text('Find people to assist me'),
              leading: Radio(
                value: SearchType.REQUEST,
                groupValue: AppState.searchType,
                onChanged: (SearchType value) {
                  setState(() {
                    AppState.searchType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Help out people in need'),
              leading: Radio(
                value: SearchType.ASSIST,
                groupValue: AppState.searchType,
                onChanged: (SearchType value) {
                  setState(() {
                    AppState.searchType = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegionCard extends StatefulWidget {
  @override
  _RegionCardState createState() => _RegionCardState();
}

class _RegionCardState extends State<RegionCard> {
  final _regionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _regionTextController,
                decoration: InputDecoration(hintText: 'My region'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
