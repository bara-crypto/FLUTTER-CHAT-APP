/*  F  I  R  E  B  A  S  E -----  D  A  R  T  */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*  D  A  T  A  B  A  S  E ---- S  E  R  V  I  C  E  */
import './database_service.dart';

/*  M  E  S  S  A  G  E ---- S  E  R  V  I  C  E  */
import 'package:instagram/models/Message.dart';
import 'package:instagram/pages/Designer_class_I/ErrorPrinter.dart';

class FirebaseSelfChatPage {
  late FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Chat_main_page_UI userinfo = Chat_main_page_UI();

  String getCurrentUserID() => firebaseAuth.currentUser!.uid;

  Future<void> sendMessage(String receiverID, String message) async {
    final User currentUser = firebaseAuth.currentUser!;
    final String currentUserId = currentUser.uid;
    final String currentUserEmail = currentUser.email!;
    final Timestamp timestamp = Timestamp.now();
    final Message newMessage = Message(
      message: message,
      timestamp: timestamp,
      receiverid: receiverID,
      senderemail: currentUserEmail,
      senderid: currentUserId,
    );
    final List<String> chatRoom = [receiverID, currentUserId];
    chatRoom.sort();
    final String chatRoomID = chatRoom.join("_");

    try {
      await firestore
          .collection("chats")
          .doc(chatRoomID)
          .collection("messages")
          .add(newMessage.MakeChatMap());
    } on FirebaseException catch (firebaseError) {
      print("${ErrorPrinter.red} $firebaseError ${ErrorPrinter.reset}");
    }

    // await firestore
    //     .collection("chats/$chatRoomID/messages")
    //     .add(newMessage.MakeChatMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> GetMessage({
    required String senderid,
    required String receiverid,
  }) {
    List<String> chatRoom = [senderid, receiverid];
    chatRoom.sort();
    String chatRoomid = chatRoom.join("_");

    try {
      return firestore
          .collection("chats")
          .doc(chatRoomid)
          .collection("messages")
          .orderBy('timestamp', descending: false)
          .snapshots();
    } on FirebaseException catch (FirebaseError) {
      print("${ErrorPrinter.red} $FirebaseError ${ErrorPrinter.reset}");
      throw Exception();
    }
  }

  void DeleteCollections({
    required String senderid,
    required String receiverid,
  }) async {
    List<String> chatRoom = [senderid, receiverid];
    chatRoom.sort();
    String chatRoomid = chatRoom.join("_");
    print("deleteing");
    try {
      final snapshot =
          await firestore
              .collection("chats")
              .doc(chatRoomid)
              .collection("messages")
              .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (FirebaseError) {
      print("${ErrorPrinter.red} $FirebaseError ${ErrorPrinter.reset}");
    }
  }
}
