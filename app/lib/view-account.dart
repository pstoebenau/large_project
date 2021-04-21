import 'dart:convert';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:large_project/general-snippet-view.dart';
import './upload-snippet.dart';
import './edit-account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'globals.dart';
import 'models/snippet.dart';
import 'models/user.dart';
import 'models/userInfo.dart';

class ViewAccountPage extends StatefulWidget {
  final String userId;

  const ViewAccountPage(this.userId);
  @override
  _ViewAccountPageState createState() => _ViewAccountPageState();
}

class _ViewAccountPageState extends State<ViewAccountPage> {
  UserInfo userInfo;
  static const double snippetRatio = 10 / 14;
  List<Snippet> hotSnippets = [];
  int snippetCache = 4;
  int snippetIndex = 0;
  final _scrollController = ScrollController();
  User user;
  bool loading = true;

  @override
  void initState() {
    if (!mounted) return;
    super.initState();
    userInfo = context.read<UserInfo>();
    getUserEverything();
  }

  void getUserEverything() async {
    getUserInfo(widget.userId);
    await getUserSnippets(widget.userId);
  }

  Future<void> getUserInfo(String userId) async {
    final url = Uri.parse('${Globals.apiUrl}/api/user/getuserbyId');
    var response = await post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"_id": userId}));
    var resObj = json.decode(response.body);

    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context,
          title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }

    if (resObj['message'] == 'success' && mounted) {
      setState(() {
        user = User.fromJson(resObj["user"]);
      });
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  Future<void> getUserSnippets(String userId) async {
    // No need to call api if there are no more snippets
    if (hotSnippets.length < snippetIndex) return;

    final url = Uri.parse('${Globals.apiUrl}/api/snippet/get-user-snippets');
    var response = await post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "userId": userId,
          "startIndex": snippetIndex,
          "numSnippets": snippetIndex == 0 ? snippetCache + 1 : snippetCache,
        }));

    var resObj = json.decode(response.body);
    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context,
          title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }

    if (resObj['message'] == 'success' && mounted) {
      setState(() {
        for (Map<String, dynamic> snippet in resObj['snippets']) {
          hotSnippets.add(Snippet.fromJson(snippet));
        }
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
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            snippetIndex += snippetCache;
            getUserSnippets(widget.userId);
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 25),
                SizedBox(
                  child: Stack(
                    children: <Widget>[
                      // This is the rectangle background
                      // Center(
                      //   child: Expanded(
                      //     child: Container(
                      //       width: 500,
                      //       height: 500,
                      //       child: Image.asset(
                      //         "assets/Rectangle 27.png",
                      //         width: 500,
                      //         height: 500,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                            SizedBox(
                              width: 370,
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Container(
                                // Grab from API a profile picture
                                child: CircleAvatar(
                                  radius: 45,
                                  // This is the user profile picture
                                  // This should grab the API user profile pic
                                  backgroundImage: NetworkImage(
                                      'https://t3.ftcdn.net/jpg/00/64/67/52/240_F_64675209_7ve2XQANuzuHjMZXP3aIYIpsDKEbF5dD.jpg'),
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                width: 250,
                                child: Text(
                                  // Grab from API the user's name
                                  user.firstName + " " + user.lastName,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  child: Image.asset("assets/Rectangle 28.png",
                                      width: 287, height: 110),
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      width: 250,
                                      height: 110,
                                      child: Text(
                                        // This is the user description, it should
                                        // Grab from the API the user description
                                        'About Me: ' + user.about,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                              // Insert API call for First Name here
                              user.firstName + '\'s Snippets',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            constraints: BoxConstraints(
                              maxWidth: 370,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: snippetRatio,
                              ),
                              itemCount: hotSnippets.length - 1,
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
                                  snippet: hotSnippets[index + 1],
                                  description: title,
                                  fontSize: 14,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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

  Widget codeSnippet(
      {@required Snippet snippet,
      @required double fontSize,
      @required String description}) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(description,
              style: TextStyle(
                fontSize: fontSize,
                letterSpacing: 3,
              )),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                  snippet.imageURL,
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )),
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
