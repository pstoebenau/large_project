import 'package:flutter/material.dart';

class UploadSnippet extends StatelessWidget {
  const UploadSnippet();
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
                      // This is the user profile picture
                      // This should grab the API user profile pic
                      child: Image.asset("assets/joe.png",
                          width: 90, height: 90, fit: BoxFit.cover),
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
                  Expanded(
                    child: Align(
                      alignment: Alignment(0, -.6),
                      child: Container(
                        child: Image.asset("assets/Rectangle 28.png",
                            width: 287, height: 110),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.1, -.6),
                    child: Container(
                      child: Text(
                        // This is the user description, it should
                        // Grab from the API the user description
                        'About Me: You\'ve never had it Joe good',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -.25),
                    child: Container(
                      child: Text(
                        'Joe\'s Snippets',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.62, 0.1),
                    child: Container(
                      // This should be replaced by a snippet from the user
                      child: Image.asset("assets/carbon (5) 3.png",
                          width: 153, height: 153, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(.62, .1),
                    child: Container(
                      // User snippet here 
                      child: Image.asset("assets/bogosort.png",
                          width: 153, height: 153, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.62, .82),
                    child: Container(
                      // User snippet here
                      child: Image.asset("assets/bogosort.png",
                          width: 153, height: 153, fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(.62, .82),
                    child: Container(
                      // User snippet here
                      child: Image.asset("assets/carbon (5) 3.png",
                          width: 153, height: 153, fit: BoxFit.cover),
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
