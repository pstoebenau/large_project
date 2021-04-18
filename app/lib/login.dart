import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:large_project/models/userInfo.dart';

import 'globals.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserInfo userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
  }

  void login() async {
    var url = Uri.parse('${Globals.apiUrl}/api/account/login');
    var response = await post(url, body: {
      "username": "namejeff6",
      "password": "password"
    });
    userInfo.token = json.decode(response.body)['token'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 50),
            new Container(
              child: new Image.asset(
                "assets/chili.png",
                width: 150,
                height: 150,
                fit: BoxFit.cover
              ),
            ),
            SizedBox(height: 40),
            Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 32,
                letterSpacing: 15 
              ),
            ),
            SizedBox(height: 40),
            new Container(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 50),
                  TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  login();
                  Navigator.pushReplacementNamed(context, '/swipe');
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 60),
            Text(
              "Forgot Password?",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10),
            Text(
              "Or create a new account",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}