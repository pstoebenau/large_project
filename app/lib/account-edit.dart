import 'package:flutter/material.dart';

class AccountEditPage extends StatelessWidget {
  const AccountEditPage();
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
                  // This is the rectangle background
                  Align(
                    alignment: Alignment(0, -0.1),
                    child: Container(
                      child: Image.asset(
                        "assets/Rectangle 27.png",
                        width: 550,
                        height: 550,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.85, -1),
                    child: Container(
                      child: Image.asset("assets/joe.png",
                          width: 90, height: 90, fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment(.6, -.85),
                      child: Container(
                        child: Image.asset("assets/edit.png",
                            width: 30, height: 30, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -.85),
                    child: Container(
                      child: Text(
                        'Joe Mama',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.45, -.62),
                    child: Container(
                      child: Text(
                        'username: Joe_Mama',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.43, -.5),
                    child: Container(
                      child: Text(
                        'email: joe@mama.com',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment(0, -.2),
                      child: Container(
                        child: Image.asset("assets/Rectangle 28.png",
                            width: 287, height: 110),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.1, -.28),
                    child: Container(
                      child: Text(
                        'About Me: You\'ve never had it Joe good',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, .08),
                    child: Container(
                      child: Text(
                        'Your Snippets',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.68, .4),
                    child: Container(
                      child: Image.asset("assets/carbon (5) 3.png",
                          width: 100, height: 100),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, .4),
                    child: Container(
                      child: Image.asset("assets/bogosort.png",
                          width: 100, height: 100, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(.68, .4),
                    child: Container(
                      child: Image.asset("assets/carbon (5) 3.png",
                          width: 100, height: 100),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.68, .82),
                    child: Container(
                      child: Image.asset("assets/bogosort.png",
                          width: 100, height: 100, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, .82),
                    child: Container(
                      child: Image.asset("assets/carbon (5) 3.png",
                          width: 100, height: 100, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(.68, .82),
                    child: Container(
                      child: Image.asset("assets/bogosort.png",
                          width: 100, height: 100, fit: BoxFit.cover),
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