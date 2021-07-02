import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/services/database.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/view_models/base_view_model.dart';



class ContactTileViewModel extends BaseViewModel {
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();
  Contact info;
  Future<IndividualData> details;

  Future init(String senderUID) async{
    details = _databaseService.getSenderData(senderUID);
  }
   
}