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
            SizedBox(height: 0),
            Align(
              alignment: Alignment(-.8, -1),
              child: new Container(
                child: new Image.asset("assets/joe.png",
                    width: 90, height: 90, fit: BoxFit.cover),
              ),
            ),
            Container(
              width: 400,
              height: 400,
              color: Colors.grey[900],
            ),
            //SizedBox(height: 500.0),
          ],
        ),
      ),
    );
  }
}
