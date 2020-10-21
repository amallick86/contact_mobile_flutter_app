import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:seva_mobileapp/Pages/ContactView.dart';

class BirthdayListPage extends StatefulWidget {
  BirthdayListPage({Key key}) : super(key: key);

  @override
  _BirthdayListPageState createState() => _BirthdayListPageState();
}

class _BirthdayListPageState extends State<BirthdayListPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("users").orderBy("fullName").getDocuments();

    return qn.documents;
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
      appBar: AppBar(
          toolbarHeight: 50,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600], Colors.red[600]],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          title: Center(child: Text("Birthday List"))),
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
                        return ListTile(
                          onTap: () =>
                              navigateToContactDetail(snapshot.data[index]),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(_photo),
                          ),
                          title: Text(snapshot.data[index].data["fullName"],
                              style: GoogleFonts.crimsonText(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(3),
                              )),
                          subtitle: Text(
                            snapshot.data[index].data["DOB_D"].toString() +
                                ' / ' +
                                snapshot.data[index].data["DOB_M"].toString() +
                                ' / ' +
                                snapshot.data[index].data["DOB_Y"].toString(),
                            style: GoogleFonts.crimsonText(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.3),
                              color: Colors.red[600],
                            ),
                          ),
                        );
                      });
                }
              })),
    );
  }
}
