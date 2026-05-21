import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';

//----------Used for ErrorPrinter---------------//
import 'package:instagram/pages/Login_page/login.dart';
//------------------------------------------------//

class GSheetAccess {
  late GSheets? gsheets;
  late Spreadsheet? spreadsheet;
  late Worksheet? worksheet;

  Future<void> setter({String? credential, String? url, String? title}) async {
    try {
      print('Credential: $credential');

      gsheets = GSheets(credential!);

      print('spreadsheet: $url');

      spreadsheet = await gsheets!.spreadsheet(url!);

      print('title: $title');

      worksheet = spreadsheet!.worksheetByTitle(title!);
    } catch (e) {
      debugPrint('${ErrorPrinter.red} setter: $e ${ErrorPrinter.reset}');
    }
  }

  Future<void> addingDetails({required Map<String, dynamic> row}) async {
    // ignore: unused_local_variable
    bool positiveStatus = false;

    try {
      positiveStatus = await worksheet!.values.map.appendRow(row);
    } catch (e) {
      positiveStatus = false;
    }

    debugPrint(
      '${ErrorPrinter.green} adding Details: $positiveStatus ${ErrorPrinter.reset}',
    );
  }
}

class GsheetLoginConvert {
  late String username = "";
  late GSheetAccess gaccess = GSheetAccess();
  late bool status = false;

  GsheetLoginConvert({required this.username});

  Future<bool> loginSetter(String credential, String url, String title) async {
    status = true;
    await gaccess.setter(credential: credential, url: url, title: title);
    await gaccess.addingDetails(
      row: {"username": username, "time": "Logged in at ${DateTime.now()}"},
    );
    status = false;

    return status;
  }
}
