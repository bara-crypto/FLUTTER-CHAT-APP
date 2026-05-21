// ignore_for_file: non_constant_identifier_names
/* F  I  R  E  B  A  S  E   ---   S  E  R  V  I  C  E */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/* E  R  R  O  R  ---  P  R  I  N  T  E  R */
import 'package:instagram/pages/Designer_class_I/ErrorPrinter.dart';
import 'package:flutter/material.dart';

class SearchService with ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? GetCurrentUserEmail() => firebaseAuth.currentUser!.email;
  String? GetCurrentUserName() => firebaseAuth.currentUser!.displayName;
  String? GetCurrentUserUID() => firebaseAuth.currentUser!.uid;

  Future<List<String>> getUserDetails() async {
    List<String> UserEmail = [];

    QuerySnapshot<Map<String, dynamic>> getUserSnapshot =
        await firestore.collection("users").get();

    for (var variable in getUserSnapshot.docs) {
      if (variable.data()["email"] != GetCurrentUserEmail()) {
        UserEmail.add(variable.data()["email"]);
      }
      //UserEmail.add(variable.data()["email"]);
    }
    notifyListeners();
    return UserEmail;
  }

  Future<bool> Add_Friend(String currentuid, String otheruid) async {
    try {
      var oldFriend = await firestore.collection("users").doc(currentuid).get();

      List<dynamic> friend = oldFriend.data()!["friends"];

      List<String> newUpdatedFriend = [];

      // for (int i = 0; i < friend.length; i++) {
      //   newUpdatedFriend[i] = '${friend[i]}';
      // }
      newUpdatedFriend = [...friend];

      if (newUpdatedFriend.contains(otheruid)) {
        //Checking if Users are already friends
        return false;
      }
      newUpdatedFriend.add(otheruid);

      try {
        await firestore.collection("users").doc(currentuid).update({
          "friends": newUpdatedFriend,
        });

        newUpdatedFriend.clear();
      } catch (updationError) {
        print("${ErrorPrinter.red} $updationError ${ErrorPrinter.reset}");
        throw Exception();
      }

      /* ------------------------------------------------------------------    */

      var oldFriend_other =
          await firestore.collection("users").doc(otheruid).get();
      List<dynamic> otherFriend = oldFriend_other.data()!['friends'];
      List<String> newUpdatedOtherFriend = [];

      // for (int i = 0; i < otherFriend.length; i++) {
      //   newUpdatedOtherFriend[i] = '${otherFriend[i]}';
      // }
      newUpdatedOtherFriend = [...otherFriend];

      newUpdatedOtherFriend.add(currentuid);

      try {
        await firestore.collection("users").doc(otheruid).update({
          "friends": newUpdatedOtherFriend,
        });
        newUpdatedOtherFriend.clear();
      } catch (updationError) {
        print("${ErrorPrinter.red} $updationError ${ErrorPrinter.reset}");
        throw Exception();
      }

      notifyListeners();
      return true;
    } on FirebaseException catch (error) {
      print('${ErrorPrinter.red} $error ${ErrorPrinter.reset}');
      throw Exception();
    }
  }

  Future<List<Map<String, String>>> get_User_With_UID_Email() async {
    List<Map<String, String>> UserEmail = [];

    var getUserSnapshot = await firestore.collection("users").get();

    for (var variable in getUserSnapshot.docs) {
      if (variable.data()["email"] != GetCurrentUserEmail()) {
        UserEmail.add({
          "${variable.data()["email"]}": "${variable.data()["uid"]}",
        });
      }
    }
    notifyListeners();
    return UserEmail;
  }
}
