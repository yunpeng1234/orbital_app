import 'package:http/http.dart';
import 'dart:async';
import 'package:orbital_app/models/location.dart';
import 'dart:convert';
import 'dart:math';

class DummyDatabase {
  static const endpoint = 'https://jsonplaceholder.typicode.com';
  var client = new Client();

  Future<List<dynamic>> getSomeLocations() async {
    var locations = <Location>[];

    // Get locations
    var response = await client.get(Uri.parse('$endpoint/photos'));

    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      locations.add(Location.fromJson(comment));
    }

    var rng = new Random();
    int start = rng.nextInt(4000); // Max number of documents in the database
    return locations.sublist(start, start + 4);
  }
}