import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/services/interfaces/i_auth.dart';

class Auth implements IAuth {
  static const MEMBER_COLLECTION = 'members';
  static CollectionReference get memberCollection =>
      FirebaseFirestore.instance.collection(MEMBER_COLLECTION);

  @override
  Future<User> getUser() async {
    final current = FirebaseAuth.instance.currentUser;
    if (current != null) return current;
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    return userCredential.user!;
  }

  @override
  Future<Member> getMember(String userId) async {
    final memberDoc = memberCollection.doc(userId);
    final memberData = await memberDoc.get();
    try {
      if (!memberData.exists) {
        throw Exception();
      }
      return Member.fromJson(memberData.data() as Map<String, dynamic>);
    } catch (er) {
      // return default member data
      final prefs = await SharedPreferences.getInstance();
      final deviceInfoPlugin = DeviceInfoPlugin();
      String? name = prefs.getString("name");
      if (Platform.isIOS) {
        final info = await deviceInfoPlugin.iosInfo;
        name ??= info.name;
      } else if (Platform.isAndroid) {
        final info = await deviceInfoPlugin.androidInfo;
        name ??= info.host;
      } else {
        name ??= "User";
      }
      final avatar = prefs.getString("avatar");
      return Member(id: userId, name: name!, avatarUrl: avatar);
    }
  }

  @override
  Future<bool> saveMember(Member member) async {
    try {
      await memberCollection.doc(member.id).set(member.toJson());
      return true;
    } catch (er) {
      return false;
    }
  }
}
