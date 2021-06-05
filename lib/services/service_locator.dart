import 'package:get_it/get_it.dart';
import 'package:orbital_app/view_models/signin_view_model.dart';
import 'package:orbital_app/view_models/password_reset_view_model.dart';
import 'package:orbital_app/view_models/register_view_model.dart';
import 'auth_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(() => SignInViewModel());
  serviceLocator.registerLazySingleton(() => RegisterViewModel());
  serviceLocator.registerLazySingleton(() => PasswordResetViewModel());
  serviceLocator.registerLazySingleton(() => AuthService());
}