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
        // onSignInTapped: () => widget.toggler(),
        onBackPressed: () => widget.toggler(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return loading ? Loading() : Scaffold(
  //     backgroundColor: Color(0xffFCE5CD),
  //     appBar: AppBar(
  //       backgroundColor: Colors.brown[200],
  //       elevation: 0.0,
  //       title: Text('Sign Up'),
  //       actions: <Widget>[
  //         TextButton.icon(
  //           icon: Icon(Icons.person),
  //           label: Text('Sign In'),
  //           onPressed: () {
  //             widget.toggler();
  //           },
  //           )
  //         ],
  //       ),
  //     body: Container(
  //       padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
  //       child: Form(
  //         key: _formkey,
  //         child : Column(
  //           children: <Widget>[
  //             SizedBox(height: 20.0),
  //             TextFormField(
  //               decoration: textBoxDeco.copyWith(hintText: "Email"),
  //               validator: (val) => val.isEmpty ? "Enter an email" : null,
  //               onChanged: (val) {
  //                 setState(() => email = val.trim());
  //               }
  //             ),
  //             SizedBox(height: 20.0),
  //             TextFormField(
  //               decoration: textBoxDeco.copyWith(hintText: "Password"),
  //               validator: (val) => val.length < 6 ? "Please enter a password of at least 6 characters" : null,
  //               obscureText: true,
  //               onChanged: (val) {
  //                 setState(() => password = val);
  //               }
  //             ),
  //             SizedBox(height: 20.0),
  //             ElevatedButton(
  //               child: Text(
  //                 'Register',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () async {
  //                 if (_formkey.currentState.validate()) {
  //                   setState(() => loading = true);
  //                   dynamic result = await _auth.registerNative(email.trim(), password);
  //                   if (result == null) {
  //                     setState(() {
  //                       error = "Please provide a valid email address";
  //                       loading = false;
  //                       });
  //                   }
  //                 }
  //               }
  //             ),
  //             SizedBox(height: 12.0),
  //             Text(
  //               error,
  //               style: TextStyle(color: Colors.red, fontSize: 14.0)
  //             ),
  //           ],
  //           )
  //       )
  //     ),
  //   );
  // }
}
