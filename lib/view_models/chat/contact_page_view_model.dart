import 'package:orbital_app/services/database.dart';

import '../base_view_model.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/services/message_service.dart';
import 'package:orbital_app/services/service_locator.dart';

class ContactPageViewModel extends BaseViewModel {

  final MessageService _messageService = serviceLocator<MessageService>();

  Stream<List<Contact>> contacts;

  Future init() async {
    Stream<List<Contact>> contacts = _messageService.contacts;

  }
}