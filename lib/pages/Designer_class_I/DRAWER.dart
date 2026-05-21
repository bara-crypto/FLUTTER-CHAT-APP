import 'package:flutter/material.dart';
import 'package:instagram/pages/Designer_class_I/shadow.dart';
import 'package:instagram/pages/Login_page/firebase_login_signup.dart';

// ignore: must_be_immutable
class ArtificalDrawer extends StatelessWidget {
  static List<String> drawerItemName = [
    "favourite",
    "person",
    "send",
    "logout",
  ];
  static List<Icon> drawerIconData = [
    Icon(Icons.favorite),
    Icon(Icons.person),
    Icon(Icons.send),
    Icon(Icons.logout),
  ];
  static void logout() async {
    final FirebaseLoginAndSignUp firebaseservice = FirebaseLoginAndSignUp();
    firebaseservice.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget drawerScheme(
    double width,
    double height, {
    String? username,
    String? email,
    BuildContext? context,
  }) {
    final String Localuser = (username != null) ? username : "no name";
    final String Localemail = (email != null) ? email : "example@gmail.com";

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/drawer-assets/drawer_bgimage.png",
                ),
              ),
            ),
            accountName: Text(
              Localuser,
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            accountEmail: Text(
              Localemail,
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/drawer-assets/smily-3dperson - edited.png",
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
          ListTile(
            leading: drawerIconData[1],
            title: Text(
              drawerItemName[1],
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ListTile(
            leading: drawerIconData[2],
            title: Text(
              drawerItemName[2],
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Spacer(),
          endDrawerScheme(
            Localuser,
            Localemail,
            width,
            height,
            context: context!,
          ),
        ],
      ),
    );
  }

  static Widget endDrawerScheme(
    String username,
    String email,
    double width,
    double height, {
    BuildContext? context,
  }) {
    return Center(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: AssetImage("assets/images/drawer-assets/drawer_bgimage.png"),
          // ),
          border: Border(top: BorderSide(color: Colors.grey, width: 1.4)),
        ),
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.person_pin, size: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  email,
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  username,
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Container(
              height: 44,
              alignment: Alignment.center,
              decoration: shadow.boxshadowForAppBar(
                width,
                0.03,
                2,
                2,
                blurRadius_1: 1,
                blurRadius_2: 1,
              ),
              child: MaterialButton(
                onPressed: logout,
                child: Text(
                  "logout",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromARGB(255, 58, 70, 234),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
child: ListTile(
        leading: drawerIconData[3],
        title: Text(
          drawerItemName[3],
          style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),

*/
