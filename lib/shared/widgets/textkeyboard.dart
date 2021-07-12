import 'package:flutter/material.dart';
import 'package:orbital_app/shared/widgets/send.dart';

class ChatKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;


  ChatKeyboard({this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    color: Colors.white,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
               child: TextField(
                 controller: controller,
                 keyboardType: TextInputType.multiline,
                 minLines: 1,
                 maxLines: 5,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: 'Type your message ...',
                   hintStyle: TextStyle(color: Colors.grey[500]),
                 ),
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