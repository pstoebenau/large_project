import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import './upload-snippet.dart';
import './edit-account.dart';
import 'package:image_picker/image_picker.dart';

import 'models/snippet.dart';

class UserAccountPage extends StatefulWidget {
  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  PickedFile _imageFile;
  static const double snippetRatio = 10 / 14;
  List<Snippet> hotSnippets = [
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
    Snippet('', '', 'https://i.ibb.co/D8ZgZT5/Elevation-l-Container.png', 100),
  ];
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Container(
                              // Grab from API a profile picture
                              child: Image.asset("assets/joe.png",
                                  width: 90, height: 90, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 30),
                            Container(
                              child: Text(
                                // Grab from API the user's name
                                'Joe Mama',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            SizedBox(width: 50),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditAccount(),
                                    ),
                                  );
                                },
                                // This should be replaced with user profile picture
                                // Associated with the snippet
                                child: Container(
                                  // Button that will go to the edit page
                                  child: Image.asset("assets/edit.png",
                                      width: 30, height: 30, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(width: 50),
                          ],
                        ),
                        Container(
                          child: Text(
                            // Grab this from API too
                            'username: Joe_Mama',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Text(
                            // Grab this from the API
                            'email: joe@mama.com',
                            style: TextStyle(fontSize: 17),
                          ),
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
                                    child: Text(
                                      // This is the user description, it should
                                      // Grab from the API the user description
                                      'About Me: You\'ve never had it Joe good',
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
                            'Your Snippets',
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
    );
  }

  Widget codeSnippet(
      {@required Snippet snippet,
      @required double fontSize,
      @required String description}) {
    return GestureDetector(
      onTap: () async {
        return alert(context, title: Text(description));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
