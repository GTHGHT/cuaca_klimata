import 'package:geolocator/geolocator.dart';

class Location {
  static Future<Position> getLocation() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permission denied");
      }
    }

    if (checkPermission == LocationPermission.deniedForever) {
      return Future.error("Permission denied forever");
    }

    return await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.low));
  }
}
