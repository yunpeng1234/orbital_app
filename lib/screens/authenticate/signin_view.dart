import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/authenticate/signin_view_model.dart';
import 'package:provider/provider.dart';
import 'authentication_layout.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/screens/home/home_view.dart';
import 'package:orbital_app/models/user.dart';

class SignInView extends StatefulWidget {

  SignInView({Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

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
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    }
                ),
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Password"),
                    obscureText: true,
                    validator: (val) => val.isEmpty ? "Enter a password" : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    }
                ),
              ],
            ),
          ),
          onMainButtonTapped: () async {
            if (_formKey.currentState.validate()) {
              model.signIn(email, password);
            }
          },
          onForgotPasswordTapped: () async {
            model.navigateToForgotPassword();
          },
          onCreateAccountTapped: () async {
            model.navigateToCreateAccount();
          },
        ),
      ),
    );
  }
}