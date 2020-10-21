import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EventListView extends StatefulWidget {
  EventListView({
    Key key,
    this.post,
  }) : super(key: key);
  final DocumentSnapshot post;

  @override
  _EventListViewState createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  String fdateonly;
  @override
  initState() {
    super.initState();
    DateTime dateTime = widget.post.data["eventDate"].toDate();
    fdateonly = DateFormat.yMMMMd('en_US').format(dateTime);
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
            title: Center(child: Text("Event"))),
        body: Container(
            child: Padding(
          padding: EdgeInsets.only(
              left: 30.0, right: 30.0, top: 30.0, bottom: 260.0),
          child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.event_available),
                    title: Center(
                      child: Text(
                        widget.post.data["eventTitle"],
                        style: GoogleFonts.oxygen(
                          fontSize: ResponsiveFlutter.of(context).fontSize(2.2),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        fdateonly,
                        style: GoogleFonts.oxygen(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.8),
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.post.data["eventDetails"],
                    style: GoogleFonts.oxygen(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.1),
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
