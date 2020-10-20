import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
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

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff8E24AA), Color(0xffFB8C00)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Menu")),
          toolbarHeight: 50,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600], Colors.red[600]],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            width: 130.0,
                            height: 130.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.green, Colors.blue]),
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                  width: 2.0, color: Colors.grey[200]),
                              image: DecorationImage(
                                image: NetworkImage(userDocument["photoURL"]),
                                fit: BoxFit.fill,
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
                            style: GoogleFonts.lobster(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                foreground: Paint()..shader = linearGradient),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.purple[600],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(100))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.380,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.people,
                                            size: 40.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Inactive User",
                                            style: GoogleFonts.lobsterTwo(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.2),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )),
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
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.orange[600],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(25),
                                            bottomLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(100))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.380,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 40.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "View Profile",
                                            style: GoogleFonts.lobsterTwo(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.2),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )),
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
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.blue[600],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(25),
                                            bottomLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(25))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.380,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cake,
                                            size: 40.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "BirthDay List ",
                                            style: GoogleFonts.lobsterTwo(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.2),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )),
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
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.red[300],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(25),
                                            bottomRight: Radius.circular(100))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.380,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 40.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Calendaer",
                                            style: GoogleFonts.lobsterTwo(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.2),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Card(
                                  elevation: 5,
                                  color: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(100),
                                          topLeft: Radius.circular(100),
                                          topRight: Radius.circular(100))),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.380,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.not_interested,
                                          size: 40.0,
                                          color: Colors.grey[500],
                                        ),
                                        Text(
                                          "Disable",
                                          style: GoogleFonts.lobsterTwo(
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(2.2),
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    )),
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
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.lightBlue[600],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(25),
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(100))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.380,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.exit_to_app,
                                            size: 40.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "SignOut",
                                            style: GoogleFonts.lobsterTwo(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.2),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )),
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
