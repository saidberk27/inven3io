import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authentication {
  late String emailAddress;
  late String password;

  Authentication({required this.emailAddress, required this.password});

  Future<dynamic> signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Kullanıcı Bulunamadı';
      } else if (e.code == 'wrong-password') {
        return 'Yanlış Şifre';
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return e.toString();
    }
  }
}
