import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:instagram/pages/Designer_class_I/shadow.dart';

import 'package:instagram/pages/Login_page/firebase_login_signup.dart';

import 'package:provider/provider.dart';

/* Get It & Gsheet */

// import 'dart:convert';
// import 'package:get_it/get_it.dart';
// import 'package:provider/provider.dart';

// /* Gsheet work  */

// import 'package:instagram/pages/Gsheet_class_I/Gsheet_access.dart';
// import 'package:instagram/pages/Gsheet_class_I/credentials_initial.dart';
// import 'package:instagram/pages/home.dart';

/* --------------- */

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginClass();
}

class ErrorPrinter {
  static final red = '\x1B[31m', green = '\x1B[32m', reset = '\x1B[0m';
}

class LoginClass extends State<Login> {
  //Login
  final formKey = GlobalKey<FormState>();
  final TextEditingController ctrlName = TextEditingController();
  final TextEditingController ctrlPass = TextEditingController();
  late String username = '', password = '';
  late bool isvalid = false;

  //Carousel slider
  late CarouselSliderController carouselController = CarouselSliderController();

  //Common
  late int currentIndex = 0;
  late String tickerLogSign = '';
  late List<TextSpan> tickerSwitch = [];
  late double height, width;

  //Sign up
  final GlobalKey<FormState> signformkey = GlobalKey<FormState>();
  late String signusername = "", signpassword = "", signemail = "";
  final TextEditingController signctrlName = TextEditingController();
  final TextEditingController signctrlEmail = TextEditingController();
  final TextEditingController signctrlPass = TextEditingController();

  //late String gsheeturl = "";
  //late Map<dynamic, dynamic> gsheetid = {};

