import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50),
            SizedBox(
              width: 700,
              height: 600,
              child: Stack(
                children: <Widget>[
                  // This is the profile picture
                  Align(
                    alignment: Alignment(0, -0.6),
                    child: new Container(
                      child: new Image.asset(
                        "assets/Rectangle 27.png",
                        width: 550,
                        height: 500,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.8, -1),
                    child: new Container(
                      child: new Image.asset("assets/joe.png",
                          width: 90, height: 90, fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
