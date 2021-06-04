import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';
import 'authentication_screen.dart';


class RegisterForm extends StatefulWidget {

  final Function toggler;

  RegisterForm({this.toggler});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: primaryColor,
      body: AuthenticationScreen(
        title: 'Welcome!',
        subtitle: 'Enter your email and password to register!',
        mainButtonTitle: 'Register',
        form: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              verticalSpaceRegular,
              TextFormField(
                  decoration: textBoxDeco.copyWith(hintText: "Email"),
                  validator: (val) => val.isEmpty ? "Enter your email" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
              ),
              verticalSpaceRegular,
              TextFormField(
                  decoration: textBoxDeco.copyWith(hintText: "Password"),
                  validator: (val) => val.length < 6 ? "Please enter a password of at least 6 characters" : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  }
              ),
            ],
          ),
        ),
        onMainButtonTapped: () async {
          if (_formkey.currentState.validate()) {
            setState(() => loading = true);
            dynamic result = await _auth.registerNative(email.trim(), password);
            if (result == null) {
              setState(() {
                error = "Please provide a valid email address";
                loading = false;
              });
            }
          }
        },
        onSignInTapped: () => widget.toggler(),
      ),
    );
  }
}
