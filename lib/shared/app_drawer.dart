import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/drawer/app_drawer_view_model.dart';


class AppDrawer extends StatefulWidget {

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

    Widget _createDrawerItem({IconData icon, String text, Function onTap}) {
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
    return BaseView<AppDrawerViewModel>(
      builder: (context, model, child) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => model.navigateAndReplace('/')
            ),
            _createDrawerItem(
            icon:
            Icons.person,
              text: 'Profile Page',
              onTap: () => model.navigate('profilePage')
            ),
            _createDrawerItem(
              icon: Icons.chat,
              text: 'Chat',
              onTap: () => model.navigate('contacts'),
            ),
            _createDrawerItem(
              icon: Icons.history,
              text: 'Order History',
              onTap: () => model.navigate('orderHistory'),
            ),
            _createDrawerItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () async {model.signOut();}
            ),
          ]
        ),
      ),
    );
  }
}