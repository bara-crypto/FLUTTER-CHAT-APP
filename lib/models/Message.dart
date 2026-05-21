import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String receiverid;
  late String senderid;
  late String senderemail;
  late String message;
  late Timestamp timestamp;

  Message({
    required this.message,
    required this.timestamp,
    required this.receiverid,
    required this.senderemail,
    required this.senderid,
  });

  Map<String, dynamic> MakeChatMap() {
    return {
      "receiver_id": receiverid,
      "sender_id": senderid,
      "sender_email": senderemail,
      "message": message,
      "timestamp": timestamp,
    };
  }
}

class RemodelMessage {
  Message getInstance(Map<String, dynamic> usermap) {
    return Message(
      message: usermap["message"],
      timestamp: usermap["timestamp"],
      receiverid: usermap["receiver_id"],
      senderemail: usermap["sender_email"],
      senderid: usermap["sender_id"],
    );
  }
}
