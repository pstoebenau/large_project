import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 50),
            new Container(
              child: new Image.asset("assets/chili.png",
                  width: 150, height: 150, fit: BoxFit.cover),
            ),
            SizedBox(height: 40),
            Text(
              'FORGOT PASSWORD?',
              style: TextStyle(fontSize: 20, letterSpacing: 12),
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
                        suffixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'OR',
                      style: TextStyle(fontSize: 20, letterSpacing: 12),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.mail),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => {},
                child: Text('RESET PASSWORD'),
              ),
            ),
            SizedBox(height: 60),
            Text(
              "Back to Login.",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
