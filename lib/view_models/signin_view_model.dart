import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'base_view_model.dart';
import 'package:orbital_app/routes/nav_key.dart';

class SignInViewModel extends BaseViewModel {
  static final String _errorMessage = 'Invalid email/password.';
  final AuthService _auth = serviceLocator<AuthService>();
  bool _error = false;

  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future navigateToForgotPassword() async {
    await navState.pushNamed('forgotPassword');
  }

  Future navigateToCreateAccount() async {
    await navState.pushNamed('createAccount');
  }

  Future signIn(String email, String password) async {
    setState(ViewState.busy);
    var user = await _auth.signInNative(email, password);
    _error = false;
    setState(ViewState.idle);
    if (user == null) {
      _error = true;
      return;
    }
    navState.pushReplacementNamed('/');
  }

}