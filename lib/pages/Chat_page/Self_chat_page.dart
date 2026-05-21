// ignore_for_file: must_be_immutable
/*  M  A  T  E  R  I  A  L -----  D  A  R  T  */
import 'package:flutter/material.dart';
/*  F  I  R  E  B  A  S  E -----  D  A  R  T  */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/pages/firebase_service/self_chat_service.dart';
/*  A   P   P   ----   B   A   R  */
import './Self_chat_app_bar.dart';
/*  M  E  S  S  A  G  E  ---  M  O  D  E  L */
import 'package:instagram/models/Message.dart';
import 'package:instagram/pages/Designer_class_I/MessageBuilder.dart';

class selfChat extends StatefulWidget {
  late Map<String, dynamic> userToChatMap = {};
  late User? userWhoChat;

  selfChat({super.key, required this.userToChatMap, required this.userWhoChat});

  @override
  State<StatefulWidget> createState() => selfChatPage();
}

// ignore: camel_case_types
class selfChatPage extends State<selfChat> {
  late FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TextEditingController messageController = TextEditingController();
  late double width, height;
  late RemodelMessage messageInstance = RemodelMessage();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: SelfChatAppBar_MessageDesign(
          width: width,
          height: height,
          isImageAsset: widget.userToChatMap["imageIsAsset"],
          name: widget.userToChatMap["name"],
          imageurl: widget.userToChatMap["imageURL"],
        ).chatAppBar(widget.userWhoChat!.uid, widget.userToChatMap["uid"]),
        body: Column(
          children: [Expanded(child: MessageDesignInitial()), MessageBox()],
        ),
        //bottomSheet: MessageBox(),
      ),
    );
  }

  void send() async {
    await FirebaseSelfChatPage().sendMessage(
      widget.userToChatMap["uid"],
      messageController.text,
    );

    setState(() {
      FocusScope.of(context).unfocus();
      messageController.clear();
    });
  }

  Widget MessageBox() {
    return Container(
      width: width * 0.915,
      height: height * 0.09,
      child: TextField(
        controller: messageController,
        decoration: InputDecoration(
          labelText: "Message",
          labelStyle: TextStyle(
            color: const Color.fromARGB(255, 59, 58, 58),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color.fromARGB(255, 215, 210, 210),
          suffixIcon: GestureDetector(
            onTap: () async {
              (messageController.text.trim() != "") ? send() : null;
            },
            child: Icon(Icons.send),
          ),
        ),
      ),
    );
  }

  Widget MessageDesignInitial() {
    return StreamBuilder(
      stream: FirebaseSelfChatPage().GetMessage(
        senderid: widget.userWhoChat!.uid,
        receiverid: widget.userToChatMap["uid"],
      ),

      builder: (context, async) {
        if (async.hasError) {
          return Text(async.error.toString());
        }

        if (async.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<QueryDocumentSnapshot> docs = async.data!.docs;
        bool noMessage = docs.isNotEmpty;

        if (noMessage) {
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final messageMAP = docs[index].data() as Map<String, dynamic>;
              final Message message = messageInstance.getInstance(messageMAP);
              return MessageBuilder(
                message: message,
                width: width,
                height: height,
              );
            },
          );
        } else {
          return Center(
            child: Text("no message", style: TextStyle(fontSize: 20)),
          );
        }
      },
    );
  }
}
