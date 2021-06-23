import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/util/locator.dart';

class BrowsePage extends StatefulWidget {
  BrowsePage();

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  SearchType _searchType = SearchType.ASSIST;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Welcome to "Help out"!', style: Theme.of(context).textTheme.headline4),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'The site to help out people in need and maybe earn some money in the process, or find help from people in your neighborhood.',
                style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AssistRequestRadioCard(_searchType, setSearchType),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegionCard(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              onPressed: () => {
                if (_searchType == SearchType.ASSIST)
                  Navigator.pushNamed(context, '/assist').then(onReturn)
                else if (_searchType == SearchType.REQUEST)
                  if (AppState.getInstance().loggedIn)
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
    );
  }

  setSearchType(SearchType st) {
    _searchType = st;
  }

  FutureOr onReturn(dynamic value) {
    setState(() {});
  }
}

class AssistRequestRadioCard extends StatefulWidget {
  final SearchType _initialSearchType;
  final Function _setSearchTypeCallback;

  AssistRequestRadioCard(this._initialSearchType, this._setSearchTypeCallback);

  @override
  _AssistRequestRadioCardState createState() => _AssistRequestRadioCardState();
}

class _AssistRequestRadioCardState extends State<AssistRequestRadioCard> {
  SearchType _currentSearchType;

  @override
  void initState() {
    _currentSearchType = widget._initialSearchType;
    super.initState();
  }

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
                groupValue: _currentSearchType,
                onChanged: (SearchType value) {
                  setState(() {
                    _currentSearchType = value;
                    widget._setSearchTypeCallback(value);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Assist people'),
              leading: Radio(
                value: SearchType.ASSIST,
                groupValue: _currentSearchType,
                onChanged: (SearchType value) {
                  setState(() {
                    _currentSearchType = value;
                    widget._setSearchTypeCallback(value);
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
  RegionCard();

  @override
  _RegionCardState createState() => _RegionCardState();
}

class _RegionCardState extends State<RegionCard> {
  Future<List<Region>> regions;

  @override
  void initState() {
    regions = getRegions();
    super.initState();
  }

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
            FutureBuilder<List<Region>>(
              future: regions,
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 8.0, 16.0, 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<Region>(
                          isExpanded: true,
                          value: AppState.getInstance().region,
                          //decoration: InputDecoration(hintText: 'My region'),
                          onChanged: (Region newValue) {
                            setState(() {
                              AppState.getInstance().region = newValue;
                            });
                          },
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).accentColor,
                          ),
                          items: snapshot.connectionState == ConnectionState.waiting
                              ? null
                              : snapshot.data
                                  .map((e) => DropdownMenuItem<Region>(
                                        child: Text(e.toString()),
                                        value: e,
                                      ))
                                  .toList(),
                          hint: snapshot.connectionState == ConnectionState.waiting
                              ? Text('Getting available regions')
                              : Text('Select region'),
                        ),
                      ),
                      Visibility(
                        visible: snapshot.connectionState != ConnectionState.waiting,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ElevatedButton(
                            onPressed: getWhereabouts,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.my_location),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
      AppState.getInstance().currentPosition = pos;
      Region region = await Locator.getRegionFromPosition(pos, await getRegions());
      print('region: ' + region.toString());
      if (region == Region.unknown) {
        print('unknown region, do not change current selection.');
      } else {
        AppState.getInstance().region = region;
      }
      return region;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  static Future<List<Region>> getRegions() async {
    List<Region> regions = await DBManager.getAvailableRegions();
    return regions;
  }
}
