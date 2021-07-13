import 'package:flutter/material.dart';
import 'package:orbital_app/models/contact.dart';
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

  String formattedTime() {
    DateTime toFormat = info.time;
    var now = DateTime.now();
    DateTime lastMidnight = DateTime(now.year, now.month, now.day);

    if (toFormat.isAfter(lastMidnight)) {
      return DateFormat.jm().format(info.time);
    }
    return DateFormat.MMMd().format(info.time);
  }

  @override
  Widget build(BuildContext context) {
    print(info.sender);
    return BaseView<ContactTileViewModel>(
      onModelReady: (model) => model.init(info.sender),
      builder: (context, model, child) => StreamBuilder(
        stream: model.details,
        builder: (BuildContext context, AsyncSnapshot<IndividualData> snapshot) {
          String formatted = formattedTime();
          if (!snapshot.hasData) { return Loading();}
          return GestureDetector(
              onTap: () {
                print(snapshot.data.uid);
            Navigator.pushNamed(context, 'chat', arguments: snapshot.data);
          },
          child : Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black, width: 1.0))
            ),
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