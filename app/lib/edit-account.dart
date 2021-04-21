import 'dart:convert';
import 'dart:io';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'globals.dart';
import 'models/user.dart';
import 'models/userInfo.dart';
import 'package:provider/provider.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormBuilderState>();
  UserInfo userInfo;
  User user = User.empty();

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
    getUserInfo();
  }

  void getUserInfo() async {
    final url = Uri.parse('${Globals.apiUrl}/api/user/getuser');
    var response = await post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"token": userInfo.token}));
    var resObj = json.decode(response.body);

    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context,
          title: Text('${response.statusCode}'), content: Text('$err'));
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

  void editaccountform() async {
    Map<String, dynamic> formData = _formKey.currentState.value;
    Map<String, dynamic> realFormData = {};

    formData.forEach((key, value) {
      realFormData.putIfAbsent(key, () => value);
    });
    realFormData.putIfAbsent("token", () => userInfo.token);
    realFormData.putIfAbsent("newPassword", () => "");
    realFormData.putIfAbsent("email", () => user.email);

    var url = Uri.parse('${Globals.apiUrl}/api/account/account-edit');
    var response = await post(url, body: realFormData);
    print(response);

    if (response.statusCode != 200) return;

    final resObj = json.decode(response.body);
    if (resObj['message'] == 'success' || resObj['message'] == 'success with password change') {
      Navigator.pop(context);
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user.email == "") {
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
      body: SingleChildScrollView(
        child: Center(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40),
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
                                  // onTap: () {
                                  //   showModalBottomSheet(
                                  //     context: context,
                                  //     builder: ((builder) =>
                                  //         bottomSheet(context)),
                                  //   );
                                  //},
                                  child: CircleAvatar(
                                    radius: 45,
                                    // This is the user profile picture
                                    // This should grab the API user profile pic
                                    backgroundImage: NetworkImage(
                                        'https://t3.ftcdn.net/jpg/00/64/67/52/240_F_64675209_7ve2XQANuzuHjMZXP3aIYIpsDKEbF5dD.jpg'),
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
                                      if (!_formKey.currentState.validate())
                                        return;
                                      _formKey.currentState.save();
                                      editaccountform();
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
                            // GestureDetector(
                            //   onTap: () {
                            //     showModalBottomSheet(
                            //       context: context,
                            //       builder: ((builder) => bottomSheet(context)),
                            //     );
                            //   },
                            //   child: Container(
                            //     child: Text(
                            //       // Grab the description from the API
                            //       'Change Profile Photo',
                            //       style: TextStyle(
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.blueAccent[400]),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 10),
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
                                name: 'newUserName',
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
                                name: 'newPassword',
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                                validator:
                                    FormBuilderValidators.required(context),
                              ),
                            ),
                            SizedBox(height: 10),

                            Container(
                              width: 300,
                              child: FormBuilderTextField(
                                name: "about",
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
                            // Fill with user's previous input from API
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
              ],
            ),
            initialValue: {
              'token': userInfo.token,
              'firstName': user.firstName,
              'lastName': user.lastName,
              'about': user.about,
              'newUserName': user.username,
            },
          ),
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
