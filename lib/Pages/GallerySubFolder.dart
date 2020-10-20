import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'ImageViewer.dart';

class GallerySubFolder extends StatefulWidget {
  GallerySubFolder({
    Key key,
    this.post,
  }) : super(key: key);
  final DocumentSnapshot post;

  @override
  _GallerySubFolderState createState() => _GallerySubFolderState();
}

class _GallerySubFolderState extends State<GallerySubFolder> {
  @override
  Future _data;
  String _albumname;

  Future getPosts(_albumname) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("images")
        .where("album", isEqualTo: _albumname)
        .orderBy("createdAt")
        .getDocuments();

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

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _data = getPosts(_albumname);
    });
    return null;
  }

  @override
  initState() {
    _albumname = widget.post.data["albumName"];
    super.initState();
    _data = getPosts(_albumname);
  }

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
        title: Center(child: Text(_albumname)),
        toolbarHeight: 50,
      ),backgroundColor: Colors.grey[200],
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
                return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (_, index) {
                      var _image = snapshot.data[index].data["url"];

                      return InkWell(
                        onTap: () =>
                            navigateToImageViewer(snapshot.data[index]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 3, right: 3, top: 5, bottom: 0),
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
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      )),
    );
  }
}
