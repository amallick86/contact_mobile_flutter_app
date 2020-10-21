import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  initState() {
    super.initState();
    _userId = widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 1.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(userDocument["photoURL"]),
                            fit: BoxFit.fill,
                          )),
                        ),
                        Positioned(
                          // --> App Bar
                          child: AppBar(
                            toolbarHeight: 50,
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            leading: Padding(
                              // --> Custom Back Button
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                mini: true,
                                onPressed: this._onBackPressed,
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 300, bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                            bottomLeft: Radius.circular(25),
                                            bottomRight: Radius.circular(25))),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            userDocument["fullName"],
                                            style: GoogleFonts.crimsonText(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(3),
                                            ),
                                          ),
                                          subtitle: Text(
                                            userDocument["Post"],
                                            style: GoogleFonts.crimsonText(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.3),
                                            ),
                                          ),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                              userDocument["photoURL"],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20, bottom: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.cake_rounded,
                                                size: 30,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  userDocument["DOB_D"]
                                                          .toString() +
                                                      ' / ' +
                                                      userDocument["DOB_M"]
                                                          .toString() +
                                                      ' / ' +
                                                      userDocument["DOB_Y"]
                                                          .toString(),
                                                  style: GoogleFonts.robotoSlab(
                                                    fontSize:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .fontSize(2.5),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey[400],
                                          height: 0,
                                          thickness: 1,
                                          indent: 0,
                                          endIndent: 0,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Work Phone",
                                              style: GoogleFonts.robotoSlab(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2.2),
                                                color: Colors.grey[500],
                                              ),
                                            )),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 20, top: 0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            userDocument["WorkPhone"]
                                                .toString(),
                                            style: GoogleFonts.robotoSlab(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.5),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 0),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Personal Phone",
                                              style: GoogleFonts.robotoSlab(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2.2),
                                                color: Colors.grey[500],
                                              ),
                                            )),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20, top: 0, bottom: 20),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            userDocument["PersonalPhone"]
                                                .toString(),
                                            style: GoogleFonts.robotoSlab(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Card(
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 20),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Work Email",
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2.2),
                                                  color: Colors.grey[500],
                                                ),
                                              )),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 20,
                                              top: 0,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              userDocument["email"],
                                              style: GoogleFonts.robotoSlab(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2.1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 10),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Personal Email",
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2.2),
                                                  color: Colors.grey[500],
                                                ),
                                              )),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 0, bottom: 20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              userDocument["personalemail"],
                                              style: GoogleFonts.robotoSlab(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2.1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Card(
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 20),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Temporary Address",
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2.2),
                                                  color: Colors.grey[500],
                                                ),
                                              )),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 0, bottom: 20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              userDocument["address"],
                                              style: GoogleFonts.robotoSlab(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2.1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 0),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Permanent Address",
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2.2),
                                                  color: Colors.grey[500],
                                                ),
                                              )),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 0, bottom: 20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              userDocument["Permanentaddress"],
                                              style: GoogleFonts.robotoSlab(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2.1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
