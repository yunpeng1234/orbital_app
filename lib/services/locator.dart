import 'package:get_it/get_it.dart';
import 'package:orbital_app/view_models/sign_in_view_model.dart';
import 'auth.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(() => SignInViewModel());
  serviceLocator.registerLazySingleton(() => AuthService());
}