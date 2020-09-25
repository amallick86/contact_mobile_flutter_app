import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/root_page.dart';
import 'module/theme.dart';
import 'services/authentication.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
            title: 'Seva Development',
            debugShowCheckedModeBanner: false,
            theme: notifier.darkTheme ? dark : light,
            home: new RootPage(auth: new Auth()));
      }),
    );
  }
}
