import 'package:flutter/material.dart';
import './view-account.dart';

class SwipingPage extends StatelessWidget {
  const SwipingPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // This is the profile picture
            SizedBox(height: 40),
            new Container(
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewAccountPage(),
                    ),
                  );
                },
                // This should be replaced with user profile picture
                // Associated with the snippet
                child: new Image.asset("assets/joe.png",
                    width: 50, height: 50, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            new Draggable(
              maxSimultaneousDrags: 1,
              child: DraggableChild(),
              feedback: DraggableChildFeedback(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DraggableTargetWidget(),
                SizedBox(width: 200),
                DraggableFireWidget(),
              ],
            ),
            SizedBox(height: 10),
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '',
                ),
              ],
              selectedItemColor: Colors.teal,
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

class DraggableFireWidget extends StatelessWidget {
  const DraggableFireWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Container>(
      onAccept: (Container container) {
        // go to the next picture
      },
      builder: (context, incoming, rejected) {
        return new Container(
          child: new Image.asset("assets/image 13.png",
              width: 70, height: 70, fit: BoxFit.fitHeight),
        );
      },
    );
  }
}

class DraggableTargetWidget extends StatelessWidget {
  const DraggableTargetWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (Container container) {
        // go to the next picture
      },
      builder: (context, incoming, rejected) {
        return new Container(
          child: new Image.asset("assets/image 7.png",
              width: 70, height: 70, fit: BoxFit.fitHeight),
        );
      },
    );
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Image.asset("assets/bogosort.png",
          width: 350, height: 400, fit: BoxFit.contain),
    );
  }
}

class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Material(
        child: new Container(
          child: new Image.asset("assets/bogosort.png",
              width: 350, height: 400, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
