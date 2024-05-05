import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rezerv/models/UserModel.dart';
import 'package:flutter/material.dart';

class AuthServices {
  //firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> _userWithFirebaseUserUid(User? user) async {
    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userData.exists) {
          Map<String, dynamic> userDataMap = userData.data()!;
          String username = userDataMap['username'];
          String firstName = userDataMap['firstName'];
          String lastName = userDataMap['lastName'];
          String email = userDataMap['email'];

          return UserModel(
            uid: user.uid,
            username: username,
            firstName: firstName,
            lastName: lastName,
            email: email,
          );
        } else {
          return null;
        }
      } catch (e) {
        print("Error fetching user data: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap((user) async {
      return await _userWithFirebaseUserUid(user);
    });
  }

  Future registerWithEmailAndPassword(
    String username,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      await user?.updateDisplayName(username);

      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      return _userWithFirebaseUserUid(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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

  Future LogOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      return await _userWithFirebaseUserUid(user);
    } catch (e) {
      print("Error getting current user: $e");
      return null;
    }
  }
}
