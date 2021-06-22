import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/my_location.dart';

class LocationCard extends StatelessWidget {
  final MyLocation location;
  final Function onCardTapped;

  const LocationCard({
    this.location,
    this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 140,
      child: GestureDetector(
        onTap: onCardTapped,
        child: Card(
          margin: EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
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
                    location.photoUrl,
                        // : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.mcdonalds.com.sg%2F&psig=AOvVaw1IKce6KrFXgY0v8RHaUjoG&ust=1623433478667000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPCC45DPjfECFQAAAAAdAAAAABAD'
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
                        location.name,
                        style: blackBodyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget getImage() {
  //   try {
  //     return Image(
  //       fit: BoxFit.fill,
  //       image: NetworkImage(
  //         location.photoUrl,
  //       )
  //     )
  //   } catch (e) {
  //     return CircularProgressIndicator(
  //       valueColor: AlwaysStoppedAnimation(Colors.white),
  //     );
  //   }
  // }
}