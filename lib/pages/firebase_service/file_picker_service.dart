// ignore_for_file: non_constant_identifier_names

/*    F  I  L  E  ---  P  I  C  K  E  R   */
import 'dart:convert';
import 'dart:typed_data';

/*    H  I  V  E  ---  B  O  X   */
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/*    F  I  L  E  ---  P  I  C  K  E  R   */
import 'package:image_picker/image_picker.dart';

/*  E  R  R  O  R  ---  P  R  I  N  T  E  R   */
import 'package:instagram/pages/Designer_class_I/ErrorPrinter.dart';

class HiveBox {
  static Box get_as_box() {
    return Hive.box("ProfileImageStorage");
  }

  Future<int> ClearBox() async {
    return await Hive.box("ProfileImageStorage").clear();
  }

  Future<void> SetBox(String key, Uint8List value) async {
    await Hive.box("ProfileImageStorage").put(key, value);
  }

  Future<Uint8List> GetBox(String key) async {
    return await Hive.box("ProfileImageStorage").get(key);
  }
}

class FilePickerService with ChangeNotifier {
  late ImagePicker imagePicker = ImagePicker();
  late XFile? imagePicked;
  late Uint8List? base8Code;

  Future<String> pickImage() async {
    try {
      imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);

      if (imagePicked == null) return "No image Picked";

      base8Code = await imagePicked!.readAsBytes();

      try {
        HiveBox box = HiveBox();
        box.SetBox("image", base8Code!);

        notifyListeners();

        return "";
      } catch (pickingerror) {
        print("${ErrorPrinter.red} $pickingerror ${ErrorPrinter.reset}");
        return "Error in Hive upload";
      }
    } catch (pickingerror) {
      print("${ErrorPrinter.red} $pickingerror ${ErrorPrinter.reset}");
      return "Error in imagePicker";
    }
  }

  Future<Uint8List>? GetImageCode() async {
    try {
      HiveBox box = HiveBox();
      Uint8List? byte = await box.GetBox("image");

      notifyListeners();

      return byte;
    } catch (error) {
      print("${ErrorPrinter.red} $error ${ErrorPrinter.reset}");
      throw Exception();
    }
  }

  String Uint8_To_String(Uint8List data) {
    return base64Encode(data);
  }

  Uint8List String_To_Unit8(String data) {
    return base64Decode(data);
  }

  /*
  Future<String> CheckIfImageAsset(String currentuid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);

      if (imagePicked == null) return "No image Picked";

      base8Code = await imagePicked!.readAsBytes();

      try {
        if (base8Code != null) {
          String imageDataString = Uint8_To_String(base8Code!);
          print(imageDataString);

          await firestore.collection("users").doc(currentuid).set({
            "imageURL": imageDataString,
            "imageIsAsset": false,
          });
          return "";
        } else {
          return "No image Picked";
        }
      } catch (pickingerror) {
        print("${ErrorPrinter.red} inn: $pickingerror ${ErrorPrinter.reset}");
        return "Error in Firebase upload";
      }
    } catch (pickingerror) {
      print("${ErrorPrinter.red} out: $pickingerror ${ErrorPrinter.reset}");
      return "Error in image picking";
    }
  }*/
}
