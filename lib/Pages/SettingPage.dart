import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:seva_mobileapp/module/theme.dart';
import 'package:seva_mobileapp/services/authentication.dart';

import 'BirthdayListPage.dart';
import 'CalendarScreen.dart';
import 'InactiveContact.dart';
import 'ViewProfile.dart';

class SettingPage extends StatefulWidget {
  SettingPage({
    Key key,
    this.auth,
    this.userId,
    this.logoutCallback,
  }) : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _userId;
  @override
  initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Menu")),
          toolbarHeight: 50,
        ),
        body: Container(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(_userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              var userDocument = snapshot.data;
              return SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Container(
                            width: 130,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              image: DecorationImage(
                                image: NetworkImage(userDocument["photoURL"]),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x29000000),
                                  offset: Offset(10, 10),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            userDocument["fullName"],
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: InkWell(
                                  hoverColor: Colors.red,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InactiveContact()),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.440,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 40.0,
                                        ),
                                        Text(
                                          "Inactive User",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: InkWell(
                                  hoverColor: Colors.red,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SelfProfile(
                                                userId: _userId,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.440,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 40.0,
                                        ),
                                        Text(
                                          "View Profile",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: InkWell(
                                  hoverColor: Colors.red,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BirthdayListPage()),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.440,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cake,
                                          size: 40.0,
                                        ),
                                        Text(
                                          "BirthDay List ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: InkWell(
                                  hoverColor: Colors.red,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CalendarScreen()),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.440,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 40.0,
                                        ),
                                        Text(
                                          "Calendaer",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.440,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Consumer<ThemeNotifier>(
                                        builder: (context, notifier, child) =>
                                            Switch(
                                          activeColor:
                                              Theme.of(context).buttonColor,
                                          onChanged: (val) {
                                            notifier.toggleTheme();
                                          },
                                          value: notifier.darkTheme,
                                        ),
                                      ),
                                      Text(
                                        "Dark Mood",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      )
                                    ],
                                  )),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: InkWell(
                                  hoverColor: Colors.red,
                                  onTap: () {
                                    signOut();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.440,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.exit_to_app,
                                          size: 40.0,
                                        ),
                                        Text(
                                          "SignOut",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
