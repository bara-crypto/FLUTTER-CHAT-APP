import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './error_printer.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Map currentUserData = {};
  String DATABASE_SEARCH = 'users';
  String error = '';

  FirebaseService();

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = _userCredential.user!.uid;
      String filename =
          Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);

      UploadTask task = _storage.ref('image/$uid/$filename').putFile(image);

      return task.then((snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();
        print(
          "${ErrorPrinter.green} $downloadURL $error ${ErrorPrinter.RST()}",
        );
        await _db.collection(DATABASE_SEARCH).doc(uid).set({
          "name": name,
          "email": email,
          "image": image,
        });

        return true;
      });
    } catch (err) {
      error += err.toString();
      print("${ErrorPrinter.red} Error: $error ${ErrorPrinter.RST()}");
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_userCredential.user != null) {
        currentUserData = await getUserData(uid: _userCredential.user!.uid);
        print("${ErrorPrinter.green} Logged in $error ${ErrorPrinter.RST()}");
        return true;
      } else {
        print(
          "${ErrorPrinter.red} Invalid Username $error ${ErrorPrinter.RST()}",
        );
        return false;
      }
    } catch (e) {
      error += e.toString();
      print("${ErrorPrinter.red} Error: $error ${ErrorPrinter.RST()}");
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot doc = await _db.collection(DATABASE_SEARCH).doc(uid).get();
    return doc.data() as Map;
  }
}
