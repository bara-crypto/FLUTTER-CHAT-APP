// ignore_for_file: must_be_immutable, prefer_initializing_formals

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/firebase_service/self_chat_service.dart';

/*  G  R  O  U  P  E  D  ---  L  I  S  T  */

/*  M  E  S  S  A  G  E */

class SelfChatAppBar_MessageDesign extends StatelessWidget {
  late double width, height;
  late bool isImageAsset;
  late String name;
  late String? ImageURL;

  SelfChatAppBar_MessageDesign({
    double? width,
    double? height,
    bool? isImageAsset,
    String? name,
    String? imageurl,
  }) {
    this.width = (width == null) ? 0 : width;
    this.height = (height == null) ? 0 : height;
    this.isImageAsset = (isImageAsset == null) ? true : isImageAsset;
    this.name = (name == null) ? "" : name;
    ImageURL = (imageurl == null) ? "" : imageurl;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  PreferredSizeWidget chatAppBar(String senderid, String recieverid) {
    const imageURL = "assets/images/drawer-assets/smily-3dperson.png";
    final List<Icon> icons = [
      Icon(Icons.menu_rounded, color: Colors.black38, size: width * 0.065),
      Icon(Icons.more_vert_rounded, color: Colors.black38, size: width * 0.065),
    ];

    return AppBar(
      leadingWidth: width * 0.15,
      leading: Container(
        margin: EdgeInsets.only(left: width * 0.04),
        child: CircleAvatar(
          radius: 13,
          child:
              (isImageAsset) ? Image.asset(imageURL) : Image.network(ImageURL!),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.bold,
          fontSize: width * 0.065,
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: icons.first,
          itemBuilder:
              (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap:
                      () => FirebaseSelfChatPage().DeleteCollections(
                        senderid: senderid,
                        receiverid: recieverid,
                      ),
                  value: "Delete",
                  child: Text(
                    "delete chat",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
        ),
        SizedBox(width: 20),
      ],
      toolbarHeight: (height * 0.5) * 0.2,
      shape: Border(bottom: BorderSide(color: Colors.black45, width: 0.35)),
    );
  }
}
