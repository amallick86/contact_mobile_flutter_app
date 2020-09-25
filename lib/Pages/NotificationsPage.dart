import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:seva_mobileapp/module/theme.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: notifier.darkTheme ? dark : light,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 50,
                bottom: TabBar(
                  indicatorColor: Colors.red,
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
      }),
    );
  }
}
