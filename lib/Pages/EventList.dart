import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:seva_mobileapp/Pages/EventListView.dart';

class EventList extends StatefulWidget {
  EventList({Key key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("program")
        .orderBy("eventDate")
        .getDocuments();

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
            builder: (context) => EventListView(
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
          title: Center(child: Text("Event List"))),
      backgroundColor: Colors.grey[200],
      body: Container(
          child: RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
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
                        DateTime dateTime =
                            snapshot.data[index].data["eventDate"].toDate();

                        String fdateonly =
                            DateFormat.yMMMMd('en_US').format(dateTime);
                        return ListTile(
                          onTap: () =>
                              navigateToContactDetail(snapshot.data[index]),
                          leading: Icon(Icons.event),
                          title: Text(snapshot.data[index].data["eventTitle"],
                              style: GoogleFonts.crimsonText(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2.5),
                              )),
                          subtitle: Text(
                            fdateonly,
                            style: GoogleFonts.crimsonText(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.3),
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      )),
    );
  }
}
