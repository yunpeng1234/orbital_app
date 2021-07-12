import 'package:flutter/material.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/widgets/contact_tile.dart';
import 'package:orbital_app/view_models/chat/contact_page_view_model.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';


class ContactPageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactPageViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => StreamBuilder(
        stream: model.contacts,
        builder:(BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) {
            return Center(
              child: Loading(),
            );
          }
          return Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(title: Text('Contacts', style: titleText,)),
            backgroundColor: primaryColor,
            resizeToAvoidBottomInset: false,
            body: ListView(
              children: _buildList(model, snapshot),
            )
          );
        }
      )
    );
  }

  List<Widget> _buildList(ContactPageViewModel model, AsyncSnapshot<List<Contact>> snapshot) {
    return snapshot.data
      .map((contact) => ContactTile(
      info: contact
      ))
    .toList();
  }
}