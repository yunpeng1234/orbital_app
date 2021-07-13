import 'package:flutter/material.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LocationSearchResult extends StatelessWidget {
  final MyLocation location;
  final Function onCardTapped;

  const LocationSearchResult({
    this.location,
    this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: location.photoUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                        value: downloadProgress.progress,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onTap: onCardTapped,
              child: Container(
                height: 100,
                child: Card(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      location.name,
                      textAlign: TextAlign.center,
                      style: blackBodyText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}