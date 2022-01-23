import 'package:firebase_auth/firebase_auth.dart';
import 'package:tenders/domain/member/member.dart';

abstract class IAuth {
  /// gets user for this device using anonymous sign in
  Future<User> getUser();

  /// gets member info on the current user
  Future<Member> getMember(String userId);
}
