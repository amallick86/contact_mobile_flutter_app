import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:seva_mobileapp/Pages/GallerySubFolder.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("album").orderBy("albumName").getDocuments();

    return qn.documents;
  }

  navigateTogallerysubfolder(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GallerySubFolder(
                  post: post,
                )));
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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600], Colors.red[600]],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        title: Center(child: Text("Gallery")),
        toolbarHeight: 50,
      ),
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
                return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () =>
                            navigateTogallerysubfolder(snapshot.data[index]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 3, right: 3, top: 5, bottom: 0),
                          child: Stack(
                            children: [
                              Container(
                                width: 165.0,
                                height: 195.0,
                                child: Center(
                                  child: Icon(Icons.image),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19.0),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Container(
                                  width: 165.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19.0),
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                  ),
                                  child: Center(
                                      child: Text(
                                    snapshot.data[index].data["albumName"],
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          )),
        ),
      ),
    );
  }
}
