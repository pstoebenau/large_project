import 'dart:convert';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:large_project/new_password.dart';
import 'package:provider/provider.dart';
import 'package:large_project/models/userInfo.dart';
import 'globals.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserInfo userInfo;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
  }

  void login() async {
    final Map<String, dynamic> formData = _formKey.currentState.value;

    var url = Uri.parse('${Globals.apiUrl}/api/account/login');
    var response = await post(url, body: formData);

    if (response.statusCode != 200) return;

    final resObj = json.decode(response.body);
    if (resObj['message'] == 'success') {
      userInfo.token = resObj['token'];
      Navigator.pushReplacementNamed(context, '/swipe');
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(),
              Container(
                child: new Image.asset("assets/chili.png",
                    width: 150, height: 150, fit: BoxFit.cover),
              ),
              SizedBox(height: 40),
              Text(
                'LOGIN',
                style: TextStyle(fontSize: 32, letterSpacing: 15),
              ),
              SizedBox(height: 40),
              FormBuilder(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FormBuilderTextField(
                        name: 'username',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        validator: FormBuilderValidators.required(context),
                      ),
                      SizedBox(height: 50),
                      FormBuilderTextField(
                        name: 'password',
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: FormBuilderValidators.required(context),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 220,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState.validate()) return;

                            _formKey.currentState.save();
                            login();
                          },
                          child: Text('Login'),
                        ),
                      ),
                    ]),
              ),
              Spacer(flex: 2),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewPassword(),
                    ),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Or create a new account",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
