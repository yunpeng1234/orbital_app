// The fields correspond to the dummy data for now, at https://jsonplaceholder.typicode.com/photos

class DummyLocation {
  int albumId;
  int id;
  String title;
  String url;
  String thumnailUrl;

  DummyLocation({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumnailUrl,
  });

  DummyLocation.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumnailUrl = json['thumbnailUrl'];
  }
}