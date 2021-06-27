import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/util/locator.dart';
import 'package:overlay_support/overlay_support.dart';

class BrowsePage extends StatefulWidget {
  BrowsePage();

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  UserType _searchType = UserType.ASSIST;

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
                if (_searchType == UserType.ASSIST)
                  Navigator.pushNamed(context, '/assist').then(onReturn)
                else if (_searchType == UserType.REQUEST)
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

  setSearchType(UserType st) {
    _searchType = st;
  }

  FutureOr onReturn(dynamic value) {
    setState(() {});
  }
}

class AssistRequestRadioCard extends StatefulWidget {
  final UserType _initialSearchType;
  final Function _setSearchTypeCallback;

  AssistRequestRadioCard(this._initialSearchType, this._setSearchTypeCallback);

  @override
  _AssistRequestRadioCardState createState() => _AssistRequestRadioCardState();
}

class _AssistRequestRadioCardState extends State<AssistRequestRadioCard> {
  UserType _currentSearchType;

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
                value: UserType.REQUEST,
                groupValue: _currentSearchType,
                onChanged: (UserType value) {
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
                value: UserType.ASSIST,
                groupValue: _currentSearchType,
                onChanged: (UserType value) {
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

  // TODO: reload on inserted region (sign up)

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
                            onPressed: getCurrentRegion,
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

  void getCurrentRegion() async {
    Region region = await Locator.getWhereabouts(create: false);
    if (region == Region.unknown) {
      toast('Currently we do not have a region available for your position yet.');
    } else {
      AppState.getInstance().region = region;
    }
  }

  static Future<List<Region>> getRegions() async {
    List<Region> regions = await DBManager.getAvailableRegions();
    return regions;
  }
}
