import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  String fullName = 'Joe Mama'; // Grab from API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50),
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
                    Align(
                      alignment: Alignment(0, -1),
                      child: Container(
                        // This is the user profile picture
                        // This should grab the API user profile pic
                        child: Image.asset("assets/joe.png",
                            width: 90, height: 90, fit: BoxFit.cover),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -.62),
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
                      alignment: Alignment(0, -.33),
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
                      alignment: Alignment(0, -.05),
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
                      alignment: Alignment(0, .23),
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
                      alignment: Alignment(0, .53),
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
}
