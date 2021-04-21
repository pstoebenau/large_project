import 'dart:convert';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'general-snippet-view.dart';
import 'models/snippet.dart';
import 'models/userInfo.dart';
import 'globals.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  static const double snippetRatio = 10 / 14;
  UserInfo userInfo;
  final _formKey = GlobalKey<FormBuilderState>();
  Snippet favoriteSnippet;

  @override
  void initState() {
    super.initState();
    userInfo = context.read<UserInfo>();
    getFavorite();
  }

  Future<void> getFavorite() async {
    String formData = json.encode({
      "token": userInfo.token,
    });

    var url = Uri.parse('${Globals.apiUrl}/api/snippet/hottest-snippet');
    var response = await post(
      url,
      headers: { "Content-Type": "application/json" },
      body: formData
    );

    final resObj = json.decode(response.body);
    if (response.statusCode != 200) {
      return alert(context, content: Text(resObj['message']));
    }

    if (resObj['message'] == 'success') {
      setState(() {
        favoriteSnippet = Snippet.fromJson(resObj['snippets']);
      });
      return;
    } else {
      return alert(context, content: Text(resObj['message']));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (favoriteSnippet == null) {
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Your Most Loved Snippet!",
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: (MediaQuery.of(context).size.height * 0.6) * snippetRatio,
                child: codeSnippet(favoriteSnippet),
              ),
              Spacer(),
            ],
          )
        ),
      ),
    );
  }

  Widget codeSnippet(Snippet snippet) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SnippetViewGeneral(snippet),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    snippet.imageURL,
                  ),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${snippet.score} CHILIS', 
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 14,
                letterSpacing: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
