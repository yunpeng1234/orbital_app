import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';

class AuthenticationScreen extends StatelessWidget {

  final String title; // Text to show at the top
  final String subtitle; // Text to show below title
  final String mainButtonTitle; // Text to show on the main button
  final Widget form; // Form to show
  final Function onMainButtonTapped;
  final Function onCreateAccountTapped;
  final Function onForgotPasswordTapped;
  final Function onBackPressed;
  final Function onSignInTapped;
  final String errorMessage;

  const AuthenticationScreen({
    @required this.title,
    @required this.subtitle,
    @required this.form,
    @required this.onMainButtonTapped,
    this.onCreateAccountTapped,
    this.onForgotPasswordTapped,
    this.onBackPressed,
    this.onSignInTapped,
    this.errorMessage,
    this.mainButtonTitle,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: <Widget>[
          // verticalSpaceLarge,
          if (onBackPressed == null) verticalSpaceLarge,
          if (onBackPressed != null) verticalSpaceRegular,
          if (onBackPressed != null)
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: onBackPressed,
            ),
          Center(
            child: Text(
            title,
            style: titleText
            ),
          ),
          verticalSpaceSmall,
          Center(
            // width: screenWidthPercentage(context, percentage: 0.7),
            child: Text(
              subtitle,
              style: greyBodyText,
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpaceRegular,
          form,
          verticalSpaceRegular,
          if (onForgotPasswordTapped != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onForgotPasswordTapped,
                child:Text(
                  'Forgot Password?',
                  style: brownButtonText.copyWith(
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          verticalSpaceRegular,
          if (errorMessage != null)
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          if (errorMessage != null) verticalSpaceRegular,
          GestureDetector(
            onTap: onMainButtonTapped,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: greyButtonColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                mainButtonTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          verticalSpaceRegular,
          if (onCreateAccountTapped != null) GestureDetector(
            onTap: onCreateAccountTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                horizontalSpaceTiny,
                Text(
                  'Create one!',
                  style: TextStyle(color: brownTextColor),
                )
              ],
            ),
          ),
          if (onSignInTapped != null) GestureDetector(
            onTap: onSignInTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have an account?'),
                horizontalSpaceTiny,
                Text(
                  'Sign In!',
                  style: TextStyle(color: brownTextColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

