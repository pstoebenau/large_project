import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/snippet.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class SnippetView extends StatefulWidget {
  final Snippet snippet;

  const SnippetView(this.snippet);
  @override
  _SnippetViewState createState() => _SnippetViewState();
}

class _SnippetViewState extends State<SnippetView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
              SizedBox(width: 320),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet(context)),
                      );
                    },
                    child: Icon(CupertinoIcons.ellipsis_vertical),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      widget.snippet.imageURL,
                    ),
                    fit: BoxFit.contain)),
          ),
          SizedBox(height: 70),
        ],
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
            onTap: () {},
            child: Container(
              child: Text(
                // Grab the description from the API
                'Delete Snippet',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
