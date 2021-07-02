import 'package:flutter/material.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/screens/chat/chat_view.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/chat/contact_tile_view_model.dart';
import 'package:orbital_app/shared/widgets/chatavatar.dart';
import 'package:orbital_app/models/user.dart';
import 'package:intl/intl.dart';

class ContactTile extends StatelessWidget {
  final Contact info;

  ContactTile({
    this.info
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactTileViewModel>(
      onModelReady: (model) => model.init(info.sender),
      builder: (context, model, child) => FutureBuilder(
        future: model.details,
        builder: (BuildContext context, AsyncSnapshot<IndividualData> snapshot) {
          String formatted = DateFormat.jm().format(info.time);
          if (!snapshot.hasData) { return Loading();}
          return GestureDetector(
              onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Chat(person: snapshot.data);
            }));
          },
          child : Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row (
              children: <Widget>[
                ChatAvatar(avatarUrl: snapshot.data.picUrl,size: 30.0),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data.name, style: TextStyle(fontSize: 16),),
                              SizedBox(height: 6,),
                              Text(info.message ,style: TextStyle(fontSize: 13,color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                ),
                Text(formatted ,style: TextStyle(fontSize: 12)),
              ],
            )
          )
        );
        }
    )
    );
  }
}