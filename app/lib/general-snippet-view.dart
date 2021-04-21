import 'dart:convert';
import 'dart:developer';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'globals.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'models/snippet.dart';

class SnippetViewGeneral extends StatefulWidget {
  final Snippet snippet;

  const SnippetViewGeneral(this.snippet);
  @override
  _SnippetGeneralViewState createState() => _SnippetGeneralViewState();
}

class _SnippetGeneralViewState extends State<SnippetViewGeneral> {
  void deleteSnippet() async {
    final url = Uri.parse('${Globals.apiUrl}/api/snippet/deleteSnippet');
    var response = await post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"_id": widget.snippet.id}));
    print(response.statusCode);

    var resObj = json.decode(response.body);
    if (response.statusCode != 200) {
      String err = resObj["message"];
      alert(context,
          title: Text('${response.statusCode}'), content: Text('$err'));
      return;
    }
    print(resObj['message']);

    if (resObj['message'] == 'success') {
      if (!mounted)
        dispose();
      else
        setState(() {
          Navigator.pop(context);
          Navigator.pop(context);
        });
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  SizedBox(
                    width: 370,
                  ),
                ]),
                SizedBox(height: 30),
                Image(
                    width: 500,
                    image: NetworkImage(
                      widget.snippet.imageURL,
                    ),
                    fit: BoxFit.fitWidth),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
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
          GestureDetector(
            onTap: () {
              deleteSnippet();
            },
            child: Container(
              child: Text(
                // Grab the description from the API
                'Delete Snippet',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
