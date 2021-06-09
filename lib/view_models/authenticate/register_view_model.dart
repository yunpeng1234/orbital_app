import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import '../base_view_model.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel {
  static final String _errorMessage = "Invalid email.";
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final AuthService _auth = serviceLocator<AuthService>();

  String get errorMessage => _errorMessage;

  void setEmail(String email) {
    _emailController.text = email;
  }

  void setPassword(String password) {
    _passwordController.text = password;
  }

  Future register(GlobalKey<FormState> formKey) async {
    if (! processForm(formKey)) {
      return;
    }
    var user = await runBusyFuture(
        _auth.registerNative(
            _emailController.text, _passwordController.text));
    if (user == null) {
      setError(true);
      return;
    }
    navigateAndReplace('/');
  }
}