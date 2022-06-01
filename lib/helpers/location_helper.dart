import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey =
    'pk.eyJ1Ijoic2hvbmVzazIwMDAiLCJhIjoiY2wzdHF0OHR1MGZjZzNrcnh6b2VyNHJtNyJ9.50Eh3tc1bobFa4hDRVDIrQ';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l-a+F00($longitude,$latitude)/$longitude,$latitude,16,0,0/600x300?access_token=$apiKey'; //look here
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$apiKey');
    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
