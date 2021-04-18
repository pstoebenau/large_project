import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:large_project/leaderboard.dart';
import 'package:large_project/login.dart';
import 'package:large_project/swiping.dart';
import 'package:rive/rive.dart';
import 'hot_or_not.dart';

class MenuItem {
  Artboard artboard;
  RiveAnimationController controller;
  final String iconName;
  final Color color;
  final double xPos;
  dynamic route;
  
  MenuItem({this.artboard, this.controller, this.iconName, this.color, this.xPos, this.route});
}

class Navbar extends StatefulWidget {
  final String initialRoute;

  const Navbar({ Key key, this.initialRoute }): super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // Configuration for each navigation icon
  List<MenuItem> items = [
    MenuItem(
      xPos: -1.0,
      artboard: null,
      controller: null,
      iconName: 'fire.riv',
      color: Colors.lightBlue[100],
      route: Swiper(),
    ),
    MenuItem(
      xPos: -0.5,
      artboard: null,
      controller: null,
      iconName: 'heart.riv',
      color: Colors.pink,
      route: SwipingPage(),
    ),
    MenuItem(
      xPos: -0.0,
      artboard: null,
      controller: null,
      iconName: 'add_snippet.riv',
      color: Colors.greenAccent,
      route: Login(),
    ),
    MenuItem(
      xPos: 0.5,
      artboard: null,
      controller: null,
      iconName: 'star.riv',
      color: Colors.yellow,
      route: LeaderBoard(),
    ),
    MenuItem(
      xPos: 1.0,
      artboard: null,
      controller: null,
      iconName: 'head.riv',
      color: Colors.purple,
      route: Login(),
    ),
  ];
  MenuItem active;
  double animDir = 1.0;

  @override
  void initState() {
    super.initState();

    // Get initial route from this mapping
    List<String> routeStrs = ['swipe', 'favorites', 'addSnippet', 'leaderboard', 'account'];
    active = items[routeStrs.indexOf(this.widget.initialRoute)];
    
    for (MenuItem item in items) {
      loadRiveAsset(item);
    }
  }

  // Load animated icon
  loadRiveAsset(MenuItem item) {
    rootBundle.load('assets/rive/${item.iconName}').then(
      (data) async {
        final file = RiveFile.import(data);
        setState(() {
          item.artboard = file.mainArtboard;
          item.artboard.addController(item.controller = SimpleAnimation('idle'));
        });
      },
    );
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            // transitionBuilder: navbarSlideTransition,
            child: active.route,
          ),
          Align(
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom sliding animation for navbar transitions
  Widget navbarSlideTransition(Widget child, Animation<double> animation) {
    final inAnimation =
      Tween<Offset>(begin: Offset(1.0*animDir, 0.0), end: Offset(0.0, 0.0))
          .animate(animation);
    final outAnimation =
        Tween<Offset>(begin: Offset(-1.0*animDir, 0.0), end: Offset(0.0, 0.0))
            .animate(animation);
    
    if (child == active.route) {
      return ClipRect(
        child: SlideTransition(
          position: inAnimation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      );
    } else {
      return ClipRect(
        child: SlideTransition(
          position: outAnimation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      );
    }
  }

  // Handles animation on click
  Widget animatedItem(MenuItem item) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: item.artboard == null
            ? const SizedBox()
            : Rive(artboard: item.artboard),
      ),
      onTap: () {
        setState(() {
          if (active != item) {
            // This determines what way to animate the navbar transition
            if (active.xPos > item.xPos)
              animDir = -1.0;
            else
              animDir = 1.0;
            

            active = item;
          }
          item.artboard.addController(item.controller = SimpleAnimation('go'));
        });
      },
    );
  }
}