import 'base_view_model.dart';
import 'package:orbital_app/routes/nav_key.dart';

class ProfilePageViewModel extends BaseViewModel {

  Future navigateToForgotPassword() async {
    await NavKey.navKey.currentState.pushNamed('forgotPassword');
  }

  Future navigateToCreateAccount() async {
    await NavKey.navKey.currentState.pushNamed('createAccount');
  }

}