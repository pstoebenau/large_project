import 'package:flutter/material.dart';
import './upload-snippet.dart';
import './edit-account.dart';
import 'package:image_picker/image_picker.dart';

class UserAccountPage extends StatefulWidget {
  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 0),
            SizedBox(
              width: 700,
              height: 600,
              child: Stack(
                children: <Widget>[
                  // This is the rectangle background
                  Center(
                    child: Container(
                      child: Image.asset(
                        "assets/Rectangle 27.png",
                        width: 550,
                        height: 550,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // Grab from API a profile picture
                            child: Image.asset("assets/joe.png",
                                width: 90, height: 90, fit: BoxFit.cover),
                          ),
                          SizedBox(width: 50),
                          Container(
                            child: Text(
                              // Grab from API the user's name
                              'Joe Mama',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          SizedBox(width: 40),
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
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
                          SizedBox(width: 20),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // snippet from API
                            child: Image.asset("assets/carbon (5) 3.png",
                                width: 100, height: 100),
                          ),
                          SizedBox(width: 5),
                          Container(
                            // snippet from API
                            child: Image.asset("assets/bogosort.png",
                                width: 100, height: 100, fit: BoxFit.cover),
                          ),
                          SizedBox(width: 5),
                          Container(
                            // snippet from API
                            child: Image.asset("assets/carbon (5) 3.png",
                                width: 100, height: 100),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // snippet from API
                            child: Image.asset("assets/bogosort.png",
                                width: 100, height: 100, fit: BoxFit.cover),
                          ),
                          SizedBox(width: 5),
                          Container(
                            // snippet from API
                            child: Image.asset("assets/carbon (5) 3.png",
                                width: 100, height: 100, fit: BoxFit.cover),
                          ),
                          SizedBox(width: 5),
                          Container(
                            // snippet from API
                            child: Image.asset("assets/bogosort.png",
                                width: 100, height: 100, fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
        height: 25.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FlatButton.icon(
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              icon: Icon(Icons.camera),
              label: Text("Camera")),
          SizedBox(width: 50),
          FlatButton.icon(
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Photo Library")),
        ]));
  }
}
