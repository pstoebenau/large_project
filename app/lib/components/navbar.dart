import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MenuItem {
  final String iconName;
  final Color color;
  final double xPos;
  
  MenuItem({this.iconName, this.color, this.xPos});
}

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List items = [
    MenuItem(xPos: -1.0, iconName: 'star.riv', color: Colors.lightBlue[100]),
    MenuItem(xPos: -0.5, iconName: 'star.riv', color: Colors.purple),
    MenuItem(xPos: -0.0, iconName: 'star.riv', color: Colors.greenAccent),
    MenuItem(xPos: 0.5, iconName: 'star.riv', color: Colors.pink),
    MenuItem(xPos: 1.0, iconName: 'star.riv', color: Colors.yellow),
  ];
  MenuItem active;

  Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();

    active = items[0];
    loadRiveAsset('star.riv');
  }

  loadRiveAsset(String asset) {
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load(asset).then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_controller = SimpleAnimation('Animation'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          margin: EdgeInsets.all(15),
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.14),
                offset: Offset(0,8),
              ),
              BoxShadow(
                blurRadius: 14,
                color: Colors.black.withOpacity(0.12),
                offset: Offset(0,3),
              ),
              BoxShadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0,5),
              ),
            ],
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                alignment: Alignment(active.xPos, 1.6),
                padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                child: FractionallySizedBox(
                  widthFactor: 0.15,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: 8,
                    width: w*0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: active.color,
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: items.map((item) {
                    return animatedItem(item);
                  }).toList(),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Widget animatedItem(MenuItem item) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: _rive(),
      ),
      onTap: () {
        setState(() {
          active = item;
          _controller.isActive = !_controller.isActive;
          print(_controller);
        });
      },
    );
  }

  Widget _rive() {
    if (_riveArtboard == null)
      return SizedBox();

    return Rive(
      artboard: _riveArtboard,
    );
  }
}