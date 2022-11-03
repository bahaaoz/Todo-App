import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

class FirebaseAuthentication {
  FirebaseAuth? _firebaseAuth;

  FirebaseAuthentication() {
    _firebaseAuth = FirebaseAuth.instance;
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
      print(e.toString());
      return "The email address is already in use by another account";
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final signInResponse = await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);

      sharedPreferences!.setString("user", signInResponse.user!.uid);
      userUID = sharedPreferences!.getString("user");
      sharedPreferences!.setString("type", "real");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future signUpAnonymous() async {
    try {
      final signUpAnon = await _firebaseAuth!.signInAnonymously();

      sharedPreferences!.setString("user", signUpAnon.user!.uid);
      userUID = sharedPreferences!.getString("user");
      sharedPreferences!.setString("type", "anon");
      print("good");
    } catch (e) {
      print("asdasdksamldskm ..............................");
    }
  }

  Future signout() async {
    sharedPreferences!.remove("user");
    await _firebaseAuth!.signOut();

    await signUpAnonymous();
  }
}
