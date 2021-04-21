import 'dart:convert';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:large_project/globals.dart';
import 'package:large_project/models/userInfo.dart';
import 'general-snippet-view.dart';
import 'models/snippet.dart';
import 'models/userInfo.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  static const double snippetRatio = 10 / 14;
  List<Snippet> hotSnippets = [];
  UserInfo userInfo;
  int snippetCache = 4;
  int snippetIndex = 0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
    getLeaderboard();
  }

  void getLeaderboard() async {
    // No need to call api if there are no more snippets
    if (hotSnippets.length < snippetIndex)
      return;
    
    final url = Uri.parse('${Globals.apiUrl}/api/snippet/get-by-score');
    var response = await post(url,
      headers: { "Content-Type": "application/json" },
      body: json.encode({
        "startIndex": snippetIndex,
        "numSnippets": snippetIndex == 0 ? snippetCache+1 : snippetCache,
      })
    );

    var resObj = json.decode(response.body);
    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context, title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }

    if (resObj['message'] == 'success') {
      setState(() {
        for (Map<String, dynamic> snippet in resObj['snippets']) {
          hotSnippets.add(Snippet.fromJson(snippet));
        }
      });
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hotSnippets.length == 0) {
      return Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 8,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
            snippetIndex += snippetCache;
            getLeaderboard();
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
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
      ),
    );
  }

  Widget codeSnippet({@required Snippet snippet, @required double fontSize, @required String description}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SnippetViewGeneral(snippet),
          ),
        );
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
                    fit: BoxFit.fitWidth,
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
