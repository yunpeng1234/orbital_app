import 'package:flutter/material.dart';
import 'package:orbital_app/routes/nav_key.dart';
import 'package:orbital_app/services/service_locator.dart';

enum ViewState{idle, busy}

abstract class BaseViewModel extends ChangeNotifier {
  NavigatorState navState = NavKey.navKey.currentState;
  ViewState _state = ViewState.idle;

  bool isBusy() {
    return _state == ViewState.busy;
  }

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

}