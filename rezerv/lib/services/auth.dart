import 'package:firebase_auth/firebase_auth.dart';
import 'package:rezerv/models/UserModel.dart';
import 'package:flutter/material.dart';

class AuthServices {
  //firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user from uid
  UserModel? _userWithFirebaseUserUid(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //create the stream for checking the auth changes in the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
  }

  //sign-in anonymousely
  Future LoginAnonymousely() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (e) {
      print("Error in login anonymousely");
      print(e.toString());
      return null;
    }
  }

  //register using email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //login using email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future LogOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
