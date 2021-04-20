import 'dart:convert';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './view-account.dart';
import 'globals.dart';
import 'models/snippet.dart';
import 'models/userInfo.dart';
import 'package:provider/provider.dart';
import 'package:stack/stack.dart' as stack;


class SwipingPage extends StatefulWidget {
  @override
  _SwipingPageState createState() => _SwipingPageState();
}

class _SwipingPageState extends State<SwipingPage> {
  stack.Stack<Snippet> hotSnippet = stack.Stack();
  UserInfo userInfo;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
    getRandomSnippet();
  }

  void getRandomSnippet() async {
    
    final url = Uri.parse('${Globals.apiUrl}/api/snippet/get-random');
    var response = await get(url,
      headers: { "Content-Type": "application/json" }
    );

    var resObj = json.decode(response.body);
    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context, title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }
    if (resObj['message'] == 'success') {
      setState(() {
          hotSnippet.push(Snippet.fromJson(resObj["snippet"]));
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
                child: new Image.asset("assets/joe.png",
                    width: 50, height: 50, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            // API here, need to replace with new photo everytime a widget is clicked, Needs to be initialized?
            codeSnippet(snippet: hotSnippet.pop()),
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
    return 
        Expanded(
            child: Container(
              width: 300,
              height: 500,
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
    );
  }
}