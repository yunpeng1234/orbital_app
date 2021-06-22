import 'package:flutter/material.dart';
import 'package:orbital_app/routes/nav_key.dart';

enum ViewState{idle, busy}

abstract class BaseViewModel extends ChangeNotifier {
  NavigatorState navState = NavKey.navKey.currentState;
  ViewState state = ViewState.idle;
  bool error = false;

  bool isBusy() {
    return state == ViewState.busy;
  }

  void navigate(String routeName, {Object arguments}) {
    setError(false);
    navState.pushNamed(routeName, arguments: arguments);
  }

  void navigateAndReplace(String routeName, {Object arguments}) {
    setError(false);
    navState.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() {
    setError(false);
    navState.pop();
  }

  Future<T> runBusyFuture<T>(Future<T> busyFunc) async {
    setState(ViewState.busy);
    try {
      var value = await busyFunc;
      setErrorAndState(ViewState.idle, false);
      return value;
    } catch (e) {
      print(e.toString());
      setErrorAndState(ViewState.idle, true);
      rethrow;
    }
  }

  bool processForm(GlobalKey<FormState> formKey) {
    if (! formKey.currentState.validate()) {
      return false;
    }
    formKey.currentState.save();
    return true;
  }

  void setError(bool errorState) {
    error = errorState;
    notifyListeners();
  }

  void setState(ViewState viewState) {
    state = viewState;
    notifyListeners();
  }

  void setErrorAndState(ViewState viewState, bool errorState) {
    error = errorState;
    state = viewState;
    notifyListeners();
  }
}