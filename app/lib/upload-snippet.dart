import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadSnippet extends StatefulWidget {
  @override
  _UploadSnippetState createState() => _UploadSnippetState();
}

class _UploadSnippetState extends State<UploadSnippet> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Container(
        height: 25.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        ]),
      ),
    ]);
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
