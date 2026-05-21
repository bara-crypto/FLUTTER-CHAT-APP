import 'package:flutter/widgets.dart';

class CredentialsInitial {
  late Map<String, dynamic> asset_credential = {};
  late String strAssetCredential = "";

  CredentialsInitial({required String? data}) {
    strAssetCredential = (data == null) ? "no data" : data;
  }
}

class SetCredential {
  static printDetails(Map<String, dynamic> map) {
    debugPrint(map.toString());
  }

  static String getUrl(Map<dynamic, dynamic> map) {
    return map["sheet_url"];
  }

  static Map getID(Map<dynamic, dynamic> map) {
    return map['credential'];
  }
}
