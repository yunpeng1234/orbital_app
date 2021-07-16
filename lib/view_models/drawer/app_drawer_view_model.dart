import '../base_view_model.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:flutter/material.dart';

class AppDrawerViewModel extends BaseViewModel {
  final AuthService _auth = serviceLocator<AuthService>();
  bool isNewRouteSameAsCurrent = false;

  Future signOut() async {
    await _auth.signOut();
    //navigateAndReplace('signIn');
     navKey.currentState.popUntil(ModalRoute.withName("/"));
  }

  Future navigateToOrderTesting() async {
    navKey.currentState.pushReplacementNamed('orderTest');
  }
}