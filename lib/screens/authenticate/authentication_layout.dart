import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationLayout extends StatelessWidget {

  final String iconPath = 'assets/images/dapal_icon.svg';
  final String title; // Text to show at the top
  final String subtitle; // Text to show below title
  final String mainButtonTitle; // Text to show on the main button
  final Widget form; // Form to show
  final Function onMainButtonTapped;
  final Function onCreateAccountTapped;
  final Function onForgotPasswordTapped;
  // final Function onBackPressed;
  final Function onSignInTapped;
  final String errorMessage;
  final bool busy;

  const AuthenticationLayout({
    @required this.title,
    @required this.subtitle,
    @required this.form,
    @required this.onMainButtonTapped,
    this.onCreateAccountTapped,
    this.onForgotPasswordTapped,
    // this.onBackPressed,
    this.onSignInTapped,
    this.errorMessage,
    this.mainButtonTitle,
    this.busy = false,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          verticalSpaceRegular,
          Container(
            height: 200,
            width: 200,
            child: SvgPicture.asset(iconPath)
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
          // if (onForgotPasswordTapped == null) verticalSpaceRegular,
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
              child: busy
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
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

