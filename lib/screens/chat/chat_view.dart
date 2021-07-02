import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/models/contact.dart';
import 'package:orbital_app/models/message.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/widgets/chatavatar.dart';
import 'package:orbital_app/view_models/chat/chat_view_model.dart';

class Chat extends StatelessWidget {
  IndividualData person;

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
                  appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,color: Colors.black,),
                            ),
                            SizedBox(width: 2,),
                            ChatAvatar(avatarUrl: person.picUrl, size:20.0),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(person.name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ),
                            Icon(Icons.settings,color: Colors.black54,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: Container()
                );
          }
        )
      );
    }
}