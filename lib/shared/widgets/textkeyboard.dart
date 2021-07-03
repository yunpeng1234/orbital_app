import 'package:flutter/material.dart';
import 'package:orbital_app/shared/widgets/send.dart';

class ChatKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;


  ChatKeyboard({this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.white,
    height: 100,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message ...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        SendButton(
          onTap: onTap
        )
      ],
    ),
  );
  }
}