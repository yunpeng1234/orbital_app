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
  String filteredName() {
    String filtered;
    if(this.name.length > 30) {
      String temp = this.name.substring(0, 17);
      int res = temp.lastIndexOf(' ');
      filtered = temp.substring(0,res);
    } else {
      filtered = this.name;
    }
    return filtered;
  }

  @override
  String toString() {
    return "$placeId, $lat, $long, $name, $address, $photoUrl";
  }
}