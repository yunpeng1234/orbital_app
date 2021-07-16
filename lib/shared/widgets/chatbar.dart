import 'package:flutter/material.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/widgets/chatavatar.dart';

class ChatBar extends StatelessWidget implements PreferredSizeWidget{
  final IndividualData info;

  ChatBar({this.info}) ;

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, 'contacts');
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.black,),
                      ),
                      SizedBox(width: 2,),
                      ChatAvatar(avatarUrl: info.picUrl, size:20.0),
                      SizedBox(width: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(info.name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
  }
}