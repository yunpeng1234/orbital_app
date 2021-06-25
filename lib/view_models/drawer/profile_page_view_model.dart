import 'package:orbital_app/services/auth_service.dart';

import '../base_view_model.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orbital_app/routes/nav_key.dart';

class ProfilePageViewModel extends BaseViewModel {
  final DatabaseService _database = serviceLocator<DatabaseService>();
  final AuthService _auth = serviceLocator<AuthService>();

}