import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/models/message.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/widgets/chatavatar.dart';
import 'package:orbital_app/shared/widgets/chatbar.dart';
import 'package:orbital_app/shared/widgets/textkeyboard.dart';
import 'package:orbital_app/view_models/chat/chat_view_model.dart';

class Chat extends StatelessWidget {
  final IndividualData person;

  Chat({this.person});

  @override
    Widget build(BuildContext context) {
      return BaseView<ChatViewModel>(
        onModelReady: (model) => model.init(person.uid),
        builder: (context, model, child) => StreamBuilder(
          stream: model.chat,
          builder:(BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
            if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) { return Loading();}
            return Scaffold(
                  appBar: ChatBar(info: person),
                  body: Container(),
                  bottomNavigationBar: ChatKeyboard(controller: model.controller, onTap: () {model.sendMessage(person.uid);}),
                );
          }
        )
      );
    }
}