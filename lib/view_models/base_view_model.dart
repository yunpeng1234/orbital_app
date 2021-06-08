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

  Future navigate(String routeName, {Object arguments}) async {
    setError(false);
    navState.pushNamed(routeName, arguments: arguments);
  }

  Future navigateAndReplace(String routeName, {Object arguments}) async {
    setError(false);
    navState.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future pop() async {
    setError(false);
    navState.pop();
  }

  Future runBusyFuture(Future busyFunc) async {
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