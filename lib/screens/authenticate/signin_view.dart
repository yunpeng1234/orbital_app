import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/authenticate/signin_view_model.dart';
import 'authentication_layout.dart';
import 'package:orbital_app/screens/base_view.dart';

class SignInView extends StatelessWidget {

  SignInView({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BaseView<SignInViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: AuthenticationLayout(
          title: 'Welcome!',
          subtitle: '',
          mainButtonTitle: 'Sign In',
          errorMessage: model.error ? model.errorMessage : null,
          busy: model.isBusy(),
          form: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Email"),
                    validator: (val) => val.isEmpty ? "Enter your email" : null,
                    onSaved: (val) => model.setEmail(val)
                ),
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Password"),
                    obscureText: true,
                    validator: (val) => val.isEmpty ? "Enter a password" : null,
                    onSaved: (val) => model.setPassword(val)
                ),
              ],
            ),
          ),
          onMainButtonTapped: () async {
            // if (_formKey.currentState.validate()) {
            //   _formKey.currentState.save();
              model.signIn(_formKey);
            //}
          },
          onForgotPasswordTapped: () async {
            model.navigate('forgotPassword');
          },
          onCreateAccountTapped: () async {
            model.navigateAndReplace('createAccount');
          },
        ),
      ),
    );
  }
}