import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:large_project/signup_next.dart';

class Signup extends StatefulWidget {

  Signup();

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: FormBuilder(
              key: _formKey,
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
                          FormBuilderTextField(
                            name: "firstName",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.match(context, r"^[a-zA-Z]+$", errorText: "Value must contain only letters"),
                            ]),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                            ),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: "lastName",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.match(context, r"^[a-zA-Z]+$", errorText: "Value must contain only letters"),
                            ]),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name',
                            ),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: "email",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.email(context),
                            ]),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              suffixIcon: Icon(Icons.mail),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState.validate())
                          return;

                        _formKey.currentState.save();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignupNext(formData: _formKey.currentState.value)
                        ));
                      },
                      child: Text('Next'),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, "/login"),
                    child: Text(
                      "Login to an existing account",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
