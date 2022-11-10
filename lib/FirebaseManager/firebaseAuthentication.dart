import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/main.dart';

class FirebaseAuthentication {
  FirebaseAuth? _firebaseAuth;

  FirebaseAuthentication() {
    _firebaseAuth = FirebaseAuth.instance;
  }
  currentUs() {
    return _firebaseAuth!.currentUser!.uid.toString();
  }

  Future<String> signUp(String email, String password) async {
    try {
      final signUpResponse =
          await _firebaseAuth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "...";
    } catch (e) {
      return "The email address is already in use by another account";
    }
  }

  Future<void> checkTheUser() async {
    try {
      await _firebaseAuth!.currentUser!.reload();
    } catch (e) {}
    if (_firebaseAuth!.currentUser == null) {
      signUpAnonymous();
    } else {} //
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final signInResponse = await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);

      String token = await signInResponse.user!.getIdToken();

      sharedPreferences!.setString("token", token);
      tokenId = token;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future signUpAnonymous() async {
    try {
      final signUpAnon = await _firebaseAuth!.signInAnonymously();

      String token = await signUpAnon.user!.getIdToken();

      sharedPreferences!.setString("token", token);
      tokenId = token;
    } catch (e) {}
  }

  Future signout() async {
    sharedPreferences!.remove("token");
    await _firebaseAuth!.signOut();

    await signUpAnonymous();
  }
}
