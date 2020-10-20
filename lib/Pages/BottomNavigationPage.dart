import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seva_mobileapp/services/authentication.dart';

import 'ContactPage.dart';
import 'GalleryPage.dart';
import 'NotificationsPage.dart';
import 'SettingPage.dart';

class BottomNavigationPage extends StatefulWidget {
  BottomNavigationPage({
    Key key,
    this.auth,
    this.userId,
    this.logoutCallback,
  }) : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _userId;
  VoidCallback logoutCallback;

  int selectedIndex = 0;
  @override
  initState() {
    super.initState();
    logoutCallback = widget.logoutCallback;
    _userId = widget.userId;
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Widget getPage(int index) {
    if (index == 0) {
      return ContactPage();
    }
    if (index == 1) {
      return GalleryPage();
    }
    if (index == 2) {
      return NotificationsPage();
    }
    if (index == 3) {
      return SettingPage(
          auth: widget.auth, userId: _userId, logoutCallback: logoutCallback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getPage(selectedIndex),
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo),
              title: Text(
                'Gallery',
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              title: Text(
                'Notifications',
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              title: Text(
                'Menu',
              )),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey[500],
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
