import 'package:flutter/material.dart';
import './login.dart';

class Landing extends StatelessWidget {
  const Landing();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Image.asset("assets/chili.png",
                    width: 200, height: 200, fit: BoxFit.fitWidth),
              ),
              SizedBox(height: 40),
              Text(
                'CHILL CHILI',
                style: TextStyle(fontSize: 32, letterSpacing: 15),
              ),
              SizedBox(height: 80),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
                  child: Text('Login'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "OR",
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, "/signup"),
                  child: Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
