import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:orbital_app/screens/authenticate/authentication_screen.dart';
import 'package:orbital_app/services/auth.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';
import 'forgot_password.dart';

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
    return loading ? Loading() : Scaffold(
      backgroundColor: primaryColor,
      body: AuthenticationScreen(
        title: 'Welcome!',
        subtitle: '',
        mainButtonTitle: 'Sign In',
        errorMessage: error == '' ? null : error,
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
                obscureText: true,
                validator: (val) => val.isEmpty ? "Enter a password" : null,
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
            dynamic result = await _auth.signInNative(email.trim(), password);
            if (result == null) {
              setState(() {
                error = "Invalid email/password";
                loading = false;
              });
            }
          }
        },
        onForgotPasswordTapped: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        onCreateAccountTapped: () => widget.toggler(),
      ),
    );
  }




  // @override
  // Widget build(BuildContext context) {
  //   return loading? Loading() : Scaffold(
  //     backgroundColor: primaryColor,
  //     appBar: AppBar(
  //       backgroundColor: Colors.brown[200],
  //       title: Text('Sign In'),
  //       actions: <Widget>[
  //         TextButton.icon(
  //           icon: Icon(
  //             Icons.person,
  //             color: Colors.white,
  //           ),
  //           label: Text(
  //             'Register',
  //             style: TextStyle(
  //               color: Colors.white,
  //             ),
  //           ),
  //           onPressed: () {
  //             widget.toggler();
  //           },
  //         )
  //       ],
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
  //                 setState(() => email = val);
  //               }
  //             ),
  //             SizedBox(height: 10.0),
  //             TextFormField(
  //               decoration: textBoxDeco.copyWith(hintText: "Password"),
  //               obscureText: true,
  //               validator: (val) => val.isEmpty ? "Enter a password" : null,
  //               onChanged: (val) {
  //                 setState(() => password = val);
  //               }
  //             ),
  //             SizedBox(height: 20.0),
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff4E4A40)),
  //               ),
  //               child: Text(
  //                 'Sign In',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () async {
  //                 if (_formkey.currentState.validate()) {
  //                   setState(() => loading = true);
  //                   dynamic result = await _auth.signInNative(email.trim(), password);
  //                   if (result == null) {
  //                     setState(() {
  //                     error = "Invalid email/password";
  //                     loading = false;
  //                     });
  //                   }
  //                 }
  //               }
  //             ),
  //             SizedBox(height: 12.0),
  //             Text(
  //               error,
  //               style: TextStyle(color: Colors.red, fontSize: 14.0)
  //             ),
  //             TextButton(
  //               onPressed: () async {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => ForgotPassword()),
  //                 );
  //               },
  //               child: Text(
  //                 'Forgot password?',
  //                 style: TextStyle(
  //                   color: Color(0xffBE6640),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )
  //       )
  //     ),
  //   );
  // }
}