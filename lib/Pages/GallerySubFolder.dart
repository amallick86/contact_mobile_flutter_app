import 'package:flutter/material.dart';

import 'ImageViewer.dart';

class GallerySubFolder extends StatefulWidget {
  GallerySubFolder({Key key}) : super(key: key);

  @override
  _GallerySubFolderState createState() => _GallerySubFolderState();
}

class _GallerySubFolderState extends State<GallerySubFolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Album name"))),
      body: Container(
        child: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageViewer()),
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 0),
                  child: Container(
                    width: 165.0,
                    height: 195.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/sewadev-f27b9.appspot.com/o/gallery%2F0_HICLyAdNSIyT0ODU.jpg?alt=media&token=2f08bb2d-089a-4f57-8890-db31cf2283bf"),
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
                ),
              ),
            ]),
      ),
    );
  }
}
