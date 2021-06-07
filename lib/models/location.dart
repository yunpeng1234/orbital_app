// The fields correspond to the dummy data for now, at https://jsonplaceholder.typicode.com/photos

class Location {
  int albumId;
  int id;
  String title;
  String url;
  String thumnailUrl;

  Location({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumnailUrl,
  });

  Location.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumnailUrl = json['thumbnailUrl'];
  }
}