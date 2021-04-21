import 'package:flutter/material.dart';

class Signup_next extends StatelessWidget {
  const Signup_next();

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
                        labelText: 'Username',
                        suffixIcon: Icon(Icons.account_circle),
                      ),
                    ),
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
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Thank you for signing in"),
                      content: Text("Verify your email address"),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("Verify my email"),
                        ),
                      ],
                    ),
                  ),
                },
                child: Text('CREATE ACCOUNT'),
              ),
            ),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, "/"),
              child: Text(
                "Login to an existing account",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
