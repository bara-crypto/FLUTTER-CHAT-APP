import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instagram/pages/Login_page/firebase_login_signup.dart';

/*  AVATAR  ---  WORKS  */
import 'package:instagram/pages/firebase_service/file_picker_service.dart';
import 'package:provider/provider.dart';

/*  F  I  R  E  B  A  S  E  ---  S  E  R  I  C  E   */
import 'package:instagram/pages/firebase_service/search_service.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileClass();
}

class ProfileClass extends State<Profile> {
  late double width, height;
  late Uint8List uint8list;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: (height * 0.5) * 0.225),
        SingleChildScrollView(child: BuildProfile()),
      ],
    );
  }

  Widget BuildProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.02, left: width * 0.05),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  PhotoURL_Plus_GuestureDetector(),
                  accountDetails(),
                ],
              ),
            ),
          ],
        ),
        Divider(
          indent: width * 0.05,
          endIndent: width * 0.05,
          thickness: 0.95,
          color: Colors.black26,
        ),
        SingleChildScrollView(child: Actions()),
      ],
    );
  }

  Widget PhotoURL_Plus_GuestureDetector() {
    final file = Provider.of<FilePickerService>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        SnackBar snackbar; //SnakBar ScaffoldMessenger;
        TextStyle bar = TextStyle(
          fontFamily: "Rubik",
          fontWeight: FontWeight.bold,
        );
        String result = await file.pickImage();

        if (result == '' || result.isEmpty) {
          snackbar = SnackBar(
            content: Text("Profile Updated", style: bar),
            action: SnackBarAction(
              label: "refresh",
              onPressed: () => setState(() {}),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else {
          snackbar = SnackBar(content: Text(result, style: bar));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: photoURL(),
    );
  }

  Widget photoURL() {
    return FutureBuilder(
      future: FilePickerService().GetImageCode(),
      builder: (context, async) {
        if (async.hasData) {
          if (async.data != null) {
            uint8list = async.data as Uint8List;

            return Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Container(
                width: (width * 0.5) * 0.58,
                height: (((height * 0.5) * 0.5) * 0.5),
                padding: EdgeInsets.all(width * 0.005),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.memory(uint8list, fit: BoxFit.cover),
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Container(
                width: (width * 0.5) * 0.58,
                height: (((height * 0.5) * 0.5) * 0.5),
                padding: EdgeInsets.all(width * 0.005),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(2.5, 2.5),
                      color: Colors.grey.shade400,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    "assets/images/drawer-assets/3d-person.png",
                  ),
                ),
              ),
            );
          }
        }

        return Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: Container(
            width: (width * 0.5) * 0.58,
            height: (((height * 0.5) * 0.5) * 0.5),
            padding: EdgeInsets.all(width * 0.005),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(2.5, 2.5),
                  color: Colors.grey.shade400,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/images/drawer-assets/3d-person.png"),
            ),
          ),
        );
      },
    );
  }

  Widget accountDetails() {
    return Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (SearchService().GetCurrentUserName() != null)
                ? SearchService().GetCurrentUserName()!
                : "No name",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Nunito",
              fontSize: width * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            (SearchService().GetCurrentUserEmail() != null)
                ? SearchService().GetCurrentUserEmail()!
                : "No email",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 140, 255),
              fontFamily: "Nunito",
              fontSize: width * 0.035,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget Actions() {
    final file = Provider.of<FilePickerService>(context, listen: false);
    List<String> title = ["Account", "Avatar", "People", "Language"];
    List<String> subtitle = [
      "change number",
      "Create,edit,profile photo",
      "Manage people",
      "English",
    ];
    TextStyle titleStyle = TextStyle(
      color: Colors.black,
      fontFamily: "Nunito",
      fontWeight: FontWeight.w600,
    );
    TextStyle subtitleStyle = TextStyle(
      color: Colors.black,
      fontFamily: "Nunito",
      fontWeight: FontWeight.w500,
    );
    TextStyle messageStyle = TextStyle(
      color: Colors.white,
      fontFamily: "Nunito",
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );

    return Column(
      children: [
        ListTile(
          title: Text(title[0], style: titleStyle),
          subtitle: Text(
            (SearchService().GetCurrentUserEmail() != null)
                ? SearchService().GetCurrentUserEmail()!
                : "No email",
            style: subtitleStyle,
          ),
          onTap: () {
            final snackBar = SnackBar(
              content: Text("Change Account", style: messageStyle),
              action: SnackBarAction(
                label: 'change',
                onPressed: () async {
                  final signout = Provider.of<FirebaseLoginAndSignUp>(
                    context,
                    listen: false,
                  );
                  await signout.signout();
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
        ListTile(
          title: Text(title[1], style: titleStyle),
          subtitle: Text(subtitle[1], style: subtitleStyle),
          onTap: () async {
            SnackBar snackbar; //SnakBar ScaffoldMessenger;
            TextStyle bar = TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.bold,
            );
            String result = await file.pickImage();

            if (result == '' || result.isEmpty) {
              snackbar = SnackBar(
                content: Text("Profile Updated", style: bar),
                action: SnackBarAction(
                  label: "refresh",
                  onPressed: () => setState(() {}),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            } else {
              snackbar = SnackBar(content: Text(result, style: bar));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
        ),
        ListTile(
          title: Text(title[2], style: titleStyle),
          subtitle: Text(subtitle[2], style: subtitleStyle),
          onTap: () {},
        ),
        ListTile(
          title: Text(title[3], style: titleStyle),
          subtitle: Text(subtitle[3], style: subtitleStyle),
          onTap: () async {},
        ),
      ],
    );
  }
}

/* 
Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Container(
        width: (width * 0.5) * 0.5,
        height: (((height * 0.5) * 0.5) * 0.5),
        padding: EdgeInsets.all(width * 0.005),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(2.5, 2.5),
              color: Colors.grey.shade400,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child:
              isUint8
                  ? Image.memory(imageData)
                  : Image.asset("assets/images/drawer-assets/3d-person.png"),
        ),
      ),
    )*/
