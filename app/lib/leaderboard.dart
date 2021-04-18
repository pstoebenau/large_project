import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'models/snippet.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  static const double snippetRatio = 10 / 14;
  List<Snippet> hotSnippets = [
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet(1, 1, 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.height*snippetRatio/2 + 75,
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
                    constraints: BoxConstraints(
                      minHeight: 300,
                      maxHeight: MediaQuery.of(context).size.height/2,
                    ),
                    child: AspectRatio(
                      aspectRatio: snippetRatio,
                      child: codeSnippet(
                        snippet: hotSnippets[0],
                        description: 'HOTTEST',
                        fontSize: 32,
                      ),
                    ),
                  ),
                ]
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: snippetRatio,
                  ),
                  itemCount: hotSnippets.length-1,
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

                    return codeSnippet(
                      snippet: hotSnippets[index+1],
                      description: title,
                      fontSize: 14,
                    );
                  },
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget codeSnippet({@required Snippet snippet, @required double fontSize, @required String description}) {
    return GestureDetector(
      onTap: () async {
        return alert(context, title: Text(description));
      },
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
                      snippet.imageURL,
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  )
                ),
              ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${snippet.score} CHILIS', 
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 14,
                letterSpacing: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
