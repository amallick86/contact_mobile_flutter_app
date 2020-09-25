import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ContactDetails.dart';

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
            builder: (context) => ContactDetails(
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
                        int bday = snapshot.data[index].data["DOB_D"];
                        int bmonth = snapshot.data[index].data["DOB_M"];
                        if (today.month == bmonth && today.day == bday) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () => navigateToContactDetail(
                                      snapshot.data[index]),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(_photo),
                                  ),
                                  title: Text(
                                      snapshot.data[index].data["fullName"]),
                                  subtitle: Text(
                                    "Today is " +
                                        snapshot.data[index].data["fullName"] +
                                        "'s Birthday ",
                                    style: TextStyle(color: Colors.red[300]),
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.spaceAround,
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
                        } else {
                          return Padding(padding: EdgeInsets.only());
                        }
                      });
                }
              })),
    );
  }
}
