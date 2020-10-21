import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactView extends StatefulWidget {
  ContactView({
    Key key,
    this.post,
  }) : super(key: key);
  final DocumentSnapshot post;

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  initState() {
    super.initState();
  }

  call(_phone) {
    String call1 = 'tel:' + _phone;
    launch(call1);
  }

  sendsms(_smsphone) {
    String sms1 = 'sms:' + _smsphone;
    launch(sms1);
  }

  sendemail(_emailid) {
    String email1 = 'mailto:' + _emailid;
    launch(email1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
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
                  image: NetworkImage(widget.post.data["photoURL"]),
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
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300, bottom: 10),
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
                                  widget.post.data["fullName"],
                                  style: GoogleFonts.crimsonText(
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(3),
                                  ),
                                ),
                                subtitle: Text(
                                  widget.post.data["Post"],
                                  style: GoogleFonts.crimsonText(
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2.3),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    widget.post.data["photoURL"],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cake_rounded,
                                      size: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        widget.post.data["DOB_D"].toString() +
                                            ' / ' +
                                            widget.post.data["DOB_M"]
                                                .toString() +
                                            ' / ' +
                                            widget.post.data["DOB_Y"]
                                                .toString(),
                                        style: GoogleFonts.robotoSlab(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
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
                                  padding: EdgeInsets.only(left: 20, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Work Phone",
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2),
                                      color: Colors.grey[500],
                                    ),
                                  )),
                              Container(
                                padding: EdgeInsets.only(left: 20, top: 0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.post.data["WorkPhone"].toString(),
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.5),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.call,
                                          size: 30,
                                          color: Colors.green[600],
                                        ),
                                        onPressed: () {
                                          call(widget.post.data["WorkPhone"]
                                              .toString());
                                        },
                                      ),
                                    ),
                                    Container(
                                        height: 30,
                                        child: VerticalDivider(
                                            color: Colors.grey[600])),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.message_rounded,
                                          color: Colors.green[600],
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          sendsms(widget.post.data["WorkPhone"]
                                              .toString());
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 20, top: 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Personal Phone",
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2),
                                      color: Colors.grey[500],
                                    ),
                                  )),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, top: 0, bottom: 20),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.post.data["PersonalPhone"]
                                          .toString(),
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.5),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.call,
                                          size: 30,
                                          color: Colors.green[600],
                                        ),
                                        onPressed: () {
                                          call(widget.post.data["PersonalPhone"]
                                              .toString());
                                        },
                                      ),
                                    ),
                                    Container(
                                        height: 30,
                                        child: VerticalDivider(
                                            color: Colors.grey[600])),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.message_rounded,
                                          color: Colors.green[600],
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          sendsms(widget
                                              .post.data["PersonalPhone"]
                                              .toString());
                                        },
                                      ),
                                    )
                                  ],
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
                                    bottomRight: Radius.circular(25))),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Work Email",
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: ResponsiveFlutter.of(context)
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.post.data["email"],
                                        style: GoogleFonts.robotoSlab(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.1),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.email_rounded,
                                            color: Colors.green[600],
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            sendemail(
                                                widget.post.data["email"]);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 20, top: 0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Personal Email",
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2),
                                        color: Colors.grey[500],
                                      ),
                                    )),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 0, bottom: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.post.data["personalemail"],
                                        style: GoogleFonts.robotoSlab(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.1),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.email_rounded,
                                            color: Colors.green[600],
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            sendemail(widget
                                                .post.data["personalemail"]);
                                          },
                                        ),
                                      )
                                    ],
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
                                    bottomRight: Radius.circular(25))),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Temporary Address",
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2),
                                        color: Colors.grey[500],
                                      ),
                                    )),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 0, bottom: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.post.data["address"],
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.1),
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 20, top: 0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Permanent Address",
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2),
                                        color: Colors.grey[500],
                                      ),
                                    )),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 0, bottom: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.post.data["Permanentaddress"],
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: ResponsiveFlutter.of(context)
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
      ),
    );
  }
}
