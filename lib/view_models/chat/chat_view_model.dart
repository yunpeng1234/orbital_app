import 'package:flutter/cupertino.dart';
import 'package:orbital_app/models/message.dart';
import 'package:orbital_app/services/auth_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/message_service.dart';
import 'package:orbital_app/services/service_locator.dart';

class ChatViewModel extends BaseViewModel {

  final MessageService _messageService = serviceLocator<MessageService>();
  final AuthService _auth = serviceLocator<AuthService>();
  final TextEditingController controller = TextEditingController();

  Stream<List<Message>> chat;
  String user;

  Future init(String uid) async {
    chat = _messageService.message(uid);
    user = _auth.getUID();
  }

  Future sendMessage(String uid) async {
    String tosend = controller.text;
    await _messageService.sendMessage(uid, tosend);
    controller.clear();
  }
}