import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import '../base_view_model.dart';

class SignInViewModel extends BaseViewModel {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final AuthService _auth = serviceLocator<AuthService>();
  String _errorMessage;

  String get errorMessage => _errorMessage;

  void setEmail(String email) {
    _emailController.text = email;
  }

  void setPassword(String password) {
    _passwordController.text = password;
  }

  Future signIn(GlobalKey<FormState> formKey) async {
    if (! processForm(formKey)) {
      return;
    }
    await runBusyFuture(_auth.signInNative(_emailController.text, _passwordController.text))
        .then((_) => navigateAndReplace('/'), onError: (e) {
      _errorMessage = e.code.splitMapJoin((RegExp(r'-')),
        onMatch: (m) => ' ',
      );
      _errorMessage = 'Error: ${_errorMessage[0].toUpperCase()}${_errorMessage.substring(1)}.';
    });
  }
}