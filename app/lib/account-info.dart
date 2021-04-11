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
                    child: Container(
                      child: Image.asset(
                        "assets/Rectangle 27.png",
                        width: 550,
                        height: 515,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, -1),
                    child: Container(
                      child: Image.asset("assets/joe.png",
                          width: 90, height: 90, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(.6, -.88),
                    child: Container(
                      child: Image.asset("assets/edit.png",
                          width: 30, height: 30, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -.88),
                    child: Container(
                      child: Text( 'Joe Mama', style: TextStyle(fontSize: 25),),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.2, -.7),
                    child: Container(
                      child: Text( 'username: Joe_Mama', style: TextStyle(fontSize: 15),),
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
