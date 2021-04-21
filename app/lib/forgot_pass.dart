import 'dart:convert';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';

import 'globals.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword();

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormBuilderState>();

  void forgotPassword() async {
    final Map<String, dynamic> formData = _formKey.currentState.value;

    final url = Uri.parse('${Globals.apiUrl}/api/account/forgotpassword');
    var response = await post(url,
      headers: { "Content-Type": "application/json" },
      body: json.encode(formData),
    );

    final resObj = json.decode(response.body);
    if (response.statusCode != 201) {
      String err = resObj["message"];
      alert(context, title: Text('Error'), content: Text('$err'));
      return;
    }

    if (resObj['message'] == 'success') {
      await alert(context, title: Text("Success"), content: Text("We sent you an email!"));
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Spacer(flex: 2),
                new Container(
                  child: new Image.asset("assets/chili.png",
                      width: 150, height: 150, fit: BoxFit.cover),
                ),
                SizedBox(height: 40),
                Text(
                  'FORGOT',
                  style: TextStyle(fontSize: 30, letterSpacing: 12),
                ),
                Text(
                  'PASSWORD?',
                  style: TextStyle(fontSize: 30, letterSpacing: 12),
                ),
                SizedBox(height: 20),
                new Container(
                  width: 350,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            suffixIcon: Icon(Icons.mail),
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 60),
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => forgotPassword(),
                    child: Text('RESET PASSWORD'),
                  ),
                ),
                Spacer(flex: 3),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, "/"),
                  child: Text(
                    "Back to Login.",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
