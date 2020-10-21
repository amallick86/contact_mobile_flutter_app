import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:seva_mobileapp/Pages/ContactView.dart';
import 'package:url_launcher/url_launcher.dart';

class BirthdayNotification extends StatefulWidget {
  BirthdayNotification({Key key}) : super(key: key);

  @override
  _BirthdayNotificationState createState() => _BirthdayNotificationState();
}

class _BirthdayNotificationState extends State<BirthdayNotification> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("users").orderBy("fullName").getDocuments();

    return qn.documents;
  }

  call(_phone) {
    String call1 = 'tel:' + _phone;
    launch(call1);
  }

  sendsms(_smsphone) {
    String sms1 = 'sms:' + _smsphone;
    launch(sms1);
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _data = getPosts();
    });
    return null;
  }

  navigateToContactDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactView(
                  post: post,
                )));
  }

  @override
  initState() {
    super.initState();
    _data = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
          child: FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFoldingCube(
                      color: Colors.indigoAccent,
                      size: 50.0,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        String _photo = snapshot.data[index].data["photoURL"];
                        DateTime today = DateTime.now();
                        String month = today.month.toString();
                        String day = today.day.toString();
                        String bday =
                            snapshot.data[index].data["DOB_D"].toString();
                        String bmonth =
                            snapshot.data[index].data["DOB_M"].toString();
                        if (month == bmonth && day == bday) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () => navigateToContactDetail(
                                      snapshot.data[index]),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(_photo),
                                  ),
                                  title: Text(
                                    snapshot.data[index].data["fullName"],
                                    style: GoogleFonts.oxygen(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Today is " +
                                        snapshot.data[index].data["fullName"] +
                                        "'s Birthday ",
                                    style: GoogleFonts.oxygen(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.8),
                                      color: Colors.red[300],
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        call(snapshot
                                            .data[index].data["PersonalPhone"]
                                            .toString());
                                      },
                                      child: Icon(
                                        Icons.call,
                                        color: Colors.green,
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        sendsms(snapshot
                                            .data[index].data["PersonalPhone"]
                                            .toString());
                                      },
                                      child: Icon(Icons.message),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                          // ignore: unrelated_type_equality_checks
                        } else {
                          return Padding(padding: EdgeInsets.only());
                        }
                      });
                }
              })),
    );
  }
}
