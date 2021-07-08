import 'package:flutter/material.dart';
import 'package:orbital_app/routes/nav_key.dart';

enum ViewState{idle, busy}

abstract class BaseViewModel extends ChangeNotifier {
  final GlobalKey<NavigatorState> navKey = NavKey.navKey;
  ViewState state = ViewState.idle;
  bool error = false;

  bool isBusy() {
    return state == ViewState.busy;
  }

  void navigate(String routeName, {Object arguments}) {
    setError(false);
    navKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void navigateAndReplace(String routeName, {Object arguments}) {
    setError(false);
    navKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() {
    setError(false);
    navKey.currentState.pop();
  }

  Future<T> runBusyFuture<T>(Future<T> busyFunc) async {
    setState(ViewState.busy);
    try {
      T value = await busyFunc;
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