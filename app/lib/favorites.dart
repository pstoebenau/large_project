import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'FAVORITES',
              style: TextStyle(fontSize: 32, letterSpacing: 15),
            ),
            SizedBox(height: 40),
            new Container(
              width: 350,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(100, (index) {
                  return Center(
                    child: Text(
                      'Image $index',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
