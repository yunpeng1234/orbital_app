import 'package:flutter/material.dart';
import 'package:orbital_app/routes/nav_key.dart';
import 'package:orbital_app/services/service_locator.dart';

enum ViewState{idle, busy}

abstract class BaseViewModel extends ChangeNotifier {
  NavigatorState navState = NavKey.navKey.currentState;
  ViewState state = ViewState.idle;

  bool isBusy() {
    return state == ViewState.busy;
  }

  void setState(ViewState viewState) {
    state = viewState;
    notifyListeners();
  }

}