import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import '../base_view_model.dart';

class PasswordResetViewModel extends BaseViewModel {
  static final String _errorMessage = 'Invalid email.';
  final TextEditingController _emailController = new TextEditingController();
  final AuthService _auth = serviceLocator<AuthService>();

  String get errorMessage => _errorMessage;

  void setEmail(String email) {
    _emailController.text = email;
  }

  Future passwordReset(GlobalKey<FormState> formKey) async {
    if (processForm(formKey)) {
      try {
        await runBusyFuture(_auth.sendPasswordReset(_emailController.text));
        pop();
      } catch (e) {
        print(e.toString());
        return;
      }
    }
  }
}