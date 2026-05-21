// ignore_for_file: unused_import

import 'package:flutter/material.dart';

/* C    H    A    T   ---  P    A    G    E  */
import 'package:instagram/pages/Chat_page/chat.dart';
import 'package:instagram/pages/Designer_class_I/LIST.dart';

/*    P  R  O  V  I  D  E  R     */
import 'package:provider/provider.dart';

/*    U  S  E  R  ---   A  C  C  E  S  S     */
import 'package:instagram/pages/firebase_service/database_service.dart';

/*    E  R  R  O  R   ----   P  R  I  N  T  E  R     */
import 'package:instagram/pages/Designer_class_I/ErrorPrinter.dart';

class Upload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UploadClass();
}

class UploadClass extends State<Upload> {
  late Chat_main_page_UI chat = Chat_main_page_UI();
  late ListTileDesigner listtile = ListTileDesigner();
  late double height, width;
  late List<Map<String, dynamic>> friendsList = [];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return buildUpload();
    /*return Expanded(
      child: Column(
        children: [
          buildUpload(),
          FloatingActionButton(
            onPressed: () async {
              final sample = Provider.of<Sample>(context, listen: false);

              await sample.getUsername();

              if (sample.isLoading) {
                print("isloading");
                setState(() {});
              } else {
                user = await sample.getUsername();
                setState(() {});
              }
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );*/
  }

  Widget buildUpload() {
    /*
    return FutureBuilder(
      future: chat.getUsername(),
      builder: (context, sync) {
        switch (sync.connectionState) {
          case ConnectionState.waiting:
            return SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent.shade100,
                ),
              ),
            );
          case ConnectionState.done:
            if (sync.hasData) {
              user = sync.data!;
              return ListView.builder(
                itemCount: user.length,
                itemBuilder: (context, index) {
                  return Container(

                  );
                },
              );
            } else {
              print("no data - error");
              return Container();
            }
          default:
            print("default - error");
            return Container();
        }
      },
    );*/

    /*
    return StreamBuilder(
      stream: chat.ChatWithFriend(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(child: Text(asyncSnapshot.error.toString()));
        }

        if (asyncSnapshot.hasData) {
          print(asyncSnapshot.data!);
          return Text("Got");
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    */

    return StreamBuilder(
      stream: chat.ChatWithFriend(),
      builder: (context, sync) {
        List<Map<dynamic, dynamic>> userDataDynamic = [];
        List<Map<String, dynamic>> userData = [];

        if (sync.hasData) {
          userDataDynamic = sync.data!;
          for (Map<dynamic, dynamic> usermap in userDataDynamic) {
            Map<String, dynamic> convertMap = usermap.map(
              (key, value) => MapEntry(key.toString(), value),
            );
            userData.add(convertMap);
          }
          friendsList = [...userData];

          if (friendsList.isEmpty) {
            print("${ErrorPrinter.red} No friends List ${ErrorPrinter.reset}");

            return SizedBox(
              child: Align(
                alignment: Alignment.center,
                child: Text("No Friends Added", style: TextStyle(fontSize: 20)),
              ),
            );
          }
          return listtile.listTileDesigner(
            friendsList,
            height: height,
            width: width,
            buildContext: context,
          );
        } else if (sync.connectionState == ConnectionState.done &&
            !(sync.hasData)) {
          print("${ErrorPrinter.red} No Sync data ${ErrorPrinter.reset}");
          return SizedBox(
            child: Align(
              alignment: Alignment.center,
              child: Text("No Friends Added", style: TextStyle(fontSize: 20)),
            ),
          );
        } else {
          return Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(left: width * 0.49, top: height * 0.45),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent.shade100,
              ),
            ),
          );
        }
        /*
        switch (sync.connectionState) {
          case ConnectionState.waiting:
            return SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent.shade100,
                ),
              ),
            );

          case ConnectionState.done:
            if (sync.hasError) {
              return Text("${sync.error}");
            } 
            else if (sync.hasData) {
              userData = sync.data!;
              return ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  //return ListTile(title: Text('${userData[index]}'));
                  return listtile.list_tile_designer(userData[index]);
                },
              );
            } 
            else {
              return Text("No data else");
            }

          default:
            return Text("No data default");
        }
        */
      },
    );
  }

  Widget tile(Map<String, dynamic> listItems) {
    String imagePath = "assets/images/drawer-assets/3d-person.png";
    String name = (listItems['name'] != null) ? listItems['name'] : 'Unknown';
    String workplace =
        (listItems['workplace'] != null) ? listItems['workplace'] : 'home';

    return Container(
      alignment: Alignment.center,
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
      ),
    );
  }
}
