import 'package:flutter/material.dart';
import './login.dart';

class Landing extends StatelessWidget {
  const Landing();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 20),
            new Container(
              child: new Image.asset("assets/chili.png",
                  width: 200, height: 200, fit: BoxFit.cover),
            ),
            Text(
              'CHILL CHILI',
              style: TextStyle(fontSize: 32, letterSpacing: 15),
            ),
            SizedBox(
              width: 220,
              height: 65,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  ),
                },
                child: Text('Login'),
              ),
            ),
            Text(
              "OR",
            ),
            SizedBox(
              width: 220,
              height: 65,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  ),
                },
                child: Text('Register'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
