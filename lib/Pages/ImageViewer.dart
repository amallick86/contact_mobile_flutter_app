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
          title: Center(child: Text("Gallery View")),
        ),
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
