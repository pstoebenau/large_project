import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

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
    MenuItem(xPos: -1.0, iconName: 'planet.flr', color: Colors.lightBlue[100]),
    MenuItem(xPos: -0.5, iconName: 'camera.flr', color: Colors.purple),
    MenuItem(xPos: -0.0, iconName: 'heart.flr', color: Colors.greenAccent),
    MenuItem(xPos: 0.5, iconName: 'house.flr', color: Colors.pink),
    MenuItem(xPos: 1.0, iconName: 'head.flr', color: Colors.yellow),
  ];
  MenuItem active;

  @override
  void initState() { 
    super.initState();
    
    active = items[0];
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
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
                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: items.map((item) {
                    return _flare(item);
                  }).toList(),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Widget _flare(MenuItem item) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: FlareActor(
          'assets/${item.iconName}',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          color: item.color,
          animation: item.iconName == active.iconName ? 'go' : 'idle',
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