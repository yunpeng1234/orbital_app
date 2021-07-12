import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  final String avatarUrl;
  final double size;

  const ChatAvatar({this.avatarUrl, this.size});

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == '') {
      return CircleAvatar(
        radius: size,
        child: Icon(Icons.person)
      );
    }
    return  CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(avatarUrl),
    );
  }
}