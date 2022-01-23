import 'package:location/location.dart' as l;
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  const Permissions._();

  static Future<bool> camera({bool request = true}) => request
      ? Permission.camera.request().isGranted
      : Permission.calendar.isGranted;

  static Future<bool> location({bool request = true}) async {
    final location = new l.Location();

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == l.PermissionStatus.denied) {
      if (!request) {
        return false;
      }
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != l.PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
