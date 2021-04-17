import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:large_project/navbar.dart';
import 'login.dart';
import './user-account.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chill Chili',
      theme: ThemeData(
        primaryColor: Color(0xff00C2FF),
        accentColor: Color(0xff003EF8),
        backgroundColor: Color(0xff292929),
        brightness: Brightness.dark,
      ),
      home: UserAccountPage(), // Make sure to change this back to login and don't push
    );
  }
}
