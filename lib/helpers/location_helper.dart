import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "AIzaSyC30y91RPyh87m02vt2BNO8HimfElraOKo";

class LocationHelper {
  static String locationPreviewImage(latitude, longitude) {
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
    return 'https://www.google.com/maps/d/u/0/thumbnail?mid=19GmmDsf0ZrM4innqgkxCZcoNuog';
  }

  static Future<String> getPlaceAddress(lat, lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&amp;key=$GOOGLE_API_KEY";
    final response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
