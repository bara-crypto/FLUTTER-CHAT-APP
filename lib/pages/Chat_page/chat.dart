// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
//-------------CHAT   WORKS ---------------------//
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:instagram/pages/Designer_class_I/shadow.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
//------------ErrorPrinter   WORKS --------------//
import 'package:instagram/pages/Login_page/login.dart';
//-----------------------------------------------//

class ChatPage extends StatefulWidget {
  late Map<String, dynamic> userToChatMap = {};
  ChatPage({super.key, required this.userToChatMap});

  @override
  State<StatefulWidget> createState() => ChatPageUI();
}

class ChatPageUI extends State<ChatPage> {
  late double width, height;
  late List<types.Message> messagesFromUser1 = [];
  late List<types.Message> messagesFromUser2 = [];
  late List<types.Message> all = [];

  late types.User user_1;
  late types.User user_2;
  late types.User userSelected;

  Map<String, dynamic> map_1 = {
    'id': "user-1",
    'name': "jai krishna",
    'isSelected': true,
  };
  Map<String, dynamic> map_2 = {
    'id': "user-2",
    'name': "sanjay krishna",
    'isSelected': false,
  };

  List<types.Message> allMessage() {
    all = [...messagesFromUser1, ...messagesFromUser2];
    all.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return all;
  }

  void send(types.PartialText message) {
    try {
      final newMessage = types.TextMessage(
        author: userSelected,
        id: const Uuid().v4(),
        text: message.text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      setState(() {
        if (user_1.firstName == userSelected.firstName) {
          messagesFromUser1.add(newMessage);
          allMessage();
        } else if (user_2.firstName == userSelected.firstName) {
          messagesFromUser2.add(newMessage);
          allMessage();
        } else {
          debugPrint(
            "${ErrorPrinter.red}Error from send() -1 ${ErrorPrinter.reset}",
          );
        }
      });
    } catch (e) {
      debugPrint(
        "${ErrorPrinter.red}Error from send() -2 ${ErrorPrinter.reset}",
      );
    }
  }

  void userset(Map<String, dynamic> user1, Map<String, dynamic> user2) {
    user_1 = types.User(id: user1["id"]!, firstName: user1["name"]);
    user_2 = types.User(id: user2["id"]!, firstName: user2["name"]);
    userSelected = (user1["isSelected"] == true) ? user_1 : user_2;
  }

  @override
  void initState() {
    super.initState();
    userset(map_1, map_2);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //return Scaffold(appBar: chatAppBar(), body: ChatUI());
    return ChatUI();
  }

  AppBar chatAppBar() {
    const imageURL = "assets/images/drawer-assets/smily-3dperson.png";
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: CircleAvatar(
        radius: 20,
        child:
            (widget.userToChatMap["imageIsAsset"])
                ? Image.asset(imageURL)
                : Image.network(widget.userToChatMap[imageURL]),
      ),
      title: Text(widget.userToChatMap["name"]),
      actions: [Icon(Icons.menu)],
      toolbarHeight: (height * 0.5) * 0.2,
    );
  }

  Widget ChatUI() {
    return Chat(
      messages: allMessage(),
      onSendPressed: send,
      user: userSelected,
      showUserAvatars: true,
      showUserNames: true,
      theme: Themer.ChatTheme(width, 0.06),
    );
  }
}

class Themer {
  static DefaultChatTheme ChatTheme(double width, double radius) {
    return DefaultChatTheme(
      inputBackgroundColor: Colors.transparent,
      inputTextColor: Colors.black,
      inputTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      receivedMessageBodyTextStyle: TextStyle(
        backgroundColor: Colors.grey,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      sentMessageBodyTextStyle: TextStyle(
        backgroundColor: Colors.blue,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      primaryColor: Colors.blue,
      inputMargin: EdgeInsets.all(20),
      inputContainerDecoration: shadow.boxshadowForAppBar(
        width,
        0.03,
        1,
        1,
        color: Color.fromARGB(197, 244, 237, 237),
        //color: Color.fromARGB(202, 243, 241, 241),//color:  Color.fromARGB(197, 244, 237, 237),color: Color.fromARGB(220, 243, 241, 241),
        blurRadius_1: 3,
        blurRadius_2: 3,
        spreadRadius_1: 1,
        spreadRadius_2: 1,
      ),
    );
  }
}
