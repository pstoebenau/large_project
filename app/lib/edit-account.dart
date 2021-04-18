import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  String fullName = 'Joe Mama'; // Grab from API
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
            Align(
              alignment: Alignment(-1, 0),
              child: SizedBox(
                width: 800,
                height: 600,
                child: Stack(
                  children: <Widget>[
                    // This is the rectangle background
                    Align(
                      alignment: Alignment(0, -.8),
                      child: Expanded(
                        child: Container(
                          child: Image.asset(
                            "assets/Rectangle 27.png",
                            width: 550,
                            height: 550,
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet(context)),
                          );
                      },
                      child: Align(
                        alignment: Alignment(0, -1),
                        child: CircleAvatar(
                          radius: 45,
                          // This is the user profile picture
                          // This should grab the API user profile pic
                          backgroundImage: _imageFile == null ? AssetImage("assets/joe.png") : (FileImage(File(_imageFile.path))),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -.67),
                      child: Container(
                        child: Text(
                          // Grab the description from the API
                          'Change Profile Photo',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent[400]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -.55),
                      child: Container(
                        width: 300,
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                          ),
                          autocorrect: false,
                          onChanged: (String value) {
                            fullName = value;
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -.27),
                      child: Container(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, .01),
                      child: Container(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, .29),
                      child: Container(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'About Me',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, .55),
                      child: Container(
                          width: 260,
                          height: 50,
                          child: FlatButton(
                            onPressed: () {
                              // Need API Endpoint connected here
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => UploadSnippet(),
                              //   ),
                              // );
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/update_button.png',
                            ),
                          )),
                    ),
                  ],
                ),
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
