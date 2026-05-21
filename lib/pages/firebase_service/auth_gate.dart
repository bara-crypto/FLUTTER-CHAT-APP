import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Login_page/login.dart';
import 'package:instagram/pages/home.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return Login();
            }
          },
        );
      },
    );
  }
}
