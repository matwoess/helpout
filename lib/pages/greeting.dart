import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpout/misc/demodata.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/util/locator.dart';

import '../model/appstate.dart';

class GreetingPage extends StatefulWidget {
  final AppState _appState;
  final Function _stateUpdater;

  GreetingPage(this._appState, this._stateUpdater);

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
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget._appState.darkTheme)
                      widget._appState.darkTheme = false;
                    else
                      widget._appState.darkTheme = true;
                    widget._stateUpdater(widget._appState);
                  });
                },
                child: Text('Toggle Theme'),
              ),
            ),
          ),
          Visibility(
            visible: widget._appState.loggedIn,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget._appState.loggedIn = false;
                      widget._stateUpdater(widget._appState);
                    });
                  },
                  child: Text('Log out'),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !widget._appState.loggedIn,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget._appState.loggedIn = true;
                      widget._stateUpdater(widget._appState);
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Welcome to "Help out"!',
                  style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'The site to help out people in need and maybe earn some money in the process, or find help from people in your neighborhood.',
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  AssistHelpRadioCard(widget._appState, widget._stateUpdater),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RegionCard(widget._appState, widget._stateUpdater),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                child: Text('Search'),
                onPressed: () => {
                  if (widget._appState.searchType == SearchType.ASSIST)
                    Navigator.pushNamed(context, '/assist').then(onReturn)
                  else if (widget._appState.searchType == SearchType.REQUEST)
                    if (widget._appState.loggedIn)
                      Navigator.pushNamed(context, '/request').then(onReturn)
                    else
                      Navigator.pushNamed(context, '/prelogin').then(onReturn)
                  else
                    print('no/unknown search type selected')
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
  final AppState _appState;
  final Function _stateUpdater;

  AssistHelpRadioCard(this._appState, this._stateUpdater);

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
              title: const Text('Request help'),
              leading: Radio(
                value: SearchType.REQUEST,
                groupValue: widget._appState.searchType,
                onChanged: (SearchType value) {
                  setState(() {
                    widget._appState.searchType = value;
                    widget._stateUpdater(widget._appState);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Assist people'),
              leading: Radio(
                value: SearchType.ASSIST,
                groupValue: widget._appState.searchType,
                onChanged: (SearchType value) {
                  setState(() {
                    widget._appState.searchType = value;
                    widget._stateUpdater(widget._appState);
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
  final AppState _appState;
  final Function _stateUpdater;

  RegionCard(this._appState, this._stateUpdater);

  @override
  _RegionCardState createState() => _RegionCardState();
}

class _RegionCardState extends State<RegionCard> {
  var _availableRegions = DemoData.getAvailableRegions();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'In Region:',
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 8.0, 16.0, 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<Region>(
                      isExpanded: true,
                      value: widget._appState.region,
                      //decoration: InputDecoration(hintText: 'My region'),
                      onChanged: (Region newValue) {
                        setState(() {
                          widget._appState.region = newValue;
                        });
                      },
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).accentColor,
                      ),
                      items: _availableRegions
                          .map<DropdownMenuItem<Region>>((Region value) {
                        return DropdownMenuItem<Region>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: getWhereabouts,
                      child: Icon(Icons.my_location),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Region> getWhereabouts() async {
    try {
      var pos = await Locator.getCurrentPosition();
      print('position: ' + pos.toString());
      Region region =
          await Locator.getRegionFromPosition(pos, _availableRegions);
      print('region: ' + region.toString());
      widget._appState.currentPosition = pos;
      widget._appState.region = region;
      widget._stateUpdater(widget._appState);
      return region;
    } catch (ex) {
      print(ex);
      return null;
    }
  }
}
