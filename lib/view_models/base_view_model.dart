import 'package:flutter/material.dart';

enum ViewState{idle, busy}

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  bool isBusy() {
    return _state == ViewState.busy;
  }

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}