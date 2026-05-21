import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
/* shadow class */
import 'package:instagram/pages/Designer_class_I/shadow.dart';
import 'package:instagram/pages/Designer_class_I/DRAWER.dart';
import 'package:instagram/pages/Gsheet_class_I/credentials_initial.dart';
/* main pages */
import 'package:instagram/pages/main_pages/profile.dart';
import 'package:instagram/pages/main_pages/search.dart';
import 'package:instagram/pages/main_pages/People_contact.dart/upload.dart';
/* GsheetAccess  */
import 'package:instagram/pages/Gsheet_class_I/Gsheet_access.dart';
/* Firebase Access */
import 'package:instagram/pages/Login_page/firebase_login_signup.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  late bool isLoggedin;

  Home({super.key, bool? loggedIn}) {
    isLoggedin = (loggedIn == null || loggedIn == false) ? false : true;
  }

  @override
  State<StatefulWidget> createState() => HomePage();
}

class HomePage extends State<Home> {
  late double _width = 0;
  late double _height = 0;
  late int _navigationIndex = 0;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> pages = [Upload(), Search(), Profile()];

  late String gsheeturl = "";
  late Map<dynamic, dynamic> gsheetid = {};

  late Future<bool> gconvert;

  @override
  void initState() {
    super.initState();

    if (widget.isLoggedin) {
      CredentialsInitial object = GetIt.instance.get<CredentialsInitial>();
      Map map = jsonDecode(object.strAssetCredential);
      gsheeturl = SetCredential.getUrl(map);
      gsheetid = SetCredential.getID(map);
      gconvert = GsheetLoginConvert(
        username: "sanjay",
      ).loginSetter(jsonEncode(gsheetid), gsheeturl, "Details");
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: ArtificalDrawer.drawerScheme(
          _width,
          _height,
          context: context,
          username: FirebaseLoginAndSignUp().getCurrentUserName(),
          email: FirebaseLoginAndSignUp().getCurrentUserEmail(),
        ),
        body: buildUI(),
        bottomNavigationBar: navigationBar(),
      ),
    );
  }

  Widget buildUI() {
    return Stack(
      children: [
        pages[_navigationIndex],
        Align(alignment: Alignment.topCenter, child: artificialAPPBAR()),
      ],
    );
  }

  Widget navigationBar() {
    /*return BottomNavigationBarTheme(
      data: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        selectedIconTheme: IconThemeData(size: 30, color: Colors.blue),
        unselectedIconTheme: IconThemeData(size: 24, color: Colors.brown),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.brown,
      ),
      child: BottomNavigationBar(
        currentIndex: _navigationIndex,
        items: [
          BottomNavigationBarItem(label: 'upload', icon: Icon(Icons.feed)),
          BottomNavigationBarItem(label: 'search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(
            label: 'profile',
            icon: Icon(Icons.account_box),
          ),
        ],
        onTap: (int value) {
          setState(() {
            _navigationIndex = value;
          });
        },
      ),
    );*/

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            );
          }

          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: _navigationIndex,
        onDestinationSelected:
            (value) => setState(() => _navigationIndex = value),
        indicatorColor: Colors.blue.shade100,
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.home_filled), label: "Home"),
          NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          NavigationDestination(icon: Icon(Icons.group), label: "Account"),
        ],
      ),
    );
  }

  Widget artificialAPPBAR() {
    return Container(
      decoration: shadow.boxshadowForAppBar(
        _width,
        0.03,
        1,
        1,
        color: Color.fromARGB(220, 243, 241, 241),
        //color: Color.fromARGB(202, 243, 241, 241),//color: Color.fromARGB(197, 244, 237, 237),
        blurRadius_1: 3,
        blurRadius_2: 3,
        spreadRadius_1: 5,
        spreadRadius_2: 5,
      ),
      margin: EdgeInsets.only(top: (_height * 0.5) * 0.05),
      width: _width * 0.9,
      height: _height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: shadow.boxshadowForMenuIcon(
              _width,
              0.01,
              1,
              1,
              color: Color.fromARGB(220, 243, 241, 241),
              //color: Color.fromARGB(202, 243, 241, 241),//color: Color.fromARGB(197, 244, 237, 237),
              blurRadius_1: 0,
              blurRadius_2: 0,
              //spreadRadius_1: -2,
              //spreadRadius_2: -2,
              border: false,
            ),

            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(_width * 0.04),
                child: Icon(Icons.menu),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: _width * 0.07),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "F",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nunito",
                      letterSpacing: 3,
                    ),
                  ),
                  TextSpan(
                    text: "instagram",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Nunito",
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 60),
        ],
      ),
    );
  }
}
