import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EventNotification extends StatefulWidget {
  EventNotification({Key key}) : super(key: key);

  @override
  _EventNotificationState createState() => _EventNotificationState();
}

class _EventNotificationState extends State<EventNotification> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("program").getDocuments();

    return qn.documents;
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _data = getPosts();
    });
    return null;
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
                          if (dateTime.isAfter(DateTime.now())) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                              ),
                              child: Card(
                                elevation: 10,
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    ListTile(
                                        leading: Icon(Icons.event_available),
                                        title: Text(snapshot
                                            .data[index].data["eventTitle"]),
                                        subtitle: Text(dateTime.toString())),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        snapshot
                                            .data[index].data["eventDetails"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Padding(padding: EdgeInsets.only());
                          }
                        });
                  }
                }),
          ),
        ),
      ),
    );
  }
}
