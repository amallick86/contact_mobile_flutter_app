import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Pages/root_page.dart';

import 'services/authentication.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Seva Development',
        debugShowCheckedModeBanner: false,
        home: new RootPage(auth: new Auth()));
  }
}
