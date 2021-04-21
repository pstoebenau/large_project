import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 50),
            new Container(
              child: new Image.asset("assets/chili.png",
                  width: 150, height: 150, fit: BoxFit.cover),
            ),
            SizedBox(height: 40),
            Text(
              'REGISTER',
              style: TextStyle(fontSize: 32, letterSpacing: 15),
            ),
            SizedBox(height: 40),
            new Container(
              width: 350,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.mail),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => {},
                child: Text('Next'),
              ),
            ),
            SizedBox(height: 60),
            Text(
              "Login to an existing account",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
