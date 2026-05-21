/*  F I R E B A S E --- S T O R E  */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*  M A T E R I A L --- P A G E  */
/*----------------------------------------------------------------------------*/

class Chat_main_page_UI {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<List<String>> getUsername() async {
    final list_of_users = await firestore.collection("users").get();
    List<String> user_name_data = [];

    for (var users in list_of_users.docs) {
      if (users.exists) {
        user_name_data.add(users.id);
      }
    }

    return user_name_data;
  }

  String? currentuid() => firebaseAuth.currentUser!.uid;

  Stream<List<Map<String, dynamic>>> GETuserAlone() {
    return firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Stream<List<Map<dynamic, dynamic>>> ChatWithFriend() async* {
    List<dynamic> friendsListdynamic = [];
    List<String> friendsList = [];
    List<Map<dynamic, dynamic>> friendsListDetail = [];

    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await firestore.collection("users").doc(currentuid()).get();
    friendsListdynamic = userDoc.data()!["friends"];
    friendsList = [...friendsListdynamic];

    for (String uid in friendsList) {
      DocumentSnapshot<Map<String, dynamic>> data =
          await firestore.collection("users").doc(uid).get();
      friendsListDetail.add(data.data()!);
    }

    yield friendsListDetail;
  }
}
