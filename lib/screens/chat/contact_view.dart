import 'package:flutter/material.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/widgets/contact_tile.dart';
import 'package:orbital_app/view_models/chat/contact_page_view_model.dart';

class ContactPageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactPageViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => StreamBuilder(
        stream: model.contacts,
        builder:(BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          print(snapshot.hasData);
          if (!snapshot.hasData) {
            return Center(
              child: Loading(),
            );
          }
          return Scaffold(
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