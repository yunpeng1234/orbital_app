import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import '../base_view_model.dart';
import 'package:orbital_app/routes/nav_key.dart';

class RegisterViewModel extends BaseViewModel {
  static final String _errorMessage = "Invalid email.";
  final AuthService _auth = serviceLocator<AuthService>();
  bool _error = false;

  bool get error => _error;
  String get errorMessage => _errorMessage;

  void navigateToSignIn()  {
    _error = false;
    navState.pop();
  }

  Future register(String email, String password) async {
    setState(ViewState.busy);
    var user = await _auth.registerNative(email, password);
    _error = false;
    setState(ViewState.idle);
    if (user == null) {
      _error = true;
      return;
    }
  }

}