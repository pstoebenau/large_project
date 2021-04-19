import 'package:flutter/material.dart';
import 'package:large_project/models/userInfo.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:large_project/navbar.dart';
import 'login.dart';
import "forgot_pass.dart";


void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => UserInfo(''),
      child: MaterialApp(
        title: 'Chill Chili',
        theme: ThemeData(
          primaryColor: Color(0xff00C2FF),
          accentColor: Color(0xff003EF8),
          backgroundColor: Color(0xff292929),
          brightness: Brightness.dark,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/swipe': (context) => Navbar(initialRoute: 'swipe'),
          '/favorites': (context) => Navbar(initialRoute: 'favorites'),
          '/addSnippet': (context) => Navbar(initialRoute: 'addSnippet'),
          '/leaderboard': (context) => Navbar(initialRoute: 'leaderboard'),
          '/account': (context) => Navbar(initialRoute: 'account'),
        },
      ),

      home: Login(),
    );
  }
}
