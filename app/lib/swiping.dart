import 'package:flutter/material.dart';

class SwipingPage extends StatelessWidget {
  const SwipingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // This is the profile picture
            Expanded(
              child: Row(
                children: [
                  Image(image: image)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
