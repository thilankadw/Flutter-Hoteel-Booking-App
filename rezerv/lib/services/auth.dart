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
        // Fetch user data from Firestore
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userData.exists) {
          // Extract user data from the snapshot
          Map<String, dynamic> userDataMap = userData.data()!;
          String username = userDataMap['username'];
          String firstName = userDataMap['firstName'];
          String lastName = userDataMap['lastName'];
          String email = userDataMap['email'];

          // Create a UserModel instance with fetched data
          return UserModel(
            uid: user.uid,
            username: username,
            firstName: firstName,
            lastName: lastName,
            email: email,
          );
        } else {
          // If the user document doesn't exist, return null
          return null;
        }
      } catch (e) {
        // Handle errors if any
        print("Error fetching user data: $e");
        return null;
      }
    } else {
      // If the user is null, return null
      return null;
    }
  }

  //create the stream for checking the auth changes in the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap((user) async {
      return await _userWithFirebaseUserUid(user);
    });
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

      // Get the Firebase User
      User? user = result.user;

      // Update the user profile with additional details
      await user?.updateDisplayName(username);

      // Create a user document in Firestore with additional details
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      // Return the UserModel
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

  // Get the current user
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
