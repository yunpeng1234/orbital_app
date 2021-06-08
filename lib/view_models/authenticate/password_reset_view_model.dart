import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import '../base_view_model.dart';
import 'package:orbital_app/routes/nav_key.dart';

class PasswordResetViewModel extends BaseViewModel {
  static final String _errorMessage = 'Invalid email.';
  final AuthService _auth = serviceLocator<AuthService>();
  bool _error = false;

  String get errorMessage => _errorMessage;
  bool get error => _error;

  void navigateToSignIn() {
    _error = false;
    navState.pop();
  }

  Future passwordReset(email) async {
    setState(ViewState.busy);
    try {
      await _auth.sendPasswordReset(email);
      navState.pushNamed('signIn');
      _error = false;
    } catch (e) {
      _error = true;
    }
    setState(ViewState.idle);
  }

}