import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth.dart';
import 'package:orbital_app/services/locator.dart';
import 'base_view_model.dart';

class SignInViewModel extends BaseViewModel {
  static final String _errorMessage = 'Invalid email/password.';
  final AuthService _auth = serviceLocator<AuthService>();
  bool _error = false;
  String _email;
  String _password;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  set emailInput(String input) {
    _email = input;
  }

  set passwordInput(String input) {
    _password = input;
  }

  Future signIn({String email, String password}) async {
    setState(ViewState.busy);
    // var user = await _auth.signInNative(_email, _password);
    // _error = false;
    // _email = '';
    // _password = '';
    var user = await _auth.signInNative(email, password);
    _error = false;
    setState(ViewState.idle);
    if (user == null) {
      _error = true;
    }
  }
}