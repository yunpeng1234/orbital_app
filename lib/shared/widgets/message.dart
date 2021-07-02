import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  String message;
  String sender;
  bool thisUser;

  Message({this.message, this.sender, this.thisUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      child: Align(
        alignment: (thisUser ?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (this.thisUser ? Colors.grey.shade200:Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(message, style: TextStyle(fontSize: 15),),
        ),
      ),
    );
  }
}