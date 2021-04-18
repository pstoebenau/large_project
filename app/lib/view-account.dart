import 'package:flutter/material.dart';

class ViewAccountPage extends StatelessWidget {
  const ViewAccountPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 0),
            SizedBox(
              width: 700,
              height: 600,
              child: Stack(
                children: <Widget>[
                  // This is the rectangle background
                  Container(
                    child: Image.asset(
                      "assets/Rectangle 27.png",
                      width: 550,
                      height: 550,
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
