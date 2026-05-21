//-------------------Material Package-------------------------//
import 'dart:io';

import 'package:flutter/material.dart';

//-------------------Service && Home Page-------------------------//
import 'package:flutter/services.dart';
import 'package:instagram/pages/firebase_service/auth_gate.dart';

//-------------------Login Page-------------------------//

//import 'package:instagram/pages/Login_page/login.dart';
//import 'package:instagram/pages/register.dart';

import 'package:instagram/pages/Login_page/firebase_login_signup.dart';

//-------------------State Management-------------------------//
import 'package:get_it/get_it.dart';
import 'package:instagram/pages/firebase_service/file_picker_service.dart';
import 'package:provider/provider.dart';

//-------------------GSheet Package-------------------------//
import 'package:instagram/pages/Gsheet_class_I/credentials_initial.dart';

//-------------------FireBase Package-------------------------//
import 'package:firebase_core/firebase_core.dart';

//-------------------Search Package-------------------------//
import 'package:instagram/pages/firebase_service/search_service.dart';

//--------------------Profile Package------------------------//
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final currentDir = await getApplicationDocumentsDirectory();
  final hivePath = "${currentDir.path}/hiveBox";
  final hiveDir = Directory(hivePath);
  if (!hiveDir.existsSync()) {
    await hiveDir.create(recursive: true);
  }
  Hive.init(hivePath);

  await Hive.openBox("ProfileImageStorage");

  await Firebase.initializeApp();

  String credential = await rootBundle.loadString(
    "assets/config/gsheet_config.json",
  );

  GetIt.instance.registerSingleton<CredentialsInitial>(
    CredentialsInitial(data: credential),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseLoginAndSignUp()),
        ChangeNotifierProvider(create: (context) => SearchService()),
        ChangeNotifierProvider(create: (context) => FilePickerService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Outfit',
      ), //'EduSAHand'
      /*
      initialRoute: 'auth',
      routes: {
        'auth': (context) => AuthGate(),
        'login': (context) => Login(),
        'register': (context) => Register(),
        'home': (context) => Home(),
      },*/
      home: AuthGate(),
      //home: Home(),
    );
  }
}
