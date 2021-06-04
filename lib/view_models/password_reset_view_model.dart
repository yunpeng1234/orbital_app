import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth.dart';
import 'package:orbital_app/services/locator.dart';
import 'base_view_model.dart';
import 'package:orbital_app/routes/nav_key.dart';
import 'package:orbital_app/routes/nav_key.dart';

class PasswordResetViewModel extends BaseViewModel {
  static final String _errorMessage = 'Invalid email.';
  final AuthService _auth = serviceLocator<AuthService>();
  bool _error = false;

  String get errorMessage => _errorMessage;
  bool get error => _error;

  Future passwordReset(email) async {
    setState(ViewState.busy);
    try {
      await _auth.sendPasswordReset(email);
      NavKey.navKey.currentState.pushNamed('signIn');
      _error = false;
    } catch (e) {
      _error = true;
    }
    setState(ViewState.idle);
  }
}