import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/routes/nav_key.dart';
import 'base_view_model.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/loading.dart';

class AppDrawerViewModel extends BaseViewModel {
  final AuthService _auth = serviceLocator<AuthService>();
  bool isNewRouteSameAsCurrent = false;

  Future navigateToHome() async {
    navState.pushReplacementNamed('/');
  }

  Future navigateToProfilePage() async {
    navState.pushReplacementNamed('profilePage');
  }

  Future signOut() async {
    await _auth.signOut(); 
    navState.pushReplacementNamed('signIn');
  }
}