import 'dart:convert';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './view-account.dart';
import 'globals.dart';
import 'models/snippet.dart';
import 'models/userInfo.dart';
import 'package:provider/provider.dart';

class SwipingPage extends StatefulWidget {
  @override
  _SwipingPageState createState() => _SwipingPageState();
}

class _SwipingPageState extends State<SwipingPage> {
  Snippet hotSnippet = Snippet.empty();
  UserInfo userInfo;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
    getRandomSnippet();
  }

  void updateScore(Snippet snippet) async {
    final url = Uri.parse('${Globals.apiUrl}/api/snippet/updateScore');
    var response = await post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"_id": snippet.id}));

    var resObj = json.decode(response.body);
    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context,
          title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }
    if (resObj['message'] != 'success') {
      return alert(context, content: Text(resObj['message']));
    }
  }

  void getRandomSnippet() async {
    final url = Uri.parse('${Globals.apiUrl}/api/snippet/get-random');
    var response =
        await get(url, headers: {"Content-Type": "application/json"});

    var resObj = json.decode(response.body);
    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context,
          title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }
    if (resObj['message'] == 'success') {
      setState(() {
        hotSnippet = Snippet.fromJson(resObj["snippet"]);
        loading = false;
      });
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // This is the profile picture
            SizedBox(height: 30),
            // new Container(
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => ViewAccountPage(),
            //         ),
            //       );
            //     },
            //     // This should be replaced with user profile picture
            //     // Associated with the snippet
            //     child: new Image.asset("assets/joe.png",
            //         width: 50, height: 50, fit: BoxFit.fitWidth),
            //   ),
            // ),
            SizedBox(height: 20),
            // API here, need to replace with new photo everytime a widget is clicked, Needs to be initialized?
            AnimatedSwitcher(
              duration: Duration(milliseconds: 2000),
              child: codeSnippet(snippet: hotSnippet),
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    getRandomSnippet();
                  },
                  child: Container(
                    child: new Image.asset("assets/image 15.png",
                        width: 70, height: 70, fit: BoxFit.fitHeight),
                  ),
                ),
                SizedBox(width: 200),
                GestureDetector(
                  onTap: () async {
                    updateScore(hotSnippet);
                    getRandomSnippet();
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

  Widget codeSnippet({@required Snippet snippet}) {
    return Expanded(
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
            snippet.imageURL,
          ),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        )),
      ),
    );
  }
}
