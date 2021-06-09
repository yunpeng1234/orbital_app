import 'package:flutter/material.dart';

const textBoxDeco = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0)
  ),
);

// Horizontal Spacing
const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

// Vertical Spacing
const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 18.0);
const Widget verticalSpaceMedium = SizedBox(height: 25);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceVeryLarge = SizedBox(height: 90.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

// colors
const Color primaryColor = Color(0xffFCE5CD);
const Color orangeAppBarColor = Color(0xffFFAA66);
const Color greyButtonColor = Color(0xff4E4A40);
const Color greyTextColor = Color(0xff868686);
const Color brownTextColor = Color(0xffBE6640);

// fonts
const String primaryFont = 'Raleway';

// Text Style

/// The style used for all body text in the app
const TextStyle greyBodyText = TextStyle(
  color: greyTextColor,
  fontSize: bodyTextSize,
  fontFamily: primaryFont,
);
const TextStyle titleText = TextStyle(
  color: Colors.black,
  fontSize: 34,
  fontFamily: primaryFont
);
const TextStyle brownButtonText = TextStyle(
  color: brownTextColor,
  fontSize: bodyTextSize,
  fontFamily: primaryFont
);
const TextStyle whiteButtonText = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: bodyTextSize,
);

const TextStyle blackBodyText = TextStyle(
  color: Colors.black,
  fontSize: bodyTextSize,
  fontFamily: primaryFont,
);

const TextStyle blackBodyTextLarge = TextStyle(
  color: Colors.black,
  fontSize: largeBodyTextSize,
  fontFamily: primaryFont,
);

// Font Sizing
const double bodyTextSize = 16;
const double largeBodyTextSize = 20;

// Screen Size Helpers
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// Returns the pixel amount for the percentage of the screen height. [percentage] should
/// be between 0 and 1 where 0 is 0% and 100 is 100% of the screens height
double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

/// Returns the pixel amount for the percentage of the screen width. [percentage] should
/// be between 0 and 1 where 0 is 0% and 100 is 100% of the screens width
double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;