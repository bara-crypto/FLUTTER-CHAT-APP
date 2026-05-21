import 'package:flutter/material.dart';

/*  M  E  S  S  A  G  E  ---  M  O  D  E  L */
import 'package:instagram/models/Message.dart';
/*  C  U  R  R  E  N  T  ---  U  S  E  R */
import 'package:instagram/pages/firebase_service/self_chat_service.dart';

// ignore: must_be_immutable
class MessageBuilder extends StatelessWidget {
  late Message message;
  late double width = 0, height = 0;
  late String currentUID = FirebaseSelfChatPage().getCurrentUserID();

  MessageBuilder({Message? message, double? width, double? height}) {
    this.message = message!;
    this.width = width!;
    this.height = height!;
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = (currentUID == message.senderid);

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,

      child: GestureDetector(
        onLongPress: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.01,
          ),
          margin: EdgeInsets.only(
            right: isCurrentUser ? width * 0.055 : 0,
            left: isCurrentUser ? 0 : width * 0.055,
            top: height * 0.02,
          ),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue[500] : Colors.transparent,
            border:
                isCurrentUser
                    ? Border.all(width: 0)
                    : Border.all(color: Colors.blue.shade200, width: 1.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft:
                  isCurrentUser ? Radius.circular(12) : Radius.circular(0),
              bottomRight:
                  isCurrentUser ? Radius.circular(0) : Radius.circular(12),
            ),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Text(
                message.message,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.lightBlue,
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${message.timestamp.toDate().hour.toString()}:${message.timestamp.toDate().minute.toString()}",
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                  fontFamily: "Nunito",
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.01,
        ),
        margin: EdgeInsets.only(
          right: isCurrentUser ? width * 0.055 : 0,
          left: isCurrentUser ? 0 : width * 0.055,
          top: height * 0.02,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue[500] : Colors.transparent,
          border:
              isCurrentUser
                  ? Border.all(width: 0)
                  : Border.all(color: Colors.blue.shade200, width: 1.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft:
                isCurrentUser ? Radius.circular(12) : Radius.circular(0),
            bottomRight:
                isCurrentUser ? Radius.circular(0) : Radius.circular(12),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.lightBlue,
                fontFamily: "Nunito",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${message.timestamp.toDate().hour.toString()}:${message.timestamp.toDate().minute.toString()}",
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black,
                fontFamily: "Nunito",
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
*/
