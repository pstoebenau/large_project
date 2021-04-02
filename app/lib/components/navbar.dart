import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class NavBar extends StatefulWidget {
  createState() => NavBarState();
}

class MenuItem {
  final String name;
  final Color color;
  final double x;
  MenuItem({this.name, this.color, this.x});
}

class NavBarState extends State<NavBar> {
  List items = [
    MenuItem(x: -1.0, name: 'house', color: Colors.lightBlue[100]),
    MenuItem(x: -0.5, name: 'planet', color: Colors.purple),
    MenuItem(x: 0.0, name: 'camera', color: Colors.greenAccent),
    MenuItem(x: 0.5, name: 'heart', color: Colors.pink),
    MenuItem(x: 1.0, name: 'head', color: Colors.yellow),
  ];

  MenuItem active;

  @override
  void initState() {
    super.initState();

    active = items[0]; // <-- 1. Activate a menu item
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      color: Colors.black,
      child: Stack(    //  <-- 2. Define a stack
        children: [
          AnimatedContainer(  //  <-- 3. Animated top bar
            duration: Duration(milliseconds: 200),
            alignment: Alignment(active.x, -1),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: 8,
              width: w * 0.2,
              color: active.color,
            ),
          ),
          Container(  // <-- 4. Main menu row
            child: Row(   
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                return _rive(item);  // <-- 5. Flare graphic will go here
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _rive(MenuItem item) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Rive(
            'assets/${item.name}.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: item.name == active.name ? 'go' : 'idle',
          ),
        ),
      ),
      onTap: () {
        setState(() {
          active = item;
        });
      },
    );
  }
}