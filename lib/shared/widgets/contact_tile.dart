import 'package:flutter/material.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/chat/contact_tile_view_model.dart';
import 'package:orbital_app/shared/widgets/avatar.dart';
import 'package:orbital_app/models/user.dart';


class ContactTile extends StatelessWidget {
  Contact info;

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
          if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) { return Loading();}
            return GestureDetector(
              onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Loading();
            }));
          },
          child : Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row (
              children: <Widget>[
                Avatar(avatarUrl: snapshot.data.picUrl, onTap: () {}),
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
                Text(info.time.toString() ,style: TextStyle(fontSize: 12)),
              ],
            )
          )
        );
      }
    )
    );
  }
}