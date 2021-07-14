import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/authenticate/register_view_model.dart';
import 'authentication_layout.dart';


class RegisterView extends StatelessWidget {

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: AuthenticationLayout(
          title: 'Welcome!',
          subtitle: 'Enter your email and password to register!',
          mainButtonTitle: 'Register',
          errorMessage: model.error ? model.errorMessage: null,
          busy: model.isBusy(),
          form: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Email"),
                    validator: (val) => val.isEmpty ? "Please enter your email" : null,
                    onSaved: (val) => model.setEmail(val)
                ),
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Password"),
                    validator: (val) => val.length < 6 ? "Please enter a password of at least 6 characters" : null,
                    obscureText: true,
                    onSaved: (val) => model.setPassword(val)
                ),
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Username"),
                    validator: (val) => val.isEmpty ? "Please enter a username" : null,
                    onSaved: (val) => model.setUsername(val)
                ),
              ],
            ),
          ),
          onMainButtonTapped: () => model.registerWithVerification(_formkey, context),
          onSignInTapped: () => model.navigateAndReplace('/'),
        ),
      ),
    );
  }
}