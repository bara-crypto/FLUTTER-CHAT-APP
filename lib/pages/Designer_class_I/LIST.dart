/*  M  A  T  E  R  I  A  L -----  D  A  R  T  */
import 'package:flutter/material.dart';
/* C  H  A  T   ---   P  A  G  E */
//import 'package:instagram/pages/Chat_page/chat.dart';
import 'package:instagram/pages/Chat_page/Self_chat_page.dart';

/* F  I  R  E  B  A  S  E  ---  S  E  R  V  I  C  E */
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class ListTileDesigner extends StatelessWidget {
  late final firebaseAuth = FirebaseAuth.instance;
  late User? user = firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget listTileDesigner(
    List<Map<String, dynamic>> listItems, {
    double? height,
    double? width,
    BuildContext? buildContext,
  }) {
    String imagePath = "assets/images/drawer-assets/3d-person.png";

    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        String name =
            (listItems[index]['name'] == null)
                ? "Unknown"
                : (listItems[index]['name']);
        String workplace =
            (listItems[index]['workplace'] == null)
                ? 'home'
                : listItems[index]['workplace'];

        if (listItems[index]["email"] != user!.email) {
          return Container(
            margin: EdgeInsets.only(
              top:
                  (index == 0)
                      ? ((height! * 0.07) + ((height * 0.5) * 0.05) + 13)
                      : 0,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              ),
            ),

            child: ListTile(
              leading: CircleAvatar(radius: 20, child: Image.asset(imagePath)),
              title: Text(
                name,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                workplace,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlueAccent,
              ),
              onTap: () {
                Navigator.push(
                  buildContext!,
                  MaterialPageRoute(
                    builder:
                        (context) => selfChat(
                          userToChatMap: listItems[index],
                          userWhoChat: user,
                        ),
                    //(context) => ChatPage(userToChatMap: listItems[index]),
                  ),
                );
              },
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(
              top:
                  (index == 0)
                      ? ((height! * 0.07) + ((height * 0.5) * 0.05) + 13)
                      : 0,
            ),
          );
        }
      },
    );
    /*
    return ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.only(top: 13),
                  child: listtile.list_tile_designer(userData[index], index),
                );
              } else {
                return listtile.list_tile_designer(userData[index], index);
              }
            },
          );
          -----------------
    return Container(
      margin: EdgeInsets.only(top: 13),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),

      child: ListTile(
        leading: CircleAvatar(radius: 20, child: Image.asset(imagePath)),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          workplace,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.lightBlueAccent),
        onTap: () {
          //onClick();
        },
      ),
    );*/
  }
}
