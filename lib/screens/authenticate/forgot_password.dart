import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_screen.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String email = '';
  String error = '';

  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  Future<void> _passwordReset(BuildContext context) async {

    _formkey.currentState.save();
    if (_formkey.currentState.validate()) {
      setState(() => loading = true);
      try {
        await _auth.sendPasswordResetEmail(email: email);
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          error = 'Please provide a valid email address';
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: primaryColor,
      body: AuthenticationScreen(
        title: 'Whoops!',
        subtitle: 'Enter your email and we\'ll send you instructions to reset your password.',
        mainButtonTitle: 'Send',
        errorMessage: error == '' ? null : error,
        form: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              verticalSpaceRegular,
              TextFormField(
                  decoration: textBoxDeco.copyWith(hintText: "Email"),
                  validator: (val) => val.isEmpty ? "Enter a valid email address" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
              ),
            ],
          ),
        ),
        onMainButtonTapped: () => _passwordReset(context),
        // onBackPressed: () => Navigator.pop(context),
        onSignInTapped: () => Navigator.pop(context),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xffFCE5CD) ,
  //     appBar: AppBar(
  //       backgroundColor: Color(0xffFCE5CD),
  //       iconTheme: IconThemeData(
  //         color: Colors.black,
  //       ),
  //       elevation: 0,
  //     ),
  //     body: Form(
  //       key: _formKey,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           TextFormField(
  //             decoration: InputDecoration(
  //               labelText: 'Email',
  //               icon: Icon(
  //                 Icons.mail,
  //               ),
  //             ),
  //             onSaved: (newEmail) {
  //               _email = newEmail;
  //             },
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             child: Text('Send Email'),
  //             onPressed: () {
  //               _passwordReset(context);
  //               print(_email);
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Sign In'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}