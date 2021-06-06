import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';

class HomeScreenCard extends StatelessWidget {
  final String title;
  final String url;

  const HomeScreenCard({
    this.title,
    this.url,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 140,
      child: Card(
        margin: EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 140,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(
                  url,
                ),
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: blackBodyText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}