import 'package:flutter/material.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/shared/widgets/avatar.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/drawer/profile_page_view_model.dart';

class ProfilePageView extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilePageViewModel>(
      builder: (context, model, child) => StreamBuilder(
        stream: model.getUserData(),
        builder:(BuildContext context, AsyncSnapshot<IndividualData> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Loading(),
            );
          }
          String username = snapshot.data.name;
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Your Profile',
                  style: titleText,
                ),
              ),
              drawer: AppDrawer(),
              backgroundColor: primaryColor,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    verticalSpaceLarge,
                    Avatar(
                      avatarUrl: snapshot.data.picUrl,
                      onTap: () => model.uploadPicture(),
                    ),
                    verticalSpaceRegular,
                    Text(username, style: TextStyle(fontSize: 50.0)),
                    SizedBox(height: 10.0),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        decoration: textBoxDeco.copyWith(hintText: "New Username"),
                        onSaved: (val) => model.setName(val),
                        validator: (val) => val.isEmpty ? 'Please enter a new name first.' : null,
                      )
                    ),
                    verticalSpaceRegular,
                    GestureDetector(
                      onTap: () => model.updateUserData(_formKey),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: greyButtonColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: model.isBusy()
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                            : Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );

        }

        ),
    );
 }
}