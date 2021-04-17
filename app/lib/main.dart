import 'package:flutter/material.dart';
import 'package:large_project/navbar.dart';
import 'login.dart';
import './user-account.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chill Chili',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xff00C2FF),
        accentColor: Color(0xff003EF8),
        backgroundColor: Color(0xff292929),
        brightness: Brightness.dark,
      ),
      home: UserAccountPage(), // Make sure to change this back to login and don't push
    );
  }
}
