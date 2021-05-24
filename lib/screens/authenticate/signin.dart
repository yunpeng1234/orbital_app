import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital_app/services/auth.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggler;

  SignIn({this.toggler});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String  email =  '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Color.fromRGBO(249, 203, 156, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        title: Text('Sign In'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggler();
            },
          )
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child : Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textBoxDeco.copyWith(hintText: "Email"),
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: textBoxDeco.copyWith(hintText: "Password"),
                obscureText: true,
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInNative(email.trim(), password);
                    if (result == null) {
                      setState(() {
                      error = "Invalid email/password";
                      loading = false;
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)
              ),
            ],)
        )
      ),
    );
  }
}