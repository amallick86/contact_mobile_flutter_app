import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600], Colors.red[600]],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          title: Center(child: Text('PROFILE')),
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
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: 130.0,
                              height: 130.0,
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
                              style: GoogleFonts.crimsonText(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(5),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Text(
                              userDocument["Post"],
                              style: GoogleFonts.crimsonText(
                                color: Colors.grey[700],
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(4),
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
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2),
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
                                          0.50,
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
                                              0.56)),
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
                                        style: GoogleFonts.oxygen(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        userDocument["WorkPhone"].toString(),
                                        style: GoogleFonts.crimsonText(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.8),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
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
                                          0, 10, 0, 10),
                                      child: Text(
                                        'Personal Number:',
                                        style: GoogleFonts.oxygen(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        userDocument["PersonalPhone"]
                                            .toString(),
                                        style: GoogleFonts.crimsonText(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.8),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    'Address Details:',
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2),
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
                                        'Temporary:',
                                        style: GoogleFonts.oxygen(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        userDocument["address"],
                                        style: GoogleFonts.crimsonText(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.3),
                                          fontWeight: FontWeight.w700,
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
                                        'Permanent:',
                                        style: GoogleFonts.oxygen(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        userDocument["Permanentaddress"],
                                        style: GoogleFonts.crimsonText(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.3),
                                          fontWeight: FontWeight.w700,
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
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2),
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
                                        ' Work:',
                                        style: GoogleFonts.oxygen(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 10, 0),
                                      child: Text(
                                        userDocument["email"],
                                        style: GoogleFonts.robotoSlab(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
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
                                          0, 10, 0, 10),
                                      child: Text(
                                        'Personal:',
                                        style: GoogleFonts.oxygen(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        right: 10,
                                      ),
                                      child: Text(
                                        userDocument["personalemail"],
                                        style: GoogleFonts.robotoSlab(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    'DOB Details:',
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2),
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
                                          0, 10, 0, 10),
                                      child: Text(
                                        'Date of Birth:',
                                        style: GoogleFonts.oxygen(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 10, bottom: 0),
                                      child: Text(
                                        userDocument["DOB_D"].toString() +
                                            ' / ' +
                                            userDocument["DOB_M"].toString() +
                                            ' / ' +
                                            userDocument["DOB_Y"].toString(),
                                        style: GoogleFonts.robotoSlab(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.3),
                                          fontWeight: FontWeight.w700,
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
