import 'package:permission_handler/permission_handler.dart';

class Permissions {
  const Permissions._();

  static Future<bool> camera({bool request = true}) => request
      ? Permission.camera.request().isGranted
      : Permission.calendar.isGranted;
}
