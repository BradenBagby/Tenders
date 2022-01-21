import 'package:firebase_auth/firebase_auth.dart';
import 'package:tenders/services/interfaces/i_auth.dart';

class Auth implements IAuth {
  @override
  Future<User> getUser() async {
    final current = FirebaseAuth.instance.currentUser;
    if (current != null) return current;
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    return userCredential.user!;
  }
}
