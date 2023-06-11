import 'package:location/location.dart';

class GoogleMapsFunctions {
  final Location _location = Location();

  Future<LocationData?> getLocation() async {
    PermissionStatus permissionGranted =  await _location.hasPermission();
    bool serviceEnabled;
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await _location.getLocation();
  }
}