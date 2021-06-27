import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpout/misc/constants.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/pages/achievement.dart';
import 'package:helpout/pages/browse.dart';
import 'package:helpout/pages/chats.dart';
import 'package:helpout/pages/profile.dart';
import 'package:overlay_support/overlay_support.dart';

import 'model/appstate.dart';

enum NAV_PAGE { BROWSE, CHATS, PROFILE, ACHIEVEMENT }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NAV_PAGE _selectedIndex = NAV_PAGE.BROWSE;
  Timer timer;

  void checkForNotifications(Timer _) async {
    AppState appState = AppState.getInstance();
    if (!appState.loggedIn) return;
    int unread = await DBManager.getUnreadCount(appState.accountData.username);
    if (appState.unreadCount > unread) {
      AppState.getInstance().unreadCount = unread;
    } else if (appState.unreadCount < unread) {
      AppState.getInstance().unreadCount = unread;
      if (_selectedIndex != NAV_PAGE.CHATS) {
        showOverlayNotification((context) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: SafeArea(
              child: ListTile(
                leading:
                    SizedBox.fromSize(size: const Size(40, 40), child: ClipOval(child: Icon(Icons.messenger_outline))),
                title: Text('Unread messages'),
                subtitle: Text('You have unread messages.\nCheck the "Chats" page to read and respond to them.'),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context).dismiss();
                    }),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));
      }
    }
  }

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
    timer = Timer.periodic(Duration(seconds: Constants.checkForMessagesDelay), checkForNotifications);
  }

  @override
  void dispose() {
    timer.cancel();
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
                      _selectedIndex = NAV_PAGE.BROWSE;
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
                      Navigator.pushNamed(context, '/prelogin');
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
              icon: AppState.getInstance().unreadCount > 0
                  ? Badge(
                      badgeContent: Text(AppState.getInstance().unreadCount.toString()),
                      child: Icon(Icons.message),
                    )
                  : Icon(Icons.message),
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
