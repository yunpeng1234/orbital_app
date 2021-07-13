import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String message;
  final String sender;
  final bool thisUser;

  MessageBox({this.message, this.sender, this.thisUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      child: Align(
        alignment: (thisUser? Alignment.topLeft: Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: this.thisUser ? Colors.grey[400] : Colors.grey[700],
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: this.thisUser ? Offset(-2, 2.5) : Offset(2, 2.5), // shadow direction: bottom right
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: (this.thisUser ? Colors.grey.shade100 : Color(0xff8681eb)),
          ),
          padding: EdgeInsets.all(16),
          child: Text(message, style: TextStyle(fontSize: 15),),
        ),
      ),
    );
  }
}