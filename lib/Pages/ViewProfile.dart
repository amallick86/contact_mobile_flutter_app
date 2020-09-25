import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class SelfProfile extends StatefulWidget {
  SelfProfile({
    Key key,
    this.userId,
  }) : super(key: key);
  final String userId;
  @override
  _SelfProfileState createState() => _SelfProfileState();
}

class _SelfProfileState extends State<SelfProfile> {
  String _userId;

  @override
  initState() {
    super.initState();
    _userId = widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Profile')),
        ),
        body: Container(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(_userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFoldingCube(
                      color: Colors.indigoAccent,
                      size: 50.0,
                    ),
                  );
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
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: MediaQuery.of(context).size.height * 0.20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23.0),
                                image: DecorationImage(
                                  image: NetworkImage(userDocument["photoURL"]),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    width: 2.0, color: const Color(0xffe4480f)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x29000000),
                                    offset: Offset(15, 15),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              userDocument["fullName"],
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(4.5),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              userDocument["Post"],
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(3),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.only(top: 50, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Text(
                                    'Phone Number Details:',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffe4480f)),
                                      ),
                                    ),
                                    Container(
                                      width: ((MediaQuery.of(context)
                                              .size
                                              .width) -
                                          (MediaQuery.of(context).size.width *
                                              0.49)),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffb9b6b6)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'Work Number:',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(
                                        '+977-' +
                                            userDocument["WorkPhone"]
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        'Personal Number:',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        '+977-' +
                                            userDocument["PersonalPhone"]
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    'Address Details:',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.31,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffe4480f)),
                                      ),
                                    ),
                                    Container(
                                      width: ((MediaQuery.of(context)
                                              .size
                                              .width) -
                                          (MediaQuery.of(context).size.width *
                                              0.37)),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffb9b6b6)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        'Address:',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        userDocument["address"],
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    'Email:',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffe4480f)),
                                      ),
                                    ),
                                    Container(
                                      width: ((MediaQuery.of(context)
                                              .size
                                              .width) -
                                          (MediaQuery.of(context).size.width *
                                              0.18)),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffb9b6b6)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'Email:',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        userDocument["email"],
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    'DOB Details:',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.24,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffe4480f)),
                                      ),
                                    ),
                                    Container(
                                      width: ((MediaQuery.of(context)
                                              .size
                                              .width) -
                                          (MediaQuery.of(context).size.width *
                                              0.30)),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffb9b6b6)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'Date of Birth:',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        userDocument["DOB_D"].toString() +
                                            ' / ' +
                                            userDocument["DOB_M"].toString() +
                                            ' / ' +
                                            userDocument["DOB_Y"].toString(),
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
