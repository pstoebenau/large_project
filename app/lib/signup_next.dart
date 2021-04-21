import 'dart:convert';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';

import 'globals.dart';

class SignupNext extends StatefulWidget {
  final Map<String, dynamic> formData;

  SignupNext({Key key, this.formData }): super(key: key);

  @override
  _SignupNextState createState() => _SignupNextState();
}

class _SignupNextState extends State<SignupNext> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _confirmPasswordError;

  Future<void> signup() async {
    final Map<String, dynamic> nextFormData = _formKey.currentState.value;

    Map<String, dynamic> finalFormData = {};
    widget.formData.forEach((key, value) => finalFormData.putIfAbsent(key, () => value));
    nextFormData.forEach((key, value) => finalFormData.putIfAbsent(key, () => value));

    var url = Uri.parse('${Globals.apiUrl}/api/account/signup');
    var response = await post(
      url,
      headers: { "Content-Type": "application/json" },
      body: json.encode(finalFormData)
    );

    if (response.statusCode != 200)
      alert(context, title: Text("Error"), content: Text(json.decode(response.body)["message"]));

    final resObj = json.decode(response.body);
    if (resObj['message'] == 'success') {
      await alert(context, title: Text("Success"), content: Text("Verify your email"));
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: BoxConstraints(maxWidth: 400),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Spacer(),
                  Container(
                    child: Image.asset("assets/chili.png",
                        width: 150, height: 150, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 32, letterSpacing: 15),
                  ),
                  SizedBox(height: 30),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FormBuilderTextField(
                          name: "username",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.match(context, r"[a-zA-Z0-9]+")
                          ]),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            suffixIcon: Icon(Icons.account_circle),
                          ),
                        ),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: "password",
                          validator: FormBuilderValidators.required(context),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: "confirmPassword",
                          validator: FormBuilderValidators.required(context),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                            suffixIcon: Icon(Icons.remove_red_eye),
                            errorText: _confirmPasswordError,
                          ),
                        ),
                      ]),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.fields["password"].value != _formKey.currentState.fields["confirmPassword"].value) {
                          setState(() {
                            _confirmPasswordError = "Password must match";
                          });

                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                        }
                        _confirmPasswordError = null;

                        _formKey.currentState.save();

                        signup();
                      },
                      child: Text('CREATE ACCOUNT'),
                    ),
                  ),
                  Spacer(flex: 2),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, "/login"),
                    child: Text(
                      "Login to an existing account",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
