import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuth {
  /// gets user for this device using anonymous sign in
  Future<User> getUser();
}
