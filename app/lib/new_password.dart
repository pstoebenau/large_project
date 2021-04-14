import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  const NewPassword();

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
              'NEW',
              style: TextStyle(fontSize: 32, letterSpacing: 15),
            ),
            Text(
              'PASSWORD',
              style: TextStyle(fontSize: 32, letterSpacing: 15),
            ),
            SizedBox(height: 40),
            new Container(
              width: 350,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        suffixIcon: Icon(Icons.remove_red_eye),
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
                child: Text('Change password'),
              ),
            ),
            SizedBox(height: 60),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
