import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  static const double snippetRatio = 10 / 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/fire.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 300,
                    maxHeight: MediaQuery.of(context).size.height/2,
                  ),
                  child: codeSnippet(32, 'HOTTEST')
                ),
              ]
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: snippetRatio,
                ),
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  String title = "";
                  if (index == 0)
                    title = "Slighty Less Hot";
                  else if (index == 1)
                    title = "Mildly Hot";
                  else
                    title = "Hot";

                  return codeSnippet(15, title);
                },
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget codeSnippet(double fontSize, String description) {
    return GestureDetector(
      onTap: () async {
        return alert(context, title: Text(description));
      },
      child: AspectRatio(
        aspectRatio: snippetRatio,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              description,
              style: TextStyle(
                fontSize: fontSize,
                letterSpacing: 3,
              )
            ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        // 'https://i.ibb.co/wsCBgKj/carbon.png',
                        'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png',
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    )
                  ),
                ),
            ),
            Text(
              '1,000 CHILIS', 
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 14,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
