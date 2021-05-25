import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpout/pages/achievement.dart';
import 'package:helpout/pages/browse.dart';
import 'package:helpout/pages/chats.dart';
import 'package:helpout/pages/profile.dart';

import 'misc/demodata.dart';
import 'model/appstate.dart';

enum NAV_PAGE {
  BROWSE,
  CHATS,
  PROFILE,
  ACHIEVEMENT
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NAV_PAGE _selectedIndex = NAV_PAGE.BROWSE;

  void refreshUI() {
    setState(() {
      if (AppState.getInstance().chatUser != null) {
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
                      AppState.getInstance().accountData = null;
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
                      AppState.getInstance().accountData =
                          DemoData.getMyAccount();
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
          ? ChatsPage()
          : _selectedIndex == NAV_PAGE.ACHIEVEMENT
          ? AchievementPage()
          : ProfilePage(),
      bottomNavigationBar: Visibility(
        visible: AppState.getInstance().loggedIn,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              label: 'Achievement',
            ),
          ],
          currentIndex: _selectedIndex.index,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
