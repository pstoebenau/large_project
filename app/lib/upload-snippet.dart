import 'dart:convert';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'models/userInfo.dart';
import 'globals.dart';

class UploadSnippet extends StatefulWidget {
  @override
  _UploadSnippetState createState() => _UploadSnippetState();
}

class _UploadSnippetState extends State<UploadSnippet> {
  UserInfo userInfo;
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
  }

  Future<void> uploadSnippet() async {
    Map<String, dynamic> formData = _formKey.currentState.value;
    String realFormData = json.encode({
      "token": userInfo.token,
      "codeText": formData["codeText"],
    });

    if (!mounted)
      dispose();
    else
      setState(() {
        isLoading = true;
      });

    var url = Uri.parse('${Globals.apiUrl}/api/snippet/create');
    var response = await post(url,
        headers: {"Content-Type": "application/json"}, body: realFormData);
    final resObj = json.decode(response.body);

    if (!mounted)
      dispose();
    else
      setState(() {
        isLoading = false;
      });

    if (response.statusCode != 200) {
      return alert(context, content: Text(resObj['message']));
    }

    if (resObj['message'] == 'success') {
      return alert(context, content: Text("Your snippet was uploaded!"));
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    double aboveNavbarHeight = MediaQuery.of(context).size.height - 100;
    double maxLines = aboveNavbarHeight / 30;

    if (isLoading) {
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
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: aboveNavbarHeight,
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: BoxConstraints(maxWidth: 700),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 20),
              Text(
                "Type your code or paste it here",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              FormBuilder(
                  key: _formKey,
                  child: Column(children: [
                    FormBuilderTextField(
                      name: "codeText",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "print('Hello World')",
                        fillColor: Colors.grey.shade900,
                        filled: true,
                      ),
                      style: TextStyle(
                        fontFamily: "RobotoMono",
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: maxLines.floor(),
                      validator: FormBuilderValidators.maxLength(context, 2000),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 220,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState.validate()) return;

                          _formKey.currentState.save();
                          uploadSnippet();
                        },
                        child: Text('Create'),
                      ),
                    ),
                  ])),
            ]),
          ),
        ),
      ),
    );
  }
}
