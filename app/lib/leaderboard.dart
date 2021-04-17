import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            codeSnippet(350, 'Hottest'),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                codeSnippet(200, 'Slightly Less Hot'),
                codeSnippet(200, 'Mildly Hot'),
              ]
            ),
            SizedBox(height: 110),
          ],
        ),
      ),
    );
  }
}

Widget codeSnippet(double size, String description) {
  return SizedBox(
    height: size,
    child: Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(description),
          Expanded(
            child: Image.network(
              'https://i.kym-cdn.com/photos/images/newsfeed/001/857/750/4ab.png',
              height: size*0.8,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text('1,000,000,000 Chilis'),
        ],
      ),
    ),
  );
}