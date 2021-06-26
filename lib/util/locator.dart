import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/region.dart';
import 'package:http/http.dart' as http;

class Locator {
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<Region> getRegionFromPosition(Position pos, bool create) async {
    List<Region> regions = await DBManager.getAvailableRegions();
    http.Response response = await makeRequest(pos);
    if (response.statusCode == 200) {
      return Region.fromJson(jsonDecode(response.body), regions, create);
    } else {
      return Future.error('Failed to get region from position');
    }
  }

  static Future<http.Response> makeRequest(Position pos) {
    const apiKey = 'd6b6706e7daf4cd79626437e2ece3fec';
    var kwargs = {
      'key': apiKey,
      'q': pos.latitude.toString() + ',' + pos.longitude.toString(),
      'pretty': '1',
      'no_annotations': '1',
    };
    return http.get(Uri.https('api.opencagedata.com', 'geocode/v1/json', kwargs));
  }

  static Future<Region> getWhereabouts({bool create = false}) async {
    try {
      var pos = await Locator.getCurrentPosition();
      print('position: ' + pos.toString());
      Region region = await Locator.getRegionFromPosition(pos, create);
      print('region: ' + region.toString());
      return region;
    } catch (ex) {
      print(ex);
      return Region.unknown;
    }
  }
}
