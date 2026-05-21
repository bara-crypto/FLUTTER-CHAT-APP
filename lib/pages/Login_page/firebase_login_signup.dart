import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class FirebaseLoginAndSignUp extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final firebaseDB = FirebaseAuth.instance;

  String? getCurrentUserName() => firebaseDB.currentUser!.displayName;
  String? getCurrentUserEmail() => firebaseDB.currentUser!.email;

  Future<UserCredential> login({required email, required password}) async {
    try {
      UserCredential userCredential = await firebaseDB
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> signin({
    required name,
    required email,
    required password,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      UserCredential userCredential = await firebaseDB
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        await userCredential.user!.reload();

        firestore.collection("users").doc(userCredential.user!.uid).set({
          "uid": userCredential.user!.uid,
          "name": name,
          "email": email,
          "password": password,
          "imageURL": "assets/images/drawer-assets/3d-person.png",
          "friends": [],
          "imageIsAsset": true,
          "work": null,
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signout() async {
    await firebaseDB.signOut();
  }
}
