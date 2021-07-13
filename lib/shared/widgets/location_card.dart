import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: location.photoUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 38,
                child: Center(
                  child: Text(
                    // location.name,
                    location.filteredName(),
                    style: customisedBodyText,
                    textAlign: TextAlign.center,
                  ),
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