import 'package:flutter/material.dart';

class SwipingPage extends StatelessWidget {
  const SwipingPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // This is the profile picture
            SizedBox(height: 20),
            new Container(
              child: new Image.asset("assets/joe.jpg",
                  width: 50, height: 50, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            new Container(
              child: new Image.asset("assets/bogosort.png",
                  width: 350, height: 400, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  child: new Image.asset("assets/image 7.png",
                      width: 70, height: 70, fit: BoxFit.cover),
                ),
                SizedBox(width: 200),
                new Container(
                  child: new Image.asset("assets/image 13.png",
                      width: 70, height: 70, fit: BoxFit.cover),
                ),
              ],
            ),
            SizedBox(height: 20),
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '',
                ),
              ],
              selectedItemColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