  /*
  @override
  void initState() {
    super.initState();
    CredentialsInitial object = GetIt.instance.get<CredentialsInitial>();
    // ignore: unused_local_variable
    Map map = jsonDecode(object.strAssetCredential);
    gsheeturl = SetCredential.getUrl(map);
    gsheetid = SetCredential.getID(map);

    ChangeNotifierProvider(
      create:
          (_) =>
              GsheetLoginConvert(username: "sanjay")
                ..loginSetter(gsheetid.toString(), gsheeturl, "title"),
      child: Home(),
    );
  }*/

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPass.dispose();
    signctrlEmail.dispose();
    signctrlName.dispose();
    signctrlPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(child: Stack(children: [buildUI()])),
    );

    // return Container(
    //   width: double.infinity,
    //   height: double.infinity,
    //   decoration: BoxDecoration(color: Colors.grey[300]),
    //   child: SingleChildScrollView(child: Stack(children: [buildUI()])),
    // );
  }

  Widget buildUI() {
    tickerLogSign = currentIndex == 0 ? " Log in " : "Sign up";
    tickerSwitch =
        currentIndex == 0
            ? [
              TextSpan(
                text: "not have one?  ",
                style: TextStyle(color: Colors.brown, fontSize: 16.5),
              ),
              TextSpan(
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        carouselController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                        );
                        setState(() => currentIndex = 1);
                      },
                text: "create new",
                style: TextStyle(
                  color: const Color.fromARGB(255, 35, 132, 205),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color.fromARGB(255, 35, 132, 205),
                  decorationThickness: 2.5,
                  fontSize: 16.5,
                ),
              ),
            ]
            : [
              TextSpan(
                text: "Already Have one?  ",
                style: TextStyle(color: Colors.brown, fontSize: 16.5),
              ),
              TextSpan(
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        carouselController.animateToPage(
                          0,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                        );
                        setState(() => currentIndex = 0);
                      },
                text: "log in",
                style: TextStyle(
                  color: const Color.fromARGB(255, 35, 132, 205),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color.fromARGB(255, 35, 132, 205),
                  decorationThickness: 2.5,
                  fontSize: 16.5,
                ),
              ),
            ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(left: width * 0.1),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeInBack,

                transitionBuilder:
                    (child, animation) => FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    ),
                child: Text(
                  tickerLogSign,
                  key: ValueKey(tickerLogSign),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.09),
              child: Image.asset(
                "assets/images/f_image_resized.PNG",
                width: width * 0.3,
                height: height * 0.3,
              ),
            ),
          ],
        ),

        carosel_builder(),

        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.025),
          child: Text.rich(TextSpan(children: tickerSwitch)),
        ),
      ],
    );
  }

  Widget insideDetails(Color color, bool signup) {
    /*return Container(
      width: width * 0.86, //0.84
      height: height * 0.55,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.35),
        border: Border.all(
          color: const Color.fromARGB(166, 255, 255, 255),
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(width * 0.06),
      ),
      alignment: Alignment.center,
      child: Form(
        key: signup ? signformkey : formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              signup
                  ? [
                    fieldGenerator(true, "username"),
                    fieldGenerator(true, null),
                    fieldGenerator(false, null),
                    buttonsign(),
                  ]
                  : [textFieldUI(false), textFieldUI(true), buttonUI()],
        ),
      ),
    );*/
    /*return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.06),
      child: Container(
        width: width * 0.86,
        height: height * 0.55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          //color: Colors.white.withOpacity(0.3),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white60, Colors.white10],
          ),
          borderRadius: BorderRadius.circular(width * 0.06),
          border: Border.all(width: 2, color: Colors.white30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Form(
            key: signup ? signformkey : formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  signup
                      ? [
                        fieldGenerator(true, "username"),
                        fieldGenerator(true, null),
                        fieldGenerator(false, null),
                        buttonsign(),
                      ]
                      : [textFieldUI(false), textFieldUI(true), buttonUI()],
            ),
          ),
        ),
      ),
    );*/

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.015),
        width: width * 0.86,
        decoration: shadow.boxshadow(width, 0.06, 7, -4),

        child: Form(
          key: signup ? signformkey : formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                signup
                    ? [
                      fieldGenerator(true, "username"),
                      fieldGenerator(true, null),
                      fieldGenerator(false, null),
                      buttonsign(),
                    ]
                    : [textFieldUI(false), textFieldUI(true), buttonUI()],
          ),
        ),
      ),
    );
  }

  Widget textFieldUI(bool passcode) {
    return Container(
      width: (width * 0.7) * 0.9,
      child: TextFormField(
        controller: passcode ? ctrlPass : ctrlName,
        decoration: InputDecoration(
          labelText: passcode ? "password" : "email",
          labelStyle: TextStyle(
            color: Colors.brown,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.brown, width: 1.5),
          ),
        ),
        obscureText: passcode ? true : false,
        validator: (value) {
          final regex = RegExp(
            "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$",
          );
          if (value!.length < 4) {
            return "please enter more than 3 char";
          } else if (value.length > 12 && passcode) {
            return "password should be less than 12";
          } else if (!regex.hasMatch(value) && !(passcode)) {
            return "email is invalid";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {
            if (passcode) {
              password = ctrlPass.text;
            } else {
              username = ctrlName.text;
            }
            print("Username $username = password: $password");
          });
        },
      ),
    );
  }

  Widget buttonUI() {
    return Container(
      decoration: shadow.boxshadow(width, 0.025, 4, -4),
      child: MaterialButton(
        minWidth: (width * 0.7) * 0.9,
        height: (height * 0.55) * 0.1,
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.brown, fontSize: 16),
        ),
        onPressed: () async {
          isvalid = formKey.currentState!.validate();

          if (isvalid) {
            formKey.currentState!.save();

            //  Login   //
            final FirebaseLoginAndSignUp firebaseInstance =
                Provider.of<FirebaseLoginAndSignUp>(context, listen: false);

            try {
              await firebaseInstance.login(email: username, password: password);
              print("${ErrorPrinter.green} Logged in ${ErrorPrinter.reset} ");
            } catch (e) {
              print('${ErrorPrinter.red}$e${ErrorPrinter.reset}');
            }
            //---------//

            ctrlName.clear();
            ctrlPass.clear();

            print("${ErrorPrinter.green} validated ${ErrorPrinter.reset}");
          } else {
            print("${ErrorPrinter.red} not validated ${ErrorPrinter.reset}");
          }
        },
      ),
    );
  }

  Widget carosel_builder() {
    final List<Widget> stackWidget = [
      insideDetails(Color.fromARGB(255, 142, 103, 89), false),
      insideDetails(Color.fromARGB(255, 142, 103, 89), true),
    ];

    return CarouselSlider.builder(
      carouselController: carouselController,
      itemCount: stackWidget.length,
      itemBuilder: (context, index, realIndex) {
        return stackWidget[index];
      },
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
        enlargeFactor: 0.5,
        height: height * 0.55,
        padEnds: false,
        onPageChanged: (index, reason) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }

  //  ------------------------------------------------------------------------------------------------------------------------//
  //  ------------------------------------------------------------------------------------------------------------------------//

  Widget fieldGenerator(bool usercode, String? name) {
    return Container(
      width: (width * 0.7) * 0.9,
      child: TextFormField(
        controller:
            (name != null)
                ? signctrlName
                : (usercode ? signctrlEmail : signctrlPass),
        decoration: InputDecoration(
          labelText: (name != null) ? name : (usercode ? "email" : "password"),
          labelStyle: TextStyle(
            color: Colors.brown,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
          ),
        ),
        obscureText: usercode ? false : true,
        validator: (value) {
          final regex = RegExp(
            "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$",
          );
          if (value!.length < 4) {
            return "please enter more than 3 letter";
          } else if (value.length > 10 && name != null) {
            return "username should be less than 10";
          } else if (value.length > 12 && !usercode) {
            return "password should be less than 8";
          } else if (!regex.hasMatch(value) && usercode && name == null) {
            return "email is invalid";
          }

          return null;
        },
        onSaved: (value) {
          setState(() {
            if (name != null) {
              signusername = signctrlName.text;
            } else if (usercode) {
              signemail = signctrlEmail.text;
            } else {
              signpassword = signctrlPass.text;
            }
            print(
              "Username $signusername = Email $signemail = password: $signpassword",
            );
          });
        },
      ),
    );
  }

  Widget buttonsign() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: shadow.boxshadow(width, 0.03, 4, -4),
          child: MaterialButton(
            minWidth: width * 0.6,
            child: Text(
              "SIGN UP",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () async {
              if (signformkey.currentState!.validate()) {
                signformkey.currentState!.save();

                //  Sign up  //
                final FirebaseLoginAndSignUp firebaseInstance =
                    Provider.of<FirebaseLoginAndSignUp>(context, listen: false);

                try {
                  await firebaseInstance.signin(
                    name: signusername,
                    email: signemail,
                    password: signpassword,
                  );

                  signctrlName.clear();
                  signctrlEmail.clear();
                  signctrlPass.clear();

                  carouselController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                  );

                  print(
                    "${ErrorPrinter.green} Signed in ${ErrorPrinter.reset} ",
                  );
                } catch (e) {
                  print('${ErrorPrinter.red}$e${ErrorPrinter.reset}');
                }
              }
            },
          ),
        ),
        /*
        Padding(
          padding: EdgeInsets.all(20),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Already Have one?  ",
                  style: TextStyle(color: Colors.brown, fontSize: 16.5),
                ),
                TextSpan(
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'login');
                        },
                  text: "log in",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 35, 132, 205),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color.fromARGB(255, 35, 132, 205),
                    decorationThickness: 2.5,
                    fontSize: 16.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        */
      ],
    );
  }

  //  ------------------------------------------------------------------------------------------------------------------------//
  //  ------------------------------------------------------------------------------------------------------------------------//
}
