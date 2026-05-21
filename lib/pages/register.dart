import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/Login_page/login.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterClass();
}

//"assets/images/f_image_resized.PNG"
class RegisterClass extends State<Register> {
  late double height, width;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String username = "", password = "", email = "";
  final TextEditingController ctrlName = TextEditingController();
  final TextEditingController ctrlEmail = TextEditingController();
  final TextEditingController ctrlPass = TextEditingController();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(child: buildUI());
  }

  Widget buildUI() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [imageUI(), finstagramUI()]),
            formFieldGenerator(),
          ],
        ),
      ),
    );
  }

  Widget imageUI() {
    var imagePath =
        (imageFile != null)
            ? FileImage(imageFile!)
            : const AssetImage("assets/images/f_image_resized.PNG");

    return Center(
      child: GestureDetector(
        child: Container(
          width: width * 0.43,
          height: height * 0.43,
          decoration: BoxDecoration(
            image: DecorationImage(image: imagePath as ImageProvider),
          ),
        ),
      ),
    );
  }

  Widget finstagramUI() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "F",
            style: TextStyle(
              color: Colors.brown,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: "instagram",
            style: TextStyle(
              color: Colors.brown,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget formFieldGenerator() {
    return Form(
      key: formkey,
      child: Column(
        children: [
          fieldGenerator(true, "username"),
          SizedBox(width: 1, height: height * 0.01),
          fieldGenerator(true, null),
          SizedBox(width: 1, height: height * 0.01),
          fieldGenerator(false, null),
          SizedBox(width: 1, height: height * 0.08),
          buttonUI(),
        ],
      ),
    );
  }

  Widget fieldGenerator(bool usercode, String? name) {
    return Container(
      width: width * 0.75,
      child: TextFormField(
        controller:
            (name != null) ? ctrlName : (usercode ? ctrlEmail : ctrlPass),
        decoration: InputDecoration(
          labelText: (name != null) ? name : (usercode ? "email" : "password"),
          labelStyle: TextStyle(color: Colors.brown, fontSize: 16),
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
          } else if (value.length > 8 && !usercode) {
            return "password should be less than 8";
          } else if (!regex.hasMatch(value) && usercode && name == null) {
            return "email is invalid";
          }

          return null;
        },
        onSaved: (value) {
          setState(() {
            if (name != null) {
              username = ctrlName.text;
            } else if (usercode) {
              email = ctrlEmail.text;
            } else {
              password = ctrlPass.text;
            }
            print("Username $username = Email $email = password: $password");
          });
        },
      ),
    );
  }

  Widget buttonUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.5),
            borderRadius: BorderRadius.circular(width * 0.05),
          ),
          child: MaterialButton(
            minWidth: width * 0.6,
            child: Text(
              "SIGN UP",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () async {
              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                ctrlName.clear();
                ctrlEmail.clear();
                ctrlPass.clear();
                Navigator.popAndPushNamed(context, "login");
                print("${ErrorPrinter.green}validated ${ErrorPrinter.reset}");
              } else {
                print(
                  "${ErrorPrinter.red} not validated ${ErrorPrinter.reset}",
                );
              }
            },
          ),
        ),
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
      ],
    );
  }
}
