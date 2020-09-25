import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ContactDetails.dart';

class User {
  final String name;
  final String company;
  final bool favourite;

  User(this.name, this.company, this.favourite);
}

class InactiveContact extends StatefulWidget {
  InactiveContact({Key key}) : super(key: key);

  @override
  _InactiveContactState createState() => _InactiveContactState();
}

class _InactiveContactState extends State<InactiveContact> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where("status", isEqualTo: "inactive")
        .orderBy("fullName")
        .getDocuments();

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
    //var currentStr = "";
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Inactive Contact"),
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.search),
        //       onPressed: () {
        //         showSearch(context: context, delegate: DataSearch());
        //       })
        // ],
        toolbarHeight: 50,
      ),
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
                            String _photo =
                                snapshot.data[index].data["photoURL"];
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              actions: <Widget>[
                                IconSlideAction(
                                  caption: 'Work Call',
                                  iconWidget: Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    call(snapshot.data[index].data["WorkPhone"]
                                        .toString());
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'Work SMS',
                                  iconWidget: Icon(
                                    Icons.message,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    sendsms(snapshot
                                        .data[index].data["WorkPhone"]
                                        .toString());
                                  },
                                ),
                              ],
                              secondaryActions: [
                                IconSlideAction(
                                  caption: ' Personal Call',
                                  iconWidget: Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    call(snapshot
                                        .data[index].data["PersonalPhone"]
                                        .toString());
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'Personal SMS',
                                  iconWidget: Icon(
                                    Icons.message,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    sendsms(snapshot
                                        .data[index].data["PersonalPhone"]
                                        .toString());
                                  },
                                ),
                              ],
                              child: ListTile(
                                onTap: () => navigateToContactDetail(
                                    snapshot.data[index]),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(_photo),
                                ),
                                title:
                                    Text(snapshot.data[index].data["fullName"]),
                                subtitle:
                                    Text(snapshot.data[index].data["email"]),
                              ),
                            );
                          });
                    }
                  })),
        ),
      ),
    );
  }
}

// class DataSearch extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     //actions for app bar
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             close(context, null);
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // leading icon on the left of the app bar
//     return IconButton(
//         icon: AnimatedIcon(
//             icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // show some result based on search
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     //show when someone search for something
//     return StreamBuilder(
//       stream: Firestore.instance
//           .collection("users")
//           .where("status", isEqualTo: "active")
//           .orderBy("fullName")
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return new Text('Loading...');

//         final results = snapshot.data.documents
//             .where((DocumentSnapshot a) => a.data['fullName'].contains(query));

//         return ListView(
//             children:
//                 results.map<Widget>((a) => Text(a.data['fullName'])).toList());
//       },
//     );
//   }
// }
