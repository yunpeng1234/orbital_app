import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  IconText({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          TextSpan(
            text: ": " + text,
            style: TextStyle(color: Colors.black, fontSize: 20.0)
          ),
        ] ,
      
      ),
    );
  }

}