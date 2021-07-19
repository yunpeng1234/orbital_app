import 'package:flutter/cupertino.dart';
import '../base_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orbital_app/services/storage.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/services/service_locator.dart';

class ProfilePageViewModel extends BaseViewModel {
  final TextEditingController _controller = TextEditingController();
  final DatabaseService _service  = serviceLocator<DatabaseService>();

  Stream<IndividualData> getUserData() {
    return _service.userData;
  }

  Future updateUserData(GlobalKey<FormState> formKey) async {
    if (! processForm(formKey)) {
      return;
    }
    try {
      _service.updateUserData(_controller.text);
      return;
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  Future<void> uploadPicture(bool check) async {
    PickedFile image = await ImagePicker().getImage(
        source: ImageSource.gallery);
    print(image.path);
    String dlUrl;
    if(check){
      dlUrl = await StorageService().uploadFile(image);
      print(dlUrl);
    } else {
      dlUrl = await StorageService().uploadFile(image);
      print(dlUrl);
    }
    await _service.updateUserPic(dlUrl);
  }

  void setName(String name) {
    _controller.text = name;
    print(_service.getUID());
  }

}