import 'package:orbital_app/screens/authenticate/verify_email_view.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'dart:async';

class RegisterViewModel extends BaseViewModel {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthService _auth = serviceLocator<AuthService>();
  String _errorMessage;

  String get errorMessage => _errorMessage;

  void setEmail(String email) {
    _emailController.text = email;
  }

  void setPassword(String password) {
    _passwordController.text = password;
  }

  void setUsername(String username) {
    _usernameController.text = username;
  }

  Future register(GlobalKey<FormState> formKey) async {
    if (! processForm(formKey)) {
      return;
    }
    var user = await runBusyFuture(
        _auth.registerNative(
            _emailController.text,
            _passwordController.text,
            _usernameController.text,
        ));
    if (user == null) {
      setError(true);
      return;
    }
    navigateAndReplace('/');
  }

  Future registerWithVerification(GlobalKey<FormState> formKey, BuildContext context) async {
    if (! processForm(formKey)) {
      return;
    }
    await runBusyFuture(_auth.registerWithVerification(_emailController.text, _passwordController.text, _usernameController.text))
        .then((_) => _showVerificationDialog(context), onError: (e) {
      _errorMessage = e.code.splitMapJoin((RegExp(r'-')),
        onMatch: (m) => ' ',
      );
      _errorMessage = 'Error: ${_errorMessage[0].toUpperCase()}${_errorMessage.substring(1)}.';
    });
  }

  Future _showVerificationDialog(BuildContext context) {
    Timer verificationChecker;
    Timer kicker;

    kicker = Timer(Duration(seconds:60), () async {
      await _auth.deleteUser();
      navKey.currentState.pop();
      _showResubmitDialog(context);
      verificationChecker.cancel();
    });

    verificationChecker = Timer.periodic(Duration(seconds:2), (timer) async {
      bool isVerified = await _auth.isEmailVerified();
      if (isVerified) {
        timer.cancel();
        kicker.cancel();
        await _auth.createUser(_usernameController.text);
        navKey.currentState.pop();
        navKey.currentState.pushReplacementNamed('/');
      }
    });
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>  AlertDialog(
          title: Center(child: Text('A verification email has been sent to ${_emailController.text}.\n\nPlease verify within the next minute to proceed.')),
          titleTextStyle: blackBodyTextLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
    );
  }

  Future _showResubmitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) =>  AlertDialog(
          title: Center(child: Text('Timed out')),
          titleTextStyle: blackBodyTextLarge,
          content: Text(
            'Please register again',
            textAlign: TextAlign.center,
          ),
          contentTextStyle: greyBodyText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
    );
  }

  // Future<void> checkEmailVerified() async {
  //
  //   await user.reload();
  //   if (user.emailVerified) {
  //     timer.cancel();
  //     kicker.cancel();
  //     await auth.createUser(widget.name);
  //     navKey.currentState.pushReplacementNamed('/');
  //   }
  // }
}