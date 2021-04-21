import 'dart:convert';
import 'general-snippet-view.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './view-account.dart';
import 'globals.dart';
import 'models/snippet.dart';
import 'models/user.dart';
import 'models/userInfo.dart';
import 'package:provider/provider.dart';

class SwipingPage extends StatefulWidget {
  @override
  _SwipingPageState createState() => _SwipingPageState();
}

class _SwipingPageState extends State<SwipingPage> {
  Snippet hotSnippet = Snippet.empty();
  UserInfo userInfo;
  User user = User.empty();

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
    getNextSnippet();
  }

  Future<void> getNextSnippet() async {
    user = User.empty();
    await getRandomSnippet();
    getUserInfo(hotSnippet.userId);
  }

  Future<void> getUserInfo(String userId) async {
    final url = Uri.parse('${Globals.apiUrl}/api/user/getuserbyId');
    var response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"_id": userId}),
    );

    var resObj = json.decode(response.body);

    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context,
          title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }

    print(resObj);
    if (resObj["user"] == null) {
      await getNextSnippet();
      return;
    }
    if (resObj['message'] == 'success') {
      setState(() {
        user = User.fromJson(resObj["user"]);
      });
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  Future<void> updateScore(Snippet snippet) async {
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

  Future<void> getRandomSnippet() async {
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
      });
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hotSnippet.id == "") {
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
                child: Container(
                  // Grab from API a profile picture
                  child: CircleAvatar(
                    radius: 25,
                    // This is the user profile picture
                    // This should grab the API user profile pic
                    backgroundImage: NetworkImage(
                        'https://t3.ftcdn.net/jpg/00/64/67/52/240_F_64675209_7ve2XQANuzuHjMZXP3aIYIpsDKEbF5dD.jpg'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              // Grab the description from the API
              user.username,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 5),
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
                    getNextSnippet();
                  },
                  child: Container(
                    child: new Image.asset("assets/image 15.png",
                        width: 70, height: 70, fit: BoxFit.fitHeight),
                  ),
                ),
                SizedBox(width: 200),
                GestureDetector(
                  onTap: () async {
                    await updateScore(hotSnippet);
                    getNextSnippet();
                  },
                  child: Container(
                    child: new Image.asset("assets/fire 2.png",
                        width: 70, height: 70, fit: BoxFit.fitHeight),
                  ),
                ),
              ],
            ),
            SizedBox(height: 96)
          ],
        ),
      ),
    );
  }

  Widget codeSnippet({@required Snippet snippet}) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SnippetViewGeneral(snippet),
          ),
        );
      },
      child: Expanded(
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
      ),
    );
  }
}
