import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import './view-account.dart';

class SwipingPage extends StatelessWidget {
  const SwipingPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // This is the profile picture
            SizedBox(height: 30),
            new Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewAccountPage(),
                    ),
                  );
                },
                // This should be replaced with user profile picture
                // Associated with the snippet
                child: CircleAvatar(
                  radius: 25,
                  // This is the user profile picture
                  // This should grab the API user profile pic
                  backgroundImage: NetworkImage(
                      'https://t3.ftcdn.net/jpg/00/64/67/52/240_F_64675209_7ve2XQANuzuHjMZXP3aIYIpsDKEbF5dD.jpg'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: new Image.asset("assets/bogosort.png",
                  width: 350, height: 400, fit: BoxFit.contain),
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    return alert(context, title: Text("Trash!"));
                  },
                  child: Container(
                    child: new Image.asset("assets/image 15.png",
                        width: 70, height: 70, fit: BoxFit.fitHeight),
                  ),
                ),
                SizedBox(width: 200),
                GestureDetector(
                  onTap: () async {
                    return alert(context, title: Text("Fire!"));
                  },
                  child: Container(
                    child: new Image.asset("assets/fire 2.png",
                        width: 70, height: 70, fit: BoxFit.fitHeight),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
