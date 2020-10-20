import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'BirthdayNotification.dart';
import 'EventNotification.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[600], Colors.red[600]],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 50,
            bottom: TabBar(
              indicatorColor: Colors.yellow[100],
              tabs: [
                Tab(
                  text: 'Birthday',
                ),
                Tab(
                  text: 'Event',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [BirthdayNotification(), EventNotification()],
          ),
        ),
      ),
    );
  }
}
