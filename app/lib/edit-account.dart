import 'package:flutter/material.dart';

class EditAccount extends StatelessWidget {
  const EditAccount();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50),
            SizedBox(
              width: 800,
              height: 600,
              child: Stack(
                children: <Widget>[
                  // This is the rectangle background
                  Align(
                    alignment: Alignment(0, -.8),
                    child: Expanded(
                      child: Container(
                        child: Image.asset(
                          "assets/Rectangle 27.png",
                          width: 550,
                          height: 550,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.85, -1),
                    child: Container(
                      // This is the user profile picture
                      // This should grab the API user profile pic
                      child: Image.asset("assets/joe.png",
                          width: 90, height: 90, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -.62),
                    child: Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // Maybe put old first Name?
                          
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -.33),
                    child: Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mama',
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -.33),
                    child: Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mama',
                        ),
                      ),
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
