import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 18.2030;
  double longitude = 69.4200;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      LocationPermission permission2 = await Geolocator.checkPermission();
      print(permission2);
      print('Getting Location');
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position);
    } catch (e) {
      print(e);
    }
  }
}

// void getLocation() async {
//   LocationPermission permission = await Geolocator.requestPermission();
//   LocationPermission permission2 = await Geolocator.checkPermission();
//   print(permission2);
//   print('Getting Location');
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   print(position);
//   print('Getting Location');
// }
//
// void getLocation2() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   print(position);
// }
