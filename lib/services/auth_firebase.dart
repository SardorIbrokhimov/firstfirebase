
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfirebase/pages/sign_in.dart';
import 'package:firstfirebase/services/preference.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      var authres = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = authres.user;
      print("USER MA'LUMOTLARI: ${user.toString()}");
      return user;
    } catch (e) {
      print("Errorni ko'rsat:${e.toString()}");
    }
  }

  static Future signInUser(
      BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      var user = await _auth.currentUser;
      return user;
    } catch (e) {
      print("Errorni ko'rsat:${e.toString()}");
    }
  }

  static Future<void> signout(BuildContext context) async {
    _auth.signOut();
    Preference.deleteUserId().then((value) => {
      Navigator.pushReplacementNamed(context, SignIn.id),

    },);
  }
}
