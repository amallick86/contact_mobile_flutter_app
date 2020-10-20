import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  ImageViewer({
    Key key,
    this.post,
  }) : super(key: key);
  final DocumentSnapshot post;
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
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
          title: Center(child: Text("Gallery View")),
        ),
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Container(
            child: Image.network(
              widget.post.data["url"],
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
