import 'package:orbital_app/screens/authenticate/verify_email_view.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import '../base_view_model.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel {
  static final String _errorMessage = "Invalid email.";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthService _auth = serviceLocator<AuthService>();

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

  Future registerTest(GlobalKey<FormState> formKey, BuildContext context) async {
    if (! processForm(formKey)) {
      return;
    }
    var user = await runBusyFuture(
        _auth.registerTest(
            _emailController.text,
            _passwordController.text,
            _usernameController.text,
        ));
    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyScreen(name: _usernameController.text)));
  }
}