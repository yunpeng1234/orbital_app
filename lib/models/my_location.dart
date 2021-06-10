class MyLocation {
  String placeId;
  double lat;
  double long;
  String name;
  String address;
  String photoUrl;

  MyLocation({
    this.placeId,
    this.lat,
    this.long,
    this.name,
    this.address,
    this.photoUrl,
  });

  // MyLocation.fromJson(Map<String, dynamic> json) {
  //   placeId = json['id'];
  //   lat = json['lat'];
  //   long = json['long'];
  //   placeName = json['placeName'];
  // }

  @override
  String toString() {
    return "$placeId, $lat, $long, $name, $address, $photoUrl";
  }
}