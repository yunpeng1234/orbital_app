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

  Future runBusyFuture(Future busyFunc) async {
    setState(ViewState.busy);
    var value = await busyFunc;
    setState(ViewState.idle);
    return value;
  }

  void setState(ViewState viewState) {
    state = viewState;
    notifyListeners();
  }

}