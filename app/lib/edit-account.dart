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
            SizedBox(
              width: 800,
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
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        FlatButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet(context)),
                            );
                          },
                          child: CircleAvatar(
                            radius: 45,
                            // This is the user profile picture
                            // This should grab the API user profile pic
                            backgroundImage: _imageFile == null
                                ? AssetImage("assets/joe.png")
                                : (FileImage(File(_imageFile.path))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Text(
                            // Grab the description from the API
                            'Change Profile Photo',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent[400]),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
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
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          child: TextField(
                            maxLines: 4,
                            maxLength: 300,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'About Me',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 50,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    'assets/cancel.png',
                                  ),
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                width: 150,
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
                                    'assets/update.png',
                                  ),
                                ),
                              ),
                            ]),
                        FlatButton(
                          onPressed: (){},
                          child: Container(
                            child: Text(
                              // Grab the description from the API
                              'Change Password',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent[400]),
                            ),
                          ),
                        ),
                      ],
                    ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        ],
      ),
    );
  }
}
