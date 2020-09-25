import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'ImageViewer.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("images").getDocuments();

    return qn.documents;
  }

  navigateToImageViewer(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageViewer(
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
        title: Center(child: Text("Gallery")),
        toolbarHeight: 50,
      ),
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
            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (_, index) {
                  var _image = snapshot.data[index].data["url"];
                  return InkWell(
                    onTap: () => navigateToImageViewer(snapshot.data[index]),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 0),
                      child: Stack(
                        children: [
                          Container(
                            width: 165.0,
                            height: 195.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19.0),
                              image: DecorationImage(
                                image: NetworkImage(_image),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(3, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 0),
                          //   child: Container(
                          //     width: 165.0,
                          //     height: 30.0,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(19.0),
                          //       color: Color.fromRGBO(255, 255, 255, 0.5),
                          //     ),
                          //     child: Center(
                          //         child:
                          //             Text(snapshot.data[index].data["group"])),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      )),
    );
  }
}
