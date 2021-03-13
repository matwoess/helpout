import 'package:flutter/material.dart';

import 'appstate.dart';
import 'main.dart';

class GreetingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Help out'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
            ],
          ),
        ));
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
                groupValue: MainApp.state.searchType,
                onChanged: (SearchType value) {
                  setState(() {
                    MainApp.state.searchType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Help out people in need'),
              leading: Radio(
                value: SearchType.HELP,
                groupValue: MainApp.state.searchType,
                onChanged: (SearchType value) {
                  setState(() {
                    MainApp.state.searchType = value;
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                child: Text('Search'),
                onPressed: () => {
                  if (MainApp.state.loggedIn)
                    {
                      if (MainApp.state.searchType == SearchType.HELP)
                        Navigator.pushNamed(context, '/helpout')
                      else if (MainApp.state.searchType == SearchType.REQUEST)
                        Navigator.pushNamed(context, '/findhelpers')
                      else
                        print('no/unknown search type selected')
                    }
                  else
                    Navigator.pushNamed(context, '/prelogin')
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
