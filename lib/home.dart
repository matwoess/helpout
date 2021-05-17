import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpout/pages/browse.dart';
import 'package:helpout/pages/messages.dart';
import 'package:helpout/pages/profile.dart';

import 'model/appstate.dart';

enum NAV_PAGE {
  BROWSE,
  CHATS,
  PROFILE,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NAV_PAGE _selectedIndex = NAV_PAGE.BROWSE;

  void refreshUI() {
    setState(() {
      if (AppState.getInstance().chatPerson != null) {
        setState(() {
          _selectedIndex = NAV_PAGE.CHATS;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    AppState.getInstance().addCallback(refreshUI);
  }

  @override
  void dispose() {
    AppState.getInstance().removeCallback(refreshUI);
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = NAV_PAGE.values[index];
    });
  }

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
                    if (AppState.getInstance().darkTheme)
                      AppState.getInstance().darkTheme = false;
                    else
                      AppState.getInstance().darkTheme = true;
                  });
                },
                child: Text('Toggle Theme'),
              ),
            ),
          ),
          Visibility(
            visible: AppState.getInstance().loggedIn,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      AppState.getInstance().loggedIn = false;
                    });
                  },
                  child: Text('Log out'),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !AppState.getInstance().loggedIn,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      AppState.getInstance().loggedIn = true;
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
      body: _selectedIndex == NAV_PAGE.BROWSE
          ? BrowsePage()
          : _selectedIndex == NAV_PAGE.CHATS
              ? MessagesPage()
              : ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex.index,
        onTap: _onItemTapped,
      ),
    );
  }
}
