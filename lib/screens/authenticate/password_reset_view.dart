import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/authenticate/password_reset_view_model.dart';
import 'authentication_layout.dart';
import 'package:orbital_app/shared/constants.dart';

class PasswordResetView extends StatefulWidget {
  const PasswordResetView({Key key}) : super(key: key);

  @override
  _PasswordResetViewState createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<PasswordResetViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: AuthenticationLayout(
          title: 'Whoops!',
          subtitle: 'Enter your email and we\'ll send you instructions to reset your password.',
          mainButtonTitle: 'Send',
          errorMessage: model.error ? model.errorMessage : null,
          busy: model.isBusy(),
          form: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Email"),
                    validator: (val) => val.isEmpty ? "Enter a valid email address" : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                ),
              ],
            ),
          ),
          onMainButtonTapped: () => model.passwordReset(email),
          // onBackPressed: () => Navigator.pop(context),
          onSignInTapped: () => model.navigateToSignIn(),
        ),
      ),
    );
  }
}