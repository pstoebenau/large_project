import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  String fullName = 'Joe Mama'; // Grab from API
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormBuilderState>();
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  // Grab the description from the API
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 75),
                            GestureDetector(
                              onTap: () {
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
                            SizedBox(width: 75),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  // Need API Endpoint connected here
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => UploadSnippet(),
                                  //   ),
                                  // );
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  // Grab the description from the API
                                  'Done',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent[400]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet(context)),
                            );
                          },
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
                        SizedBox(height: 10),
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                child: FormBuilderTextField(
                                  name: 'firstName',
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'First Name',
                                  ),
                                  autocorrect: false,
                                  validator:
                                      FormBuilderValidators.required(context),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 300,
                                child: FormBuilderTextField(
                                  name: 'lastName',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Last Name',
                                  ),
                                  validator:
                                      FormBuilderValidators.required(context),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 300,
                                child: FormBuilderTextField(
                                  name: 'username',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Username',
                                  ),
                                  validator:
                                      FormBuilderValidators.required(context),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 300,
                                child: FormBuilderTextField(
                                  name: 'email',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                  validator:
                                      FormBuilderValidators.required(context),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 300,
                                child: FormBuilderTextField(
                                  name: "aboutMe",
                                  maxLines: 4,
                                  maxLength: 300,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'About Me',
                                  ),
                                  validator:
                                      FormBuilderValidators.required(context),
                                ),
                              ),
                            ],
                          ),
                          // Fill with user's previous input from API
                          initialValue: {
                            'firstName': 'Joe',
                            'lastName': 'Mama',
                            'username': 'joe_mama',
                            'email': 'joe@mama.com',
                            'aboutMe': 'You\'ve never had it Joe good'
                          },
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
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
