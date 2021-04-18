import 'package:flutter/material.dart';

class ViewAccountPage extends StatelessWidget {
  const ViewAccountPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 0),
            Column(
              children: [
                SizedBox(
                  width: 700,
                  height: 600,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          child: Image.asset(
                            "assets/Rectangle 27.png",
                            width: 550,
                            height: 550,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // This is the user profile picture
                                  // This should grab the API user profile pic
                                  child: Image.asset("assets/joe.png",
                                      width: 90, height: 90, fit: BoxFit.cover),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  child: Text(
                                    'Joe Mama',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                SizedBox(width: 130),
                              ],
                            ),
                            SizedBox(height: 0),
                            Stack(
                              children: [
                                Center(
                                  child: Container(
                                    child: Image.asset(
                                        "assets/Rectangle 28.png",
                                        width: 287,
                                        height: 110),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Container(
                                        child: Text(
                                          // This is the user description, it should
                                          // Grab from the API the user description
                                          'About Me: You\'ve never had it Joe good',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                'Joe\'s Snippets',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // This should be replaced by a snippet from the user
                                  child: Image.asset("assets/carbon (5) 3.png",
                                      width: 153,
                                      height: 153,
                                      fit: BoxFit.cover),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  // User snippet here
                                  child: Image.asset("assets/bogosort.png",
                                      width: 153,
                                      height: 153,
                                      fit: BoxFit.cover),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // User snippet here
                                  child: Image.asset("assets/bogosort.png",
                                      width: 153, height: 153, fit: BoxFit.cover),
                                ),
                                                                SizedBox(width: 5),

                                Container(
                                  // User snippet here
                                  child: Image.asset("assets/carbon (5) 3.png",
                                      width: 153, height: 153, fit: BoxFit.cover),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
