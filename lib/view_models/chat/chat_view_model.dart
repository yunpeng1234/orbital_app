import 'package:orbital_app/models/message.dart';
import 'package:orbital_app/screens/chat/chat_view.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/database.dart';

import '../base_view_model.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/services/message_service.dart';
import 'package:orbital_app/services/service_locator.dart';

class ChatViewModel extends BaseViewModel {

  final MessageService _messageService = serviceLocator<MessageService>();
  final AuthService _auth = serviceLocator<AuthService>();

  Stream<List<Message>> chat;

  Future init(String uid) async {
    chat = _messageService.message(uid);
  }

  Future sendMessage(String uid, String message) async {
    await _messageService.sendMessage(uid, message);
  }
}