import 'package:location/location.dart';

class LocationService {
  static Future<Map<String, dynamic>?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    final locationData = await location.getLocation();

    return {
      'latitude': locationData.latitude!,
      'longitude': locationData.longitude!,
    };
  }
}
