import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // This is the profile picture
            SizedBox(height: 40),
            new Container(
              child: new Image.asset("assets/joe.png",
                  width: 50, height: 50, fit: BoxFit.cover),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}