import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/authenticate/register_view_model.dart';
import 'authentication_layout.dart';


class RegisterView extends StatefulWidget {

  final Function toggler;

  RegisterView({this.toggler});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';

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
                    validator: (val) => val.isEmpty ? "Enter your email" : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                ),
                verticalSpaceRegular,
                TextFormField(
                    decoration: textBoxDeco.copyWith(hintText: "Password"),
                    validator: (val) => val.length < 6 ? "Please enter a password of at least 6 characters" : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                ),
              ],
            ),
          ),
          onMainButtonTapped: () async {
            if (_formkey.currentState.validate()) {
              model.register(email, password);
            }
          },
          onSignInTapped: () => model.navigateToSignIn(),
        ),
      ),
    );
  }
}
