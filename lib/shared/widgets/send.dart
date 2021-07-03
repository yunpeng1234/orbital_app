import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final Function onTap;

  const SendButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
    );
  }
}