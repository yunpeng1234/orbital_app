import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth_service.dart';


class AppDrawer extends StatelessWidget {

    final AuthService _auth = AuthService(); 
    /* Function that creates a tile in a drawer
    */
    Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}) {
      return ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(text),
            )
          ],
        ),
        onTap: onTap,
      );
    }
  Widget _createHeader() {
      return DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         fit: BoxFit.fill,
          //         image:  AssetImage('path/to/header_background.png'))),
          child: Stack(children: <Widget>[
            Positioned(
                bottom: 12.0,
                left: 16.0,
                child: Text("DaPal!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500))),
          ]));
    }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Home',
            onTap: () => Navigator.pushReplacementNamed(context, '/')),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Profile Page',
            onTap: () => Navigator.pushReplacementNamed(context, 'profilePage')),
          _createDrawerItem(
          icon: Icons.logout,
          text: 'Logout',
          onTap: () async{
            await _auth.signOut();
            Navigator.pushReplacementNamed(context, 'signIn');
            }),
          ]
      ),
    );
  }
}