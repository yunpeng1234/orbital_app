import 'package:flutter/material.dart';

class PopUpText extends StatelessWidget {
  final String message;
  final String text;
  final Future onTapYes;
  final Future onTapNo;


  PopUpText({
    this.onTapYes,
    this.text,
    this.message,
    this.onTapNo,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await onTapYes;
            Navigator.pop(context);
          },
          child: Text(text)
        ),
        TextButton(
          onPressed: () async {
            await onTapNo;
            Navigator.pop(context);
          },
          child: Text('Cancel')
        ),
      ],
    );
  }
}